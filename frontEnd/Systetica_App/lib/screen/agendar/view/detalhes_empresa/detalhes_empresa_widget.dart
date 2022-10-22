import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../../components/botoes/botao_widget.dart';
import '../../../../components/card_component.dart';
import '../../../../components/foto/foto_widget.dart';
import '../../../../components/item_list.dart';
import '../../../../components/list_view/list_view_horarios_component.dart';
import '../../../../components/loading/loading_animation.dart';
import '../../../../components/page_transition.dart';
import '../../../../components/single_child_scroll_component.dart';
import '../../../../components/text_autenticacoes_widget.dart';
import '../../../../model/Empresa.dart';
import '../../../../model/Info.dart';
import '../../../../style/app_colors.dart';
import '../../../../utils/util.dart';
import '../../../empresa/empresa_controller.dart';
import '../../agendar_controller.dart';
import '../selecionar_servico/selecionar_servico_page.dart';
import 'detalhes_empresa_page.dart';

class DetalhaEmpresaWidget extends State<DetalhaEmpresaPage> {
  final ScrollController _scrollController = ScrollController();
  final AgendarController _controller = AgendarController();
  late Info? info;
  Map<String, String> diasTrabalhoEmpresa = {};

  bool loading = true;
  MyPageTransition myPageTransition = MyPageTransition();

  @override
  void initState() {
    super.initState();
    _controller.empresa = Empresa();
  }

  @override
  Widget build(BuildContext context) {
    _controller.altura = MediaQuery.of(context).size.height;
    _controller.largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.branco,
        body: FutureBuilder<Info?>(
          future: _controller.buscarEmpresas(context: context),
          builder: (context, snapShot) {
            if (!snapShot.hasData) {
              return const LoadingAnimation();
            } else {
              _controller.empresa = snapShot.data!.object;
              diasTrabalhoEmpresa = Util.diasHorarioFuncionamento(
                _controller.empresa.horarioAbertura!,
                _controller.empresa.horarioFechamento!,
              );
              return _body();
            }
          },
        ),
      ),
    );
  }

  Widget _body() {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return false;
      },
      child: Stack(
        children: [
          SingleChildScrollComponent(
            widgetComponent: Center(
              child: Column(
                children: [
                  _sizedBox(height: _controller.altura * 0.08),
                  FotoWidget().boxFoto(
                    imagemUsuario: _controller.empresa.logoBase64,
                  ),
                  _sizedBox(height: _controller.altura * 0.04),
                  _infoEmpresa(),
                  _cardInfoEmpresa(empresa: _controller.empresa),
                  _sizedBox(height: _controller.altura * 0.02),
                  _infoEnderecoEmpresa(),
                  _cardInfoEnderecoEmpresa(empresa: _controller.empresa),
                  _sizedBox(height: _controller.altura * 0.02),
                  _infoHorariosEmpresa(),
                  _cardHorarioEmpresa(),
                  _sizedBox(height: _controller.altura * 0.12),
                ],
              ),
            ),
          ),
          _botaoAgendar(),
        ],
      ),
    );
  }

  TextAutenticacoesWidget _infoEmpresa() {
    return TextAutenticacoesWidget(
      text: "Empresa",
      fontSize: 30,
      paddingBottom: 6,
    );
  }

  Widget _cardInfoEmpresa({required Empresa empresa}) {
    return CardComponent(
      children: [
        _sizedBox(height: 5),
        _itemNome(empresa.nome!),
        _itemTelefone1(empresa.telefone1!),
        _itemTelefone2(
          Util.isEmptOrNull(empresa.telefone2)
              ? "Não cadastrado"
              : empresa.telefone2!,
        ),
      ],
    );
  }

  TextAutenticacoesWidget _infoEnderecoEmpresa() {
    return TextAutenticacoesWidget(
      text: "Endereço",
      fontSize: 30,
      paddingBottom: 6,
    );
  }

  ItemLista _itemNome(String nome) {
    return ItemLista(
      titulo: "Nome",
      descricao: nome,
    );
  }

  ItemLista _itemTelefone1(String telefone) {
    return ItemLista(
      titulo: "Telefone Principal",
      descricao: telefone,
    );
  }

  ItemLista _itemTelefone2(String telefone) {
    return ItemLista(
      titulo: "Telefone Fixo",
      descricao: telefone,
    );
  }

  Widget _cardInfoEnderecoEmpresa({required Empresa empresa}) {
    return CardComponent(
      children: [
        _sizedBox(height: 5),
        _itemEndereco(empresa.endereco!, empresa.numero!.toString()),
        _abrirLocalizacao(
          latitude: double.parse(empresa.latitude!),
          longitude: double.parse(empresa.longitude!),
        ),
      ],
    );
  }

  ItemLista _itemEndereco(String endereco, String numero) {
    return ItemLista(
      titulo: "Endereço",
      descricao: endereco + " -  Nº " + numero,
    );
  }

  Widget _abrirLocalizacao({
    required double latitude,
    required double longitude,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 18),
      width: _controller.largura,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.2)),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: const Align(
          alignment: Alignment.topLeft,
          child: ItemLista(
            titulo: "Localização",
            descricao: "Clique aqui",
            paddingHorizonta: 0,
            colorDescricao: AppColors.redPrincipal,
          ),
        ),
        onPressed: () => MapsLauncher.launchCoordinates(
          latitude,
          longitude,
        ),
      ),
    );
  }

  TextAutenticacoesWidget _infoHorariosEmpresa() {
    return TextAutenticacoesWidget(
      text: "Horários",
      fontSize: 30,
      paddingBottom: 6,
    );
  }

  Widget _cardHorarioEmpresa() {
    return CardComponent(
      children: [
        _sizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 8,
          ),
          child: ListView.builder(
            controller: _scrollController,
            shrinkWrap: true,
            itemCount: diasTrabalhoEmpresa.length,
            itemBuilder: (BuildContext context, int index) {
              String key = diasTrabalhoEmpresa.keys.elementAt(index);
              return ListViewHorariosComponent(
                dia: key,
                horario: diasTrabalhoEmpresa[key]!,
              );
            },
          ),
        ),
      ],
    );
  }

  SizedBox _sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  EmpresaController empresaController = EmpresaController();

  Widget _botaoAgendar() {
    return Container(
      padding: EdgeInsets.only(
        bottom: _controller.altura * 0.01,
      ),
      alignment: Alignment.bottomCenter,
      child: BotaoWidget(
        paddingTop: 10,
        paddingBottom: 0,
        labelText: "AGENDAR",
        largura: _controller.largura * 0.6,
        corBotao: Colors.black87.withOpacity(0.9),
        corTexto: Colors.white,
        onPressed: () => Navigator.of(context).push(
          myPageTransition.pageTransition(
            child: SelecionarServicoPage(
              empresa: _controller.empresa,
              agendamentoCliente: true,
            ),
            buttoToTop: true,
            childCurrent: widget,
          ),
        ),
      ),
    );
  }
}
