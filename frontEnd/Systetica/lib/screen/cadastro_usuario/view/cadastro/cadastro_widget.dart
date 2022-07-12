import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_acao_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/input/campo_data_widget.dart';
import 'package:systetica/components/input/campo_pesquisa_widget.dart';
import 'package:systetica/components/input/campo_texto_widget.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/CidadeDTO.dart';
import 'package:systetica/model/Page_impl.dart';
import 'package:systetica/screen/cadastro_usuario/cadastro_controller.dart';
import 'package:systetica/screen/cadastro_usuario/cadastro_service.dart';
import 'package:systetica/screen/cadastro_usuario/view/cadastro/cadastro_page.dart';

class CadastroWidget extends State<CadastroPage> {
  final CadastroController controller = CadastroController();
  List<CidadeDTO> cidades = [];
  CidadeDTO? cidadeDTO;

  Future<List<CidadeDTO>> buscarCidadeFiltro(String? nomeCidade) async {
    try {
      var service = CadastroService();
      PageImpl page = await service.buscarCidade(nomeCidade: nomeCidade);
      return page.content as List<CidadeDTO>;
    } catch (e) {
      debugPrint(e.toString());
      return [];
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
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.formKey,
                  child: Column(
                    children: [
                      imageRegistro(),
                      textoAutenticacao(),
                      inputNome(),
                      inputIdade(),
                      inputCidade(),
                      inputCpf(),
                      inputTelefone(),
                      inputTelefone2(),
                      inputEmail(),
                      inputSenha(),
                      inputConfirmaSenha(),
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

  CampoDataWidget inputIdade() {
    return CampoDataWidget(
      hintText: 'Nascimento',
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
      objects: cidades,
      objectAsString: (cidade) => cidade!.nome,
      objectOnFind: (String? cidade) => buscarCidadeFiltro(cidade),
      onChanged: (value) {
        cidadeDTO = value;
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

  BotaoAcaoWidget botaoCadastrar() {
    return BotaoAcaoWidget(
      paddingTop: 20,
      paddingBottom: 30,
      labelText: "CADASTRAR",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () async {
        await controller.cadastrarUsuario(
          context,
          cidadeDTO!,
          widget,
        );
      },
    );
  }
}
