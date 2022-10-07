import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
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
    _controller.usuario = widget.usuario;
    _controller.nomeController.text = _controller.usuario.nome!;
    _controller.telefoneController.text = _controller.usuario.telefone!;
    _controller.imagemBase64 = _controller.usuario.imagemBase64;
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.of(context).size.height;
    double _largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.branco,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: _altura * 0.01,
          onPressed: () => Navigator.pop(context),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _controller.formKey,
              child: Column(
                children: [
                  _sizedBox(height: _altura * 0.08),
                  _boxFoto(_controller.imagemBase64),
                  _sizedBox(height: _altura * 0.07),
                  _textoEditarPerfil(),
                  _inputNome(paddingHorizontal: _largura),
                  _inputTelefone(paddingHorizontal: _largura),
                  _botaoCadastrar(),
                ],
              ),
            ),
          ),
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

  Container _boxFoto(dynamic imagemUsuario) {
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
      child: _imgPerfil(imagemUsuario),
    );
  }

  Widget _imgPerfil(dynamic image) {
    if (image == null || image == "") {
      return _iconErroFoto();
    } else {
      image = base64Decode(image);
      if (image is Uint8List) {
        return _circleAvatar(backgroundImage: MemoryImage(image));
      } else {
        return _circleAvatar(backgroundImage: FileImage(image));
      }
    }
  }

  CircleAvatar _circleAvatar({required ImageProvider backgroundImage}) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      backgroundImage: backgroundImage,
      child: _paddingIconEditarFoto(),
    );
  }

  Padding _paddingIconEditarFoto() {
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

  TextAutenticacoesWidget _textoEditarPerfil() {
    return TextAutenticacoesWidget(
      text: "Editar Perfil",
      fontSize: 30,
      paddingBottom: 6,
    );
  }

  CampoTextoWidget _inputNome({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "Nome completo",
      paddingHorizontal: paddingHorizontal * 0.08,
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

  CampoTextoWidget _inputTelefone({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "Telefone",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      mask: "(##) #####-####",
      paddingBottom: 0,
      maxLength: 15,
      paddingTop: 12,
      isIconDate: true,
      icon: const Icon(
        Icons.phone_android,
        color: Colors.black87,
      ),
      controller: _controller.telefoneController,
      validator: _validatorUsuario.telefoneValidator,
    );
  }

  BotaoWidget _botaoCadastrar() {
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

  SizedBox _sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  // Widgets de erro
  Widget _iconErroFoto() {
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
