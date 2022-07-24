import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/botoes/botao_icon_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/input/campo_data_widget.dart';
import 'package:systetica/components/input/campo_pesquisa_widget.dart';
import 'package:systetica/components/input/campo_texto_widget.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/CidadeDTO.dart';
import 'package:systetica/screen/cadastro_usuario/cadastro_controller.dart';
import 'package:systetica/screen/cadastro_usuario/view/cadastro/cadastro_page.dart';

class CadastroWidget extends State<CadastroPage> {
  final CadastroController controller = CadastroController();
  late ScrollController _scrollController;
  late ScrollController _scrollControllerDropDown;
  final List<CidadeDTO> _topColor = [];
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollControllerDropDown = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollControllerDropDown.dispose();
    super.dispose();
  }

  Future<void> _adicionarImagem() async {
    PickedFile? pickedImagem =
        await _picker.getImage(source: ImageSource.gallery);
    if (pickedImagem != null) {
      setState(
        () {
          File imagem = File(pickedImagem.path);
          controller.imagemBase64 = base64Encode(imagem.readAsBytesSync());
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            IconArrowWidget(
              paddingTop: 5,
              paddingBotton: 5,
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.formKey,
                  child: Column(
                    children: [
                      imageRegistro(),
                      textoAutenticacao(),
                      inputNome(),
                      inputCidade(),
                      inputEmail(),
                      inputCpf(),
                      inputDataNascimento(),
                      inputTelefone(),
                      inputTelefone2(),
                      inputSenha(),
                      inputConfirmaSenha(),
                      botaoFoto(),
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

  ImagensWidget imageRegistro() {
    return ImagensWidget(
      paddingLeft: 20,
      image: "registro.png",
      widthImagem: 200,
    );
  }

  TextAutenticacoesWidget textoAutenticacao() {
    return TextAutenticacoesWidget(
      paddingBottom: 2,
      paddingTop: 2,
      text: "Registrar-se",
    );
  }

  CampoTextoWidget inputNome() {
    return CampoTextoWidget(
      labelText: "Nome",
      paddingBottom: 0,
      maxLength: 100,
      paddingTop: 18,
      isIconDate: true,
      icon: const Icon(
        Icons.face_rounded,
        color: Colors.black87,
      ),
      controller: controller.nomeController,
      validator: controller.nomeValidator,
    );
  }

  CampoDataWidget inputDataNascimento() {
    return CampoDataWidget(
      hintText: 'Data de Nascimento',
      paddingBottom: 0,
      paddingTop: 5,
      onChanged: (String? value) {
        setState(
          () {
            if (value != null) {
              controller.dataNascimentoController.text = value;
            }
          },
        );
      },
      controller: controller.dataNascimentoController,
      validator: controller.dataValidator,
    );
  }

  CampoPesquisaWidget inputCidade() {
    return CampoPesquisaWidget(
      labelText: "Cidade",
      labelSeachText: "Digite nome da cidade",
      icon: const Icon(Icons.location_city),
      objects: _topColor,
      objectAsString: (cidade) => cidade!.nome,
      objectOnFind: (String? cidade) => controller.buscarCidadeFiltro(cidade),
      scrollController: _scrollControllerDropDown,
      onChanged: (value) {
        controller.cidadeDTO = value;
      },
    );
  }

  CampoTextoWidget inputCpf() {
    return CampoTextoWidget(
      labelText: "CPF",
      keyboardType: TextInputType.number,
      mask: "###.###.###-##",
      paddingBottom: 0,
      maxLength: 14,
      paddingTop: 5,
      isIconDate: true,
      icon: const Icon(
        Icons.people,
        color: Colors.black87,
      ),
      controller: controller.cpfController,
      validator: controller.cpfValidator,
    );
  }

  CampoTextoWidget inputTelefone() {
    return CampoTextoWidget(
      labelText: "Telefone 1",
      keyboardType: TextInputType.number,
      mask: "(##) #####-####",
      paddingBottom: 0,
      maxLength: 15,
      paddingTop: 5,
      isIconDate: true,
      icon: const Icon(
        Icons.phone,
        color: Colors.black87,
      ),
      controller: controller.telefone1,
      validator: controller.telefoneValidator,
    );
  }

  CampoTextoWidget inputTelefone2() {
    return CampoTextoWidget(
      controller: controller.telefone2,
      labelText: "Telefone 2",
      keyboardType: TextInputType.number,
      mask: "(##) #####-####",
      paddingBottom: 0,
      maxLength: 15,
      paddingTop: 5,
      isIconDate: true,
      icon: const Icon(
        Icons.phone,
        color: Colors.black87,
      ),
    );
  }

  CampoTextoWidget inputEmail() {
    return CampoTextoWidget(
      labelText: "E-mail",
      paddingBottom: 0,
      maxLength: 80,
      paddingTop: 5,
      isIconDate: true,
      icon: const Icon(
        Icons.email,
        color: Colors.black87,
      ),
      controller: controller.emailController,
      validator: controller.emailValidator,
    );
  }

  CampoTextoWidget inputSenha() {
    return CampoTextoWidget(
      labelText: "Senha",
      maxLength: 16,
      isPassword: true,
      paddingBottom: 0,
      paddingTop: 5,
      controller: controller.senhaController,
      validator: controller.senhaValidator,
    );
  }

  CampoTextoWidget inputConfirmaSenha() {
    return CampoTextoWidget(
      labelText: "Confirmar Senha",
      maxLength: 16,
      isPassword: true,
      paddingBottom: 0,
      paddingTop: 5,
      controller: controller.confirmaSenhaController,
      validator: controller.confirmaSenhaValidator,
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

  BotaoWidget botaoCadastrar() {
    return BotaoWidget(
      paddingTop: 20,
      paddingBottom: 30,
      labelText: "CADASTRAR",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () async {
        await controller.cadastrarUsuario(
          context,
          widget,
        );
      },
    );
  }
}
