import 'package:flutter/material.dart';

class NavbarModel {
  void onUpdate() {}
  void maybeDispose() {}
}

NavbarModel createModel(BuildContext context, NavbarModel Function() param1) {
  return param1();
}
