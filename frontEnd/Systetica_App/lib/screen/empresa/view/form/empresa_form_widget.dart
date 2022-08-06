import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/validator/MultiValidatorEmpresa.dart';
import 'package:systetica/screen/empresa/component/input_empresa.dart';
import 'package:systetica/screen/empresa/empresa_controller.dart';
import 'package:systetica/screen/empresa/view/form/empresa_form_page.dart';
import 'package:systetica/style/app_colors..dart';

class EmpresaFormWidget extends State<EmpresaFormPage> {
  final EmpresaController _controller = EmpresaController();
  final MultiValidatorEmpresa _multiValidatorEmpresa = MultiValidatorEmpresa();
  final InputEmpresa _inputEmpresa = InputEmpresa();
  final _picker = ImagePicker();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller.empresa = widget.empresa!;
    _controller.nomeController.text = _controller.empresa.nome!;
    _controller.telefone1Controller.text = _controller.empresa.telefone1!;
    _controller.telefone2Controller.text = _controller.empresa.telefone2 ?? "";
    _controller.enderecoController.text = _controller.empresa.endereco!;
    _controller.numeroController.text = _controller.empresa.numero.toString();
    _controller.cepController.text = _controller.empresa.cep!;
    _controller.bairroController.text = _controller.empresa.bairro!;
    _controller.logoBase64 = _controller.empresa.logoBase64;
    _controller.cidade = _controller.empresa.cidade!;
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
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: _altura * 0.01,
          onPressed: () => Navigator.pop(context),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _controller.formKey,
            child: Center(
              child: Column(
                children: [
                  _sizedBox(height: _altura * 0.08),
                  _boxFoto(_controller.logoBase64),
                  _sizedBox(height: _altura * 0.07),
                  _textoEditarEmpresa(),
                  _inputEmpresa.inputNomeEmpresa(
                    paddingHorizontal: _largura,
                    controller: _controller,
                    validatorEmpresa: _multiValidatorEmpresa,
                  ),
                  _inputEmpresa.inputTelefone(
                    paddingHorizontal: _largura,
                    controller: _controller,
                    validatorEmpresa: _multiValidatorEmpresa,
                  ),
                  _inputEmpresa.inputTelefone2(
                    paddingHorizontal: _largura,
                    controller: _controller,
                  ),
                  _inputEmpresa.inputEndereco(
                    paddingHorizontal: _largura,
                    controller: _controller,
                    validatorEmpresa: _multiValidatorEmpresa,
                  ),
                  _inputEmpresa.inputNumero(
                    paddingHorizontal: _largura,
                    controller: _controller,
                    validatorEmpresa: _multiValidatorEmpresa,
                  ),
                  _inputEmpresa.inputCep(
                    paddingHorizontal: _largura,
                    controller: _controller,
                    validatorEmpresa: _multiValidatorEmpresa,
                  ),
                  _inputEmpresa.inputBairro(
                    paddingHorizontal: _largura,
                    controller: _controller,
                    validatorEmpresa: _multiValidatorEmpresa,
                  ),
                  _inputEmpresa.inputCidade(
                    cidadeEditar: _controller.cidade,
                    paddingHorizontal: _largura,
                    controller: _controller,
                  ),
                  _inputEmpresa.botaoCadastrar(
                    label: "SALVAR",
                    onPressed: () => _controller.atualizarEmpresa(context).then(
                          (value) => setState(() {}),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextAutenticacoesWidget _textoEditarEmpresa() {
    return TextAutenticacoesWidget(
      text: "Editar Empresa",
      fontSize: 30,
      paddingBottom: 6,
    );
  }

  // Widgets para foto
  Future<void> _adicionarImagem() async {
    XFile? pickedImagem = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImagem != null) {
      CroppedFile _croppedFile = await _funcaoCroppedFile(pickedImagem);
      setState(
        () {
          File imagem = File(_croppedFile.path);
          _controller.logoBase64 = base64Encode(imagem.readAsBytesSync());
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
