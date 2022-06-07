import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/login/cubit/states.dart';
import 'package:shop/shared/network/dio_helper.dart';
import 'package:shop/shared/network/end_point/end_point.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginIntialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

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
      emit(ShopLoginSucessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(ShopLoginErorrlState(erorr.toString()));
    });
  }
}
