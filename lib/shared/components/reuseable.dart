import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/styles/constant.dart';

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
  required Function onSubmit,
  required TextEditingController controller,
  required TextInputType type,
  required Function validate,
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  // Function? sufixpress,
  bool isPassword = false,
  Function? suffixPress,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit(),
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
                onPressed: suffixPress!(),
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
  required Function onpressed,
  required String text,
}) =>
    TextButton(
      onPressed: onpressed(),
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
  required Function? function,
}) =>
    Container(
      color: background,
      width: width,
      child: MaterialButton(
        onPressed: function!(),
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
