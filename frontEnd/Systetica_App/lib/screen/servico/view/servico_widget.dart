import 'package:flutter/material.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/list_view_component.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Servico.dart';
import 'package:systetica/screen/servico/servico_controller.dart';
import 'package:systetica/screen/servico/view/detalhe/servico_detalhe_page.dart';
import 'package:systetica/screen/servico/view/novo/servico_novo_page.dart';
import 'package:systetica/screen/servico/view/servico_page.dart';
import 'package:systetica/style/app_colors..dart';

class ServicoWidget extends State<ServicoPage> {
  final ServicoController _controller = ServicoController();
  final ScrollController _scrollController = ScrollController();
  Info? info = Info(success: false);

  @override
  void initState() {
    super.initState();
    _controller.servicos = [];
    buscaServicos();
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
        body: info?.success == false
            ? _erroRequisicao(largura: _largura, listaVazia: false)
            : (_controller.servicos.isEmpty
                ? stackListaVazia(altura: _altura, largura: _largura)
                : _body(
                    largura: _largura,
                    altura: _altura,
                    servicos: _controller.servicos,
                  )),
      ),
    );
  }

  Future<void> buscaServicos() async {
    await _controller.buscarServico(context: context, servico: "").then(
          (value) => setState(
            () {
              info = value;
              _controller.servicos = value!.object;
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
            _pesquisaServico(
              altura: altura,
              largura: largura,
            ),
            _listView(
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

  Widget _pesquisaServico({
    required double altura, //width
    required double largura, //height
  }) {
    return Container(
      height: altura * 0.09,
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
            hintText: 'Buscar serviço...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) async {
            _controller.servicos = [];
            _controller.buscarServico(context: context, servico: value).then(
                  (value) => setState(() {
                    _controller.servicos = value!.object;
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
    required List<Servico> servicos,
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
          itemCount: servicos.length,
          itemBuilder: (BuildContext context, int index) {
            return ListViewComponent(
              largura: largura,
              altura: altura,
              titulo1: "Nome: ",
              titulo2: "Preço: ",
              descricao1: servicos[index].nome!,
              descricao2: "R\$ " + servicos[index].preco.toString(),
              numero: index + 1,
              onTap: () {
                Navigator.of(context)
                    .push(
                      _controller.myPageTransition.pageTransition(
                        child: ServicoDetalhePage(servico: servicos[index]),
                        childCurrent: widget,
                        buttoToTop: true,
                      ),
                    )
                    .then(
                      (value) => setState(() {
                        buscaServicos();
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
                  child: const ServicoNovoPage(),
                  childCurrent: widget,
                  buttoToTop: true,
                ),
              )
              .then(
                (value) => setState(() {
                  buscaServicos();
                }),
              );
        },
      ),
    );
  }

  // Widgets de erro
  Stack stackListaVazia({
    required double altura,
    required double largura,
  }) {
    return Stack(
      children: [
        _erroRequisicao(largura: largura, listaVazia: true),
        buttonIcon(
          altura: altura,
          largura: largura,
        ),
      ],
    );
  }

  Center _erroRequisicao({
    required bool listaVazia,
    required double largura,
  }) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imagemErro(listaVazia: listaVazia),
            _textoErro(largura: largura, listaVazia: listaVazia),
          ],
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
      paddingLeft: largura * 0.10,
      paddingRight: largura * 0.10,
      fontSize: 33,
      text: listaVazia
          ? "Não existe nenhum serviço cadastrado no momento."
          : "Oopss...ocorreu algum erro. \nTente novamente mais tarde.",
    );
  }
}
