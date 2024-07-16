import 'package:flutter/material.dart';

class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) {
    return FlutterFlowTheme();
  }

  Color get secondaryBackground => Color(0xFFD5D5D5);

  TextStyle get bodyMedium => TextStyle(
        fontFamily: 'Readex Pro',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      );
}
