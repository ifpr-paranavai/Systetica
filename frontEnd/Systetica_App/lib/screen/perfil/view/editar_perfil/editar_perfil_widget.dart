import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:systetica/screen/perfil/view/editar_perfil/editar_perfil_page.dart';

class EditarPerfilWidget extends State<EditarPerfilPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(
                      'Editar Perfil',
                      textStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  repeatForever: true,
                  isRepeatingAnimation: true,
                ),
                const SizedBox(
                  height: 80,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Em Construção',
                      cursor: '💡',
                      speed: const Duration(milliseconds: 150),
                      textStyle: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  displayFullTextOnTap: true,
                  stopPauseOnTap: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
