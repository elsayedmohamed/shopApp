import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/login/cubit/states.dart';
import 'package:shop/shared/network/dio_helper.dart';
import 'package:shop/shared/network/end_point/end_point.dart';

import '../../../models/shoplogin_model.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginIntialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopUserLoginModel? loginMoedl;
  void userlogIn({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginMoedl = ShopUserLoginModel.fromjson(value.data);
      //print(loginMoedl!.message);

      print(loginMoedl!.data?.token);

      emit(ShopLoginSucessState(loginMoedl!));
    }).catchError((erorr) {
      print(erorr.toString());
      emit(ShopLoginErorrlState(erorr.toString()));
    });
  }

  //=====================================================================

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changeSuffixVisibilty() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopLoginPasswordVisibiltyState());
  }
}
