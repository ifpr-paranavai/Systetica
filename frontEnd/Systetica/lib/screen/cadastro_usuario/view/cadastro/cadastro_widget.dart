import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_acao_widget.dart';
import 'package:systetica/components/input/campo_data_widget.dart';
import 'package:systetica/components/input/campo_pesquisa_edget.dart';
import 'package:systetica/components/input/campo_texto_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/CidadeDTO.dart';
import 'package:systetica/model/Page_impl.dart';
import 'package:systetica/screen/cadastro_usuario/cadastro_controller.dart';
import 'package:systetica/screen/cadastro_usuario/cadastro_service.dart';
import 'package:systetica/screen/cadastro_usuario/view/cadastro/cadastro_page.dart';

class CadastroWidget extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  final CadastroController controller = CadastroController();

  List<CidadeDTO> cidades = [];

  CidadeDTO? cidadeDTO;

  /// Busca o cidades através do filtro
  Future<List<CidadeDTO>> buscarCidade(String? nomeCidade) async {
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
            ImagensWidget(
              paddingLeft: 20,
              image: "registro.png",
              widthImagem: 200,
            ),
            TextAutenticacoesWidget(
              paddingBottom: 2,
              paddingTop: 2,
              text: "Registrar-se",
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CampoTextoWidget(
                        controller: controller.nomeController,
                        labelText: "Nome",
                        paddingBottom: 0,
                        maxLength: 100,
                        paddingTop: 18,
                        isIconDate: true,
                        icon: const Icon(
                          Icons.face_rounded,
                          color: Colors.black87,
                        ),
                      ),
                      CampoDataWidget(
                        controller: controller.dataNascimentoController,
                        hintText: 'Nascimento',
                        paddingBottom: 0,
                        paddingTop: 3,
                        onChanged: (String? value) {
                          setState(
                            () {
                              if (value != null) {
                                controller.dataNascimentoController.text =
                                    value;
                              }
                            },
                          );
                        },
                      ),
                      CampoPesquisaWidget(
                        labelText: "Cidade",
                        labelSeachText: "Digite nome da cidade",
                        icon: const Icon(Icons.location_city),
                        objects: cidades,
                        objectAsString: (cidade) => cidade!.nome,
                        objectOnFind: (String? cidade) => buscarCidade(cidade),
                        onChanged: (value) {
                          cidadeDTO = value;
                        },
                      ),
                      CampoTextoWidget(
                        controller: controller.cpfController,
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
                      ),
                      CampoTextoWidget(
                        controller: controller.telefone1,
                        labelText: "Telefone 1",
                        keyboardType: TextInputType.number,
                        mask: "(##) #####-####",
                        paddingBottom: 0,
                        maxLength: 15,
                        paddingTop: 3,
                        isIconDate: true,
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.black87,
                        ),
                      ),
                      CampoTextoWidget(
                        controller: controller.telefone2,
                        labelText: "Telefone 2",
                        keyboardType: TextInputType.number,
                        mask: "(##) #####-####",
                        paddingBottom: 0,
                        maxLength: 15,
                        paddingTop: 3,
                        isIconDate: true,
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.black87,
                        ),
                      ),
                      CampoTextoWidget(
                        controller: controller.emailController,
                        labelText: "E-mail",
                        paddingBottom: 0,
                        maxLength: 80,
                        paddingTop: 3,
                        isIconDate: true,
                        icon: const Icon(
                          Icons.email,
                          color: Colors.black87,
                        ),
                      ),
                      CampoTextoWidget(
                        controller: controller.senhaController,
                        labelText: "Senha",
                        maxLength: 16,
                        isPassword: true,
                        paddingBottom: 0,
                        paddingTop: 5,
                      ),
                      CampoTextoWidget(
                        controller: controller.confirmaSenhaController,
                        labelText: "Confirmar Senha",
                        maxLength: 16,
                        isPassword: true,
                        paddingBottom: 0,
                        paddingTop: 5,
                      ),
                      BotaoAcaoWidget(
                        paddingTop: 0,
                        paddingBottom: 40,
                        labelText: "CADASTRAR",
                        largura: 190,
                        corBotao: Colors.black87.withOpacity(0.9),
                        corTexto: Colors.white,
                        onPressed: () => controller.cadastrarUsuario(
                          context,
                          cidadeDTO!,
                          widget,
                        ),
                      ),
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
}
