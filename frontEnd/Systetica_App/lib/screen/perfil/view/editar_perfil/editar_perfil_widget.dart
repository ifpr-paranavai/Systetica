import 'dart:io';

import 'package:flutter/material.dart';
import 'package:systetica/screen/perfil/view/editar_perfil/editar_perfil_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class EditarPerfilWidget extends State<EditarPerfilPage> {
  File? _image;
  PickedFile? _pickedFile;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      setState(() {
        _image = File(_pickedFile!.path);
        final bytes = File(_image!.path).readAsBytesSync();
        String base64Image = base64Encode(bytes);
      });
    }
  }
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 18),
                  child: GestureDetector(
                    child: const Text("Selecione imagem"),
                    onTap: () => _pickImage(),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 200,
                    color: Colors.white,
                    child: _pickedFile != null
                        ? Image.file(
                      File(_pickedFile!.path),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                        : const Text("Selecione uma foto")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
