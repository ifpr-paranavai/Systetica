import 'package:flutter/material.dart';
import 'package:systetica/components/erro/erro_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/list_view/list_view_component.dart';
import 'package:systetica/components/loading/loading_animation.dart';
import 'package:systetica/components/pesquisa_widget.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Servico.dart';
import 'package:systetica/screen/servico/servico_controller.dart';
import 'package:systetica/screen/servico/view/form/servico_form_page.dart';
import 'package:systetica/screen/servico/view/servico_page.dart';
import 'package:systetica/style/app_colors..dart';
import 'package:brasil_fields/brasil_fields.dart';

class ServicoWidget extends State<ServicoPage> {
  final ServicoController _controller = ServicoController();
  final ScrollController _scrollController = ScrollController();
  Info? info = Info(success: true);
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _controller.servicos = [];
    buscarServicos();
  }

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.of(context).size.height;
    double _largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.branco,
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
                servicos: _controller.servicos,
              ),
      ),
    );
  }

  Future<void> buscarServicos() async {
    await _controller.buscarServico(context: context, servico: "").then(
          (value) => setState(
            () {
              info = value;
              _controller.servicos = value!.object;
              loading = false;
            },
          ),
        );
  }

  Widget _body({
    required double altura, //width
    required double largura,
    required List<Servico> servicos,
  }) {
    return Stack(
      children: [
        Column(
          children: [
            _pesquisarServico(
              altura: altura,
              largura: largura,
            ),
            servicos.isEmpty
                ? ErroWidget().erroRequisicao(
                    largura: largura,
                    listaVazia: true,
                    altura: altura,
                    nenhumItem: "Nenhuma serviço cadastrado",
                  )
                : _listView(
                    altura: altura,
                    largura: largura,
                    servicos: servicos,
                  ),
          ],
        ),
        buttonIcon(
          altura: altura,
          largura: largura,
        ),
      ],
    );
  }

  Widget _pesquisarServico({
    required double altura,
    required double largura,
  }) {
    return PesquisaWidget(
      altura: altura,
      largura: largura,
      hintText: 'Buscar serviço...',
      onChanged: (value) async {
        _controller.servicos = [];
        _controller.buscarServico(context: context, servico: value).then(
              (value) => setState(() {
                _controller.servicos = value!.object;
              }),
            );
      },
    );
  }

  Widget _listView({
    required double altura,
    required double largura,
    required List<Servico> servicos,
  }) {
    return Expanded(
      child: Container(
        color: AppColors.branco,
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
          itemCount: servicos.length,
          itemBuilder: (BuildContext context, int index) {
            return ListViewComponent(
              largura: largura,
              altura: altura,
              infoNome: servicos[index].nome!,
              infoPreco: UtilBrasilFields.obterReal(servicos[index].preco!),
              numero: index + 1,
              maxLinesInfo: 2,
              onTap: () {
                Navigator.of(context)
                    .push(
                      _controller.myPageTransition.pageTransition(
                        child: ServicoFormPage(servico: servicos[index]),
                        childCurrent: widget,
                        buttoToTop: true,
                      ),
                    )
                    .then(
                      (value) => setState(() {
                        buscarServicos();
                      }),
                    );
              },
            );
          },
        ),
      ),
    );
  }

  Widget buttonIcon({
    required double altura,
    required double largura,
  }) {
    return Container(
      padding: EdgeInsets.only(
        bottom: altura * 0.04,
        right: altura * 0.04,
      ),
      alignment: Alignment.bottomRight,
      child: IconButton(
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(
          Icons.add_circle_outlined,
          color: AppColors.bluePrincipal.withOpacity(.9),
          size: 60,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(
                _controller.myPageTransition.pageTransition(
                  child: ServicoFormPage(),
                  childCurrent: widget,
                  buttoToTop: true,
                ),
              )
              .then(
                (value) => setState(() {
                  buscarServicos();
                }),
              );
        },
      ),
    );
  }
}
