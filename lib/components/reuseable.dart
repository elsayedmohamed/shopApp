import 'package:flutter/material.dart';
import 'package:shop/styles/constant.dart';

void NavigateAndFinsh({
  required BuildContext context,
  required Widget screen,
}) =>
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));

Widget deaFaultFormField({
  required Function onSubmit,
  required TextEditingController controller,
  required TextInputType type,
  required Function validate,
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  Function? sufixpress,
  bool isPassword = false,
  required Function suffixPress,
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
                onPressed: () {},
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
          style: TextStyle(color: Colors.white),
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
        style: TextStyle(
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
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
