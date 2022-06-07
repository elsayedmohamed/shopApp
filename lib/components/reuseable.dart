import 'package:flutter/material.dart';
import 'package:shop/styles/constant.dart';

void NavigateAndFinsh({
  required BuildContext context,
  required Widget screen,
}) =>
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));

Widget deaFaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function validate,
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  Function? sufixpress,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: (value) {
        return validate(value);
      },
      decoration: InputDecoration(
        suffixIcon: Icon(suffixIcon),
        border: const OutlineInputBorder(),
        label: Text(label),
        prefixIcon: Icon(prefixIcon),
      ),
      onTap: sufixpress != null ? sufixpress() : null,
    );

Widget dafaultButton({required String text, required Function onpressed}) =>
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
