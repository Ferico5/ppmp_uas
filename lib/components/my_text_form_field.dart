import 'package:flutter/material.dart';
// import '../flutter_flow/flutter_flow_theme.dart';

class MyTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final double? width;
  final TextStyle? style; // add the style
  const MyTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.focusNode,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.width,
    this.style, //Add the style to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.sizeOf(context).width * 0.9,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
              fontFamily: 'Lexend',
              fontSize: 17,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
              color: Colors.white),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Lexend',
            fontSize: 15,
            letterSpacing: 0.0,
            color: Colors.white70,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF00A896),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white12,
          contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
          suffixIcon: suffixIcon,
        ),
        style: style ??
            const TextStyle(
              // We use the default color white
                fontFamily: 'Lexend',
                fontSize: 15,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
                color: Colors.white),
      ),
    );
  }
}