import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systetica/components/botoes/botao_icon_widget.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/input/campo_texto_widget.dart';
import 'package:systetica/components/loading/loading_animation.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/model/validator/MultiValidatorUsuario.dart';
import 'package:systetica/screen/perfil/perfil_controller.dart';
import 'package:systetica/screen/perfil/view/perfil_form_page.dart';
import 'package:systetica/style/app_colors..dart';

class PerfilFormWidget extends State<PerfilFormPage> {
  final PerfilController _controller = PerfilController();
  final MultiValidatorUsuario _validatorUsuario = MultiValidatorUsuario();
  final _picker = ImagePicker();

  late ScrollController _scrollController;

  Future<void> _adicionarImagem() async {
    XFile? pickedImagem = await _picker.pickImage(source: ImageSource.gallery);
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

  Future<CroppedFile> _funcaoCroppedFile(XFile pickedImagem) async {
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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = (MediaQuery.of(context).size.height);
    double mediaQueryWidth = (MediaQuery.of(context).size.width);
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<Info?>(
          future: _controller.buscarUsuarioEmail(context),
          builder: (context, snapShot) {
            if (!snapShot.hasData) {
              return const LoadingAnimation();
            } else if (snapShot.hasData) {
              if (snapShot.data!.success!) {
                UsuarioDTO usuarioDTO = snapShot.data!.object;
                return Column(
                  children: [
                    IconArrowWidget(
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _controller.formKey,
                          child: Column(
                            children: [
                              sizedBox(height: mediaQueryHeight * 0.02),
                              boxFoto(usuarioDTO.imagemBase64),
                              sizedBox(height: 40),
                              textoEditar(),
                              inputNome(),
                              inputTelefone(),
                              botaoCadastrar(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return erroRequisicao(mediaQueryWidth);
              }
            } else {
              return erroRequisicao(mediaQueryWidth);
            }
          },
        ),
      ),
    );
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

  Container boxFoto(dynamic imagemUsuario) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black.withOpacity(0.6),
            spreadRadius: 2,
          )
        ],
      ),
      child: imgPerfil(imagemUsuario),
    );
  }

  Widget imgPerfil(dynamic image) {
    if (image == null || image == "") {
      return iconErroFoto();
    } else {
      image = base64Decode(image);
      if (image is Uint8List) {
        return circleAvatar(backgroundImage: MemoryImage(image));
      } else {
        return circleAvatar(backgroundImage: FileImage(image));
      }
    }
  }

  CircleAvatar circleAvatar({required ImageProvider backgroundImage}) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      backgroundImage: backgroundImage,
      child: Icon(Icons.add_circle),
    );
  }

  TextAutenticacoesWidget textoEditar() {
    return TextAutenticacoesWidget(
      text: "Editar Perfil",
    );
  }

  CampoTextoWidget inputNome() {
    return CampoTextoWidget(
      labelText: "Nome completo",
      paddingBottom: 0,
      maxLength: 100,
      paddingTop: 14,
      isIconDate: true,
      icon: const Icon(
        Icons.face_rounded,
        color: Colors.black87,
      ),
      controller: _controller.nomeController,
      validator: _validatorUsuario.nomeValidator,
    );
  }

  CampoTextoWidget inputTelefone() {
    return CampoTextoWidget(
      labelText: "Telefone",
      keyboardType: TextInputType.number,
      mask: "(##) #####-####",
      paddingBottom: 0,
      maxLength: 15,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.phone,
        color: Colors.black87,
      ),
      controller: _controller.telefone,
      validator: _validatorUsuario.telefoneValidator,
    );
  }

  BotaoWidget botaoCadastrar() {
    return BotaoWidget(
      paddingTop: 10,
      paddingBottom: 0,
      labelText: "SALVAR",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () {},
    );
  }

  SizedBox sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  // Widgets de erro
  Center erroRequisicao(double mediaQueryWidth) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imagemErro(),
            textoErro(mediaQueryWidth),
          ],
        ),
      ),
    );
  }

  ImagensWidget imagemErro() {
    return ImagensWidget(
      paddingLeft: 0,
      image: "erro.png",
      widthImagem: 340,
    );
  }

  TextAutenticacoesWidget textoErro(double mediaQueryWidth) {
    return TextAutenticacoesWidget(
      paddingLeft: mediaQueryWidth * 0.11,
      paddingRight: mediaQueryWidth * 0.11,
      text: "Oopss...ocorreu algum erro. \nTente novamente mais tarde.",
    );
  }

  Container iconErroFoto() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.redPrincipal,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black.withOpacity(0.6),
            spreadRadius: 2,
          )
        ],
      ),
      child: const Icon(
        Icons.person,
        size: 100,
        color: Colors.white,
      ),
    );
  }
}
