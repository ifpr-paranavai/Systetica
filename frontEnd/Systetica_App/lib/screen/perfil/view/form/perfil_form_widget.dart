import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/input/campo_texto_widget.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/validator/MultiValidatorUsuario.dart';
import 'package:systetica/screen/perfil/perfil_controller.dart';
import 'package:systetica/screen/perfil/view/form/perfil_form_page.dart';
import 'package:systetica/style/app_colors..dart';

class PerfilFormWidget extends State<PerfilFormPage> {
  final PerfilController _controller = PerfilController();
  final MultiValidatorUsuario _validatorUsuario = MultiValidatorUsuario();
  final _picker = ImagePicker();

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller.usuarioDTO = widget.usuarioDTO!;
    _controller.nomeController.text = _controller.usuarioDTO.nome!;
    _controller.telefoneController.text = _controller.usuarioDTO.telefone!;
    _controller.imagemBase64 = _controller.usuarioDTO.imagemBase64!;
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
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                      boxFoto(_controller.imagemBase64),
                      sizedBox(height: mediaQueryHeight * 0.05),
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
        ),
      ),
    );
  }

  Future<void> _adicionarImagem() async {
    XFile? pickedImagem = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImagem != null) {
      CroppedFile _croppedFile = await _funcaoCroppedFile(pickedImagem);
      setState(
        () {
          File imagem = File(_croppedFile.path);
          _controller.imagemBase64 = base64Encode(imagem.readAsBytesSync());
          _controller.imagemAlterada = true;
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
      child: paddingIconEditarFoto(),
    );
  }

  Padding paddingIconEditarFoto() {
    return Padding(
      padding: const EdgeInsets.only(top: 120, left: 120),
      child: SizedBox(
        width: 40,
        height: 40,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.redPrincipal,
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            iconSize: 20,
            color: Colors.white,
            icon: const Icon(
              Icons.edit,
            ),
            onPressed: () => _adicionarImagem(),
          ),
        ),
      ),
    );
  }

  TextAutenticacoesWidget textoEditar() {
    return TextAutenticacoesWidget(
      text: "Editar Perfil",
      fontSize: 30,
      paddingBottom: 6,
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
      paddingTop: 12,
      isIconDate: true,
      icon: const Icon(
        Icons.phone,
        color: Colors.black87,
      ),
      controller: _controller.telefoneController,
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
      onPressed: () => _controller.atualizarUsuarioEmail(context),
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

  Widget iconErroFoto() {
    return Container(
      width: 160,
      height: 160,
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
      child: IconButton(
        icon: const Icon(
          Icons.edit,
          size: 100,
          color: Colors.white,
        ),
        onPressed: () => _adicionarImagem(),
      ),
    );
  }
}
