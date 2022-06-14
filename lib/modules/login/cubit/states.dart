import 'package:shop/models/shoplogin_model.dart';

abstract class ShopLoginStates {}

class ShopLoginIntialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSucessState extends ShopLoginStates {
  final ShopUserLoginModel loginModel;

  ShopLoginSucessState(this.loginModel);
}

class ShopLoginErorrlState extends ShopLoginStates {
  final String error;

  ShopLoginErorrlState(this.error);
}

class ShopLoginPasswordVisibiltyState extends ShopLoginStates {}
