import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/input/custom_switch.dart';
import 'package:systetica/components/item_list.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/Usuario.dart';
import 'package:systetica/screen/ativar_funcionario/ativar_funcionario_controller.dart';
import 'package:systetica/screen/ativar_funcionario/view/form/ativar_funcionario_form_page.dart';

class AtivarFuncionarioFormWidget extends State<AtivarFuncionarioFormPage> {
  final AtivarFuncionarController _controller = AtivarFuncionarController();
  late ScrollController _scrollController;
  bool edicao = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller.usuario = widget.usuario!;
  }

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.of(context).size.height;
    double _largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _sizedBox(height: _altura * 0.15),
                  _textoEditarPerfil(),
                  _cardInfoUsuario(
                    usuario: _controller.usuario,
                  ),
                  customSwitch(
                    paddingHorizontal: _largura,
                  ),
                  botaoCadastrar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextAutenticacoesWidget _textoEditarPerfil() {
    return TextAutenticacoesWidget(
      text: "Permissão Funcionário",
      fontSize: 30,
      paddingBottom: 6,
    );
  }

  Padding _cardInfoUsuario({required Usuario usuario}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black,
            width: 0.1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _sizedBox(height: 5),
            _itemNome(usuario.nome!),
            _itemEmail(usuario.email!),
          ],
        ),
      ),
    );
  }

  ItemLista _itemNome(String nome) {
    return ItemLista(
      titulo: "Nome"
          "",
      descricao: nome,
    );
  }

  ItemLista _itemEmail(String email) {
    return ItemLista(
      titulo: "E-mail",
      descricao: email,
    );
  }

  SizedBox _sizedBox({
    double? height = 40,
    double? width = 0,
  }) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  CustomSwitch customSwitch({
    required double paddingHorizontal,
  }) {
    return CustomSwitch(
      paddingBottom: 0,
      paddingHorizontal: paddingHorizontal * 0.08,
      label: "Permissão Funcionário",
      value: _controller.usuario.permissaoFuncionario!,
      onChanged: (bool value) {
        setState(() {
          _controller.usuario.permissaoFuncionario = value;
        });
      },
    );
  }

  BotaoWidget botaoCadastrar() {
    return BotaoWidget(
      paddingTop: 18,
      paddingBottom: 30,
      labelText: "SALVAR",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () => {
        _controller.concederPermissao(context).then(
              (value) => Navigator.pop(context),
        ),
      },
    );
  }
}
