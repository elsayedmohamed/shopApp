import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/shoplogin_model.dart';
import 'package:shop/modules/layout/shop_app/register/cubit/states.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/network/remote/end_point.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterIntialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopUserLoginModel? loginMoedl;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      loginMoedl = ShopUserLoginModel.fromjson(value.data);

      print(loginMoedl!.data?.token);

      emit(ShopRegisterSucessState(loginMoedl!));
    }).catchError((erorr) {
      print(erorr.toString());
      emit(ShopRegisterErorrlState(erorr.toString()));
    });
  }

  //=====================================================================
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changeSuffixVisibilty() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterPasswordVisibiltyState());
  }
}
