import 'package:shop/models/shoplogin_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterIntialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSucessState extends ShopRegisterStates {
  final ShopUserLoginModel RegisterModel;

  ShopRegisterSucessState(this.RegisterModel);
}

class ShopRegisterPasswordVisibiltyState extends ShopRegisterStates {}

class ShopRegisterErorrlState extends ShopRegisterStates {
  final String error;

  ShopRegisterErorrlState(this.error);
}
