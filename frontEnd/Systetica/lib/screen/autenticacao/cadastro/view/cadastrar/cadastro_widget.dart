import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_acao_widget.dart';
import 'package:systetica/components/campos_texto/campo_data_widget.dart';
import 'package:systetica/components/campos_texto/campo_pesquisa_edget.dart';
import 'package:systetica/components/campos_texto/campo_texto_widget.dart';
import 'package:systetica/model/CidadeDTO.dart';
import 'package:systetica/model/Page_impl.dart';
import 'package:systetica/screen/autenticacao/cadastro/cadastro_controller.dart';
import 'package:systetica/screen/autenticacao/cadastro/cadastro_service.dart';
import 'package:systetica/screen/autenticacao/cadastro/view/cadastrar/cadastro_page.dart';

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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.keyboard_arrow_left_outlined,
                  size: 35,
                ),
                color: Colors.black,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 10,
                left: 35,
              ),
              child: Text(
                "Registrar-se",
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
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
                        suffixTextBool: false,
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
                        paddingBottom: 50,
                        labelText: "CADASTRAR",
                        largura: 190,
                        corBotao: Colors.black87.withOpacity(0.9),
                        corTexto: Colors.white,
                        onPressed: () => controller.cadastrarUsuario(
                          context,
                          cidadeDTO!,
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