// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class kTextWidget extends StatefulWidget {
  const kTextWidget({super.key, required this.text, required this.decoration});
  final String text;
  final TextDecoration decoration;

  @override
  State<kTextWidget> createState() => _kTextWidgetState();
}

class _kTextWidgetState extends State<kTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      textAlign: TextAlign.center,
      style: TextStyle(

        decoration: widget.decoration,
        fontFamily: 'Quattrocento-Sans',
        fontSize: 20.0,
        color: Colors.white,
        
      ),
    );
  }
}
