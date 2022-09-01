import 'package:flutter/material.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/list_view_component.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/Usuario.dart';
import 'package:systetica/screen/ativar_funcionario/ativar_funcionario_controller.dart';
import 'package:systetica/screen/ativar_funcionario/view/ativar_funcionario_page.dart';

class AtivarFuncionarioWidget extends State<AtivarFuncionarioPage> {
  final AtivarFuncionarController _controller = AtivarFuncionarController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.usuarios = [];
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
          paddingTop: _altura * 0.011,
          onPressed: () => Navigator.pop(context),
        ),
        body: _body(
          largura: _largura,
          altura: _altura,
          usuarios: _controller.usuarios,
        ),
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
            ? _erroRequisicao(
                largura: largura,
                listaVazia: true,
                altura: altura,
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
    return Container(
      height: 70,
      color: Colors.grey.withOpacity(0.2),
      padding: EdgeInsets.only(
        top: largura * 0.040,
        bottom: largura * 0.030,
        right: largura * 0.037,
        left: largura * 0.22,
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: largura / 60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            // width: 0.15,
            width: 1,
          ),
        ),
        child: TextFormField(
          maxLines: 1,
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            filled: true,
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(.4),
              fontWeight: FontWeight.w600,
              fontSize: largura / 22,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black.withOpacity(.6),
            ),
            hintText: 'Buscar usuário...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) {
            _controller.usuarios = [];
            _controller.buscarUsuarios(context: context, usuario: value).then(
                  (value) => setState(() {
                    _controller.usuarios = value!.object;
                  }),
                );
          },
        ),
      ),
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
            return ListViewComponent(
              largura: largura,
              altura: altura,
              infoNome: usuarios[index].nome!,
              numero: index + 1,
              maxLinesInfo: 2,
              onTap: () {},
            );
          },
        ),
      ),
    );
  }

  // Widgets de erro
  Widget _erroRequisicao({
    required bool listaVazia,
    required double largura,
    required double altura,
  }) {
    return Expanded(
      child: Container(
          color: Colors.grey.withOpacity(0.2),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: altura * 0.14,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        _imagemErro(listaVazia: listaVazia),
                        _textoErro(largura: largura, listaVazia: listaVazia),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  ImagensWidget _imagemErro({
    required bool listaVazia,
  }) {
    return ImagensWidget(
      paddingLeft: 0,
      image: listaVazia ? "buscar.png" : "erro.png",
      widthImagem: 320,
    );
  }

  TextAutenticacoesWidget _textoErro({
    required double largura,
    required bool listaVazia,
  }) {
    return TextAutenticacoesWidget(
      paddingLeft: largura * (listaVazia ? 0.18 : 0.15),
      paddingRight: largura * 0.10,
      fontSize: 33,
      text: listaVazia
          ? "Busque por nome ou email"
          : "Oopss...ocorreu algum erro. \nTente novamente mais tarde.",
    );
  }
}
