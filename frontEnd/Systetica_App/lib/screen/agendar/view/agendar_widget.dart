import 'package:flutter/material.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/list_view/list_view_funcionario_component.dart';
import 'package:systetica/components/loading/loading_animation.dart';
import 'package:systetica/components/pesquisa_widget.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/screen/agendar/agendar_controller.dart';
import 'package:systetica/screen/agendar/view/agendar_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AgendarlWidget extends State<AgendarPage> {
  final AgendarController _controller = AgendarController();
  final ScrollController _scrollController = ScrollController();
  Info? info = Info(success: true);
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _controller.empresas = [];
    buscarEmpresas();
  }

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.of(context).size.height;
    double _largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: loading
            ? const LoadingAnimation()
            : _body(
                largura: _largura,
                altura: _altura,
                empresas: _controller.empresas,
              ),
      ),
    );
  }

  Future<void> buscarEmpresas() async {
    loading = false; // TODO REMOVER
    // await _controller.buscarEmpresas(context).then(
    //       (value) => setState(
    //         () {
    //           info = value;
    //           _controller.empresas = value!.object;
    //           loading = false;
    //         },
    //       ),
    //     );
  }

  Widget _body({
    required double altura, //width
    required double largura,
    required List<Empresa> empresas,
  }) {
    return Column(
      children: [
        _pesquisarEmpresaPorNome(
          altura: altura,
          largura: largura,
        ),
        empresas.isEmpty
            ? _erroRequisicao(
                largura: largura,
                listaVazia: true,
                altura: altura,
              )
            : _listView(
                altura: altura,
                largura: largura,
                empresas: empresas,
              ),
      ],
    );
  }

  Widget _pesquisarEmpresaPorNome({
    required double altura, //width
    required double largura, //height
  }) {
    return PesquisaWidget(
      altura: altura,
      largura: largura,
      hintText: 'Buscar empresa...',
      paddingLeft: 0.037,
      onChanged: (value) async {},
    );
  }

  Widget _listView({
    required double altura,
    required double largura,
    required List<Empresa> empresas,
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
          itemCount: empresas.length,
          itemBuilder: (BuildContext context, int index) {
            return ListViewFuncionarioComponent(
              largura: largura,
              altura: altura,
              infoNome: empresas[index].nome!,
              numero: index + 1,
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
                Column(
                  children: [
                    _imagemErro(listaVazia: listaVazia),
                    _textoErro(largura: largura, listaVazia: listaVazia),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ImagensWidget _imagemErro({
    required bool listaVazia,
  }) {
    return ImagensWidget(
      paddingLeft: 0,
      image: listaVazia ? "list-vazia.png" : "erro.png",
      widthImagem: 320,
    );
  }

  TextAutenticacoesWidget _textoErro({
    required double largura,
    required bool listaVazia,
  }) {
    return TextAutenticacoesWidget(
      alignment: Alignment.center,
      paddingLeft: largura * (listaVazia ? 0.10 : 0.15),
      paddingRight: largura * 0.10,
      fontSize: 30,
      text: listaVazia
          ? "Nenhuma empresa encontrada"
          : "Oopss...ocorreu algum erro. \nTente novamente mais tarde.",
    );
  }
}
