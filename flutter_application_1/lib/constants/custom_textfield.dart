import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextInputType textInputTypeee;
  final String hinttexttt;
  final bool isPassword;
  const MyTextField({
    Key? key,
    required this.textInputTypeee,
    required this.hinttexttt,
    required this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputTypeee,
      obscureText: isPassword,
      decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 186, 200, 207),
          enabledBorder:
              OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          hintText: hinttexttt),
    );
  }
}
