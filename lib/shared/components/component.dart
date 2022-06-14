import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/styles/constant.dart';

import '../../modules/layout/cubit/cubit.dart';

void NavigateAndFinsh({
  required BuildContext context,
  required Widget screen,
}) =>
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));

void NavigateTo({required BuildContext context, required Widget screen}) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screen));
}

Widget deaFaultFormField({
  Function(String value)? onSubmit,
  required TextEditingController controller,
  required TextInputType type,
  required Function validate,
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  // Function? sufixpress,
  bool isPassword = false,
  Function()? suffixPress,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      validator: (value) {
        return validate(value);
      },
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: suffixPress,
              )
            : null,
        border: const OutlineInputBorder(),
        label: Text(label),
        prefixIcon: Icon(prefixIcon),
      ),
    );

Widget dafaultButton({
  required String text,
  required Function onpressed,
}) =>
    Container(
      color: defaultColor,
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: onpressed(),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

Widget deafaultTextButton({
  required Function() onpressed,
  required String text,
}) =>
    TextButton(
      onPressed: onpressed,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: defaultColor,
        ),
      ),
    );

Widget defaultButton({
  required String text,
  double width = double.infinity,
  required Color background,
  required Function() function,
}) =>
    Container(
      color: background,
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

void ShowToast({
  required String msg,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

Color? chooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;

      break;
    case ToastStates.WARNING:
      return color = Colors.amber;
  }
  return color;
}

Widget buildListProduct(
  model,
  context, {
  bool isOldPrice = true,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: Image(
                    image: NetworkImage(model.image!),
                    width: 120,
                    height: 120,
                  ),
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      model.discount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8.0,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.3,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 3,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        model.price!.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.3,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.oldPrice != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 14,
                            height: 1.3,
                            color: Colors.grey,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavourites(model.id!);
                          print(1);
                        },
                        icon: CircleAvatar(
                          backgroundColor:
                              ShopCubit.get(context).favourites[model.id] ==
                                      true
                                  ? defaultColor
                                  : Colors.grey,
                          radius: 16.0,
                          child: const Icon(
                            Icons.favorite_outline_rounded,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
