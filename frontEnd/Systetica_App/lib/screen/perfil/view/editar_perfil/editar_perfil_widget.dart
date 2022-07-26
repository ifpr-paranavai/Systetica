import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systetica/components/botoes/botao_icon_widget.dart';
import 'package:systetica/screen/perfil/perfil_controller.dart';
import 'package:systetica/screen/perfil/view/editar_perfil/editar_perfil_page.dart';
import 'package:systetica/style/app_colors..dart';

class EditarPerfilWidget extends State<EditarPerfilPage> {
  final PerfilController _controller = PerfilController();
  final _picker = ImagePicker();

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

  Future<void> _adicionarImagem() async {
    PickedFile? pickedImagem =
        await _picker.getImage(source: ImageSource.gallery);
    if (pickedImagem != null) {
      CroppedFile _croppedFile = await _funcaoCroppedFile(pickedImagem);
      setState(
        () {
          File imagem = File(_croppedFile.path);
          _controller.imagemBase64 = base64Encode(imagem.readAsBytesSync());
        },
      );
    }
  }

  Future<CroppedFile> _funcaoCroppedFile(PickedFile pickedImagem) async {
    CroppedFile? _croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedImagem.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
      ],
      cropStyle: CropStyle.circle,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Recortar',
          toolbarColor: AppColors.bluePrincipal,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          backgroundColor: Colors.white,
          activeControlsWidgetColor: AppColors.redPrincipal,
        ),
        IOSUiSettings(
          title: 'Recortar',
        ),
      ],
    );
    return _croppedFile!;
  }

  BotaoIconWidget botaoFoto() {
    return BotaoIconWidget(
      paddingTop: 5,
      paddingBottom: 0,
      paddingRight: 120,
      labelText: "Foto de Perfil",
      largura: 340,
      fontSize: 18,
      corBotao: Colors.white,
      corTexto: Colors.black,
      corBorda: Colors.blueGrey,
      fontWeight: FontWeight.normal,
      onPressed: () => _adicionarImagem(),
    );
  }
}
