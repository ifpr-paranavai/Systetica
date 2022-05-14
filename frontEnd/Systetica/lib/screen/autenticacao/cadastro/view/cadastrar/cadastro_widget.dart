import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_acao_widget.dart';
import 'package:systetica/components/campos_texto/campo_data_widget.dart';
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
              padding: const EdgeInsets.only(top: 5),
              child: IconButton(
                icon: const Icon(Icons.keyboard_arrow_left_outlined, size: 35),
                color: Colors.black,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10, left: 35),
              child: Text(
                "Registrar-se",
                style: TextStyle(color: Colors.black, fontSize: 35),
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
                      ),
                      CampoDataWidget(
                        controller: controller.dataNascimentoController,
                        isDarkMode: false,
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
                      Container(
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 15,
                          left: 35,
                          right: 35,
                        ),
                        child: DropdownSearch<CidadeDTO>(
                          popupBackgroundColor: Colors.grey,
                          dropdownSearchDecoration: const InputDecoration(
                              labelText: "Cidade",
                              //TODO ACRESCENTAR * PARA CAMPOS OBRIGATÓRIOS
                              hintText: "Digite sua cidade",
                              //Borda Principal
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.blueGrey,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                              isDense: true,
                              hintStyle: TextStyle(color: Colors.black),
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 17),
                              floatingLabelStyle: TextStyle(
                                color: Colors.black,
                              )),
                          mode: Mode.MENU,
                          isFilteredOnline: true,
                          showClearButton: true,
                          showSearchBox: true,
                          items: cidades,
                          itemAsString: (elemento) => elemento!.nome,
                          onFind: (String? cidade) => buscarCidade(cidade),
                          onChanged: (value) {
                            cidadeDTO = value;
                          },
                        ),
                      ),
                      CampoTextoWidget(
                        controller: controller.cpfController,
                        labelText: "CPF",
                        keyboardType: TextInputType.number,
                        mask: "###.###.###-##",
                        paddingBottom: 0,
                        maxLength: 14,
                        paddingTop: 5,
                      ),
                      CampoTextoWidget(
                        controller: controller.telefone1,
                        labelText: "Telefone 1",
                        keyboardType: TextInputType.number,
                        mask: "(##) #####-####",
                        paddingBottom: 0,
                        maxLength: 15,
                        paddingTop: 3,
                      ),
                      CampoTextoWidget(
                        controller: controller.telefone2,
                        labelText: "Telefone 2",
                        keyboardType: TextInputType.number,
                        mask: "(##) #####-####",
                        paddingBottom: 0,
                        maxLength: 15,
                        paddingTop: 3,
                      ),
                      CampoTextoWidget(
                        controller: controller.emailController,
                        labelText: "E-mail",
                        paddingBottom: 0,
                        maxLength: 80,
                        paddingTop: 3,
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
                          corBotao: Colors.black,
                          corTexto: Colors.white,
                          onPressed: () => controller.cadastrarUsuario(
                                context,
                                cidadeDTO!,
                              )),
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
