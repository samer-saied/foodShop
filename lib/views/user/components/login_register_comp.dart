import 'package:flutter/material.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';

Widget myTextFormField(
    {required TextEditingController textFormController,
    required IconData icon,
    required String labelText,
    required String? Function(String?) validatorFunc}) {
  return TextFormField(
      controller: textFormController,
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: blackColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: blackColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          labelText: labelText),
      validator: validatorFunc);
}
