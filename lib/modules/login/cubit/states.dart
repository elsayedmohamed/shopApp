abstract class ShopLoginStates {}

class ShopLoginIntialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSucessState extends ShopLoginStates {}

class ShopLoginErorrlState extends ShopLoginStates {
  final String error;

  ShopLoginErorrlState(this.error);
}
