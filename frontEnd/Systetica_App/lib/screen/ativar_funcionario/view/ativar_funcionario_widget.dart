import 'package:flutter/material.dart';
import 'package:systetica/components/erro/erro_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/list_view/list_view_foto_component.dart';
import 'package:systetica/components/loading/loading_animation.dart';
import 'package:systetica/components/pesquisa_widget.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Usuario.dart';
import 'package:systetica/screen/ativar_funcionario/ativar_funcionario_controller.dart';
import 'package:systetica/screen/ativar_funcionario/view/ativar_funcionario_page.dart';
import 'package:systetica/screen/ativar_funcionario/view/form/ativar_funcionario_form_page.dart';

class AtivarFuncionarioWidget extends State<AtivarFuncionarioPage> {
  final AtivarFuncionarController _controller = AtivarFuncionarController();
  final ScrollController _scrollController = ScrollController();
  Info? info = Info(success: true);
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _controller.usuarios = [];
    buscarFuncionarios();
  }

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery
        .of(context)
        .size
        .height;
    double _largura = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: _altura * 0.011,
          onPressed: () => Navigator.pop(context),
        ),
        body: loading
            ? const LoadingAnimation()
            : _body(
          largura: _largura,
          altura: _altura,
          usuarios: _controller.usuarios,
        ),
      ),
    );
  }

  Future<void> buscarFuncionarios() async {
    await _controller.buscarFuncionarios(context).then(
          (value) =>
          setState(
                () {
              info = value;
              _controller.usuarios = value!.object;
              loading = false;
            },
          ),
    );
  }

  Widget _body({
    required double altura, //width
    required double largura,
    required List<Usuario> usuarios,
  }) {
    return Column(
      children: [
        _pesquisaUsuarioEmail(
          altura: altura,
          largura: largura,
        ),
        usuarios.isEmpty
            ? ErroWidget().erroRequisicao(
            largura: largura,
            listaVazia: true,
            altura: altura,
            nenhumItem: "Nenhum funcionário encontrado",
            imagem: "buscar.png",
        )
            : _listView(
          altura: altura,
          largura: largura,
          usuarios: usuarios,
        ),
      ],
    );
  }

  Widget _pesquisaUsuarioEmail({
    required double altura, //width
    required double largura, //height
  }) {
    return PesquisaWidget(
      altura: altura,
      largura: largura,
      hintText: 'Buscar usuário...',
      onChanged: (value) {
        _controller.usuarios = [];
        _controller.buscarUsuarios(context: context, usuario: value).then(
              (value) =>
              setState(() {
                _controller.usuarios = value!.object;
              }),
        );
      },
    );
  }

  Widget _listView({
    required double altura,
    required double largura,
    required List<Usuario> usuarios,
  }) {
    return Expanded(
      child: Container(
        color: Colors.grey.withOpacity(0.2),
        child: ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          padding: EdgeInsets.only(
            left: largura * 0.04,
            right: largura * 0.04,
          ),
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: usuarios.length,
          itemBuilder: (BuildContext context, int index) {
            return ListViewFotoOrNumeroComponent(
              largura: largura,
              altura: altura,
              infoNome: usuarios[index].nome!,
              foto: usuarios[index].imagemBase64,
              numero: index + 1,
              onTap: () {
                Navigator.of(context)
                    .push(
                  _controller.myPageTransition.pageTransition(
                    child: AtivarFuncionarioFormPage(usuario: usuarios[index]),
                    childCurrent: widget,
                    buttoToTop: true,
                  ),
                )
                    .then(
                      (value) =>
                      setState(() {
                        buscarFuncionarios();
                      }),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
