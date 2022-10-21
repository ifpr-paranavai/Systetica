import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:systetica/style/app_colors.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  State<LoadingAnimation> createState() => _LoadingAnimation();
}

class _LoadingAnimation extends State<LoadingAnimation> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Carregando dados",
            style: GoogleFonts.lora(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          LoadingAnimationWidget.discreteCircle(
            color: AppColors.blue1,
            secondRingColor: AppColors.redPrincipal,
            thirdRingColor: AppColors.bluePrincipal,
            size: 40,
          ),
        ],
      ),
    );
  }
}
