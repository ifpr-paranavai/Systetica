import 'package:flutter/material.dart';
import 'package:systetica/components/erro/erro_widget.dart';
import 'package:systetica/components/list_view/list_view_funcionario_component.dart';
import 'package:systetica/components/loading/loading_animation.dart';
import 'package:systetica/components/pesquisa_widget.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/screen/agendar/agendar_controller.dart';
import 'package:systetica/screen/agendar/view/agendar_page.dart';

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
    await _controller.buscarEmpresas(context: context, nomeEmpresa: "").then(
          (value) => setState(
            () {
              info = value;
              _controller.empresas = value!.object;
              loading = false;
            },
          ),
        );
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
        _infoGerais(
          altura: altura,
          largura: largura,
          titulo: "Para agendar um serviço, selecione uma barbearia.",
          widthSize: largura,
        ),
        empresas.isEmpty
            ? ErroWidget().erroRequisicao(
                largura: largura,
                listaVazia: true,
                altura: altura,
                nenhumItem: "Nenhuma empresa encontrada",
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
      onChanged: (value) async {
        _controller.empresas = [];
        _controller.buscarEmpresas(context: context, nomeEmpresa: value).then(
              (value) => setState(() {
                _controller.empresas = value!.object;
              }),
            );
      },
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

  Container _infoGerais({
    required String titulo,
    required double widthSize,
    required double largura,
    required double altura,
  }) {
    return Container(
      color: Colors.grey.withOpacity(0.2),
      width: largura,
      height: altura * 0.10,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(
        left: widthSize * 0.07,
        top: widthSize * 0.02,
        bottom: widthSize * 0.02,
      ),
      child: _tituloSystetica(
        text: titulo,
        opacity: 0.6,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Text _tituloSystetica({
    required String text,
    required double opacity,
    required FontWeight? fontWeight,
  }) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 19,
        color: Colors.black.withOpacity(opacity),
        fontWeight: fontWeight,
      ),
    );
  }
}
