import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MyPageTransition {
  pageTransition({
    required Widget child,
    required Widget? childCurrent,
    bool buttoToTop = false,
  }) {
    return PageTransition(
      type: buttoToTop ? PageTransitionType.bottomToTop : PageTransitionType.rightToLeftJoined,
      childCurrent: childCurrent,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
      child: child,
    );
  }
}
