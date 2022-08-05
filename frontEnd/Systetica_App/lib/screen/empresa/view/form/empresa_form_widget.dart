import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/input/campo_pesquisa_widget.dart';
import 'package:systetica/components/input/campo_texto_widget.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/validator/MultiValidatorEmpresa.dart';
import 'package:systetica/screen/empresa/empresa_controller.dart';
import 'package:systetica/screen/empresa/view/form/empresa_form_page.dart';

class EmpresaFormWidget extends State<EmpresaFormPage> {
  final EmpresaController _controller = EmpresaController();
  final MultiValidatorEmpresa _validatorEmpresa = MultiValidatorEmpresa();
  final _picker = ImagePicker();
  late ScrollController _scrollController;

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
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }

  TextAutenticacoesWidget _textoCadastrarEmpresa() {
    return TextAutenticacoesWidget(
      text: "Cadastra Empresa",
      fontSize: 30,
      paddingBottom: 6,
    );
  }

  CampoTextoWidget _inputNomeEmpresa({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "Empresa",
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
      validator: _validatorEmpresa.nomeValidator,
    );
  }

  CampoTextoWidget _inputCnpj({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "CNPJ",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      mask: "##.###.###/####-##",
      paddingBottom: 0,
      maxLength: 18,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.credit_card,
        color: Colors.black87,
      ),
      controller: _controller.cnpjController,
      validator: _validatorEmpresa.cnpjValidator,
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
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.phone_android,
        color: Colors.black87,
      ),
      controller: _controller.telefone1Controller,
      validator: _validatorEmpresa.telefone1Validator,
    );
  }

  CampoTextoWidget _inputTelefone2({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "Telefone Fixo",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      mask: "(##) ####-####",
      paddingBottom: 0,
      maxLength: 15,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.phone,
        color: Colors.black87,
      ),
      controller: _controller.telefone2Controller,
    );
  }

  CampoTextoWidget _inputEndereco({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "Endereco",
      paddingHorizontal: paddingHorizontal * 0.08,
      paddingBottom: 0,
      maxLength: 100,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.maps_home_work,
        color: Colors.black87,
      ),
      controller: _controller.enderecoController,
      validator: _validatorEmpresa.enderecoValidator,
    );
  }

  CampoTextoWidget _inputNumero({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "Nº",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      paddingBottom: 0,
      maxLength: 8,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.numbers,
        color: Colors.black87,
      ),
      controller: _controller.numeroController,
      validator: _validatorEmpresa.numeroValidator,
    );
  }

  CampoTextoWidget _inputCep({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "CEP",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      mask: "#####-###",
      paddingBottom: 0,
      maxLength: 9,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.mail,
        color: Colors.black87,
      ),
      controller: _controller.cepController,
      validator: _validatorEmpresa.cepValidator,
    );
  }

  CampoTextoWidget _inputBairro({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "Bairro",
      paddingHorizontal: paddingHorizontal * 0.08,
      paddingBottom: 0,
      maxLength: 100,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.map,
        color: Colors.black87,
      ),
      controller: _controller.bairroController,
      validator: _validatorEmpresa.bairroValidator,
    );
  }


  BotaoWidget _botaoCadastrar() {
    return BotaoWidget(
      paddingTop: 18,
      paddingBottom: 30,
      labelText: "CADASTRAR",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () {},
    );
  }

  SizedBox _sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
