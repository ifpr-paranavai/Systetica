import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/gesture_detector_component.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/loading/loading_animation.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/Servico.dart';
import 'package:systetica/screen/agendar/agendar_controller.dart';
import 'package:systetica/screen/agendar/view/selecionar_servico/selecionar_servico_page.dart';
import 'package:systetica/screen/servico/servico_controller.dart';

class SelecionarServicoWidget extends State<SelecionarServicoPage> {
  final ScrollController _scrollController = ScrollController();
  final AgendarController _controller = AgendarController();
  final ServicoController _servicoController = ServicoController();

  bool loading = true;

  @override
  void initState() {
    super.initState();
    buscarServicos();
  }

  Future<void> buscarServicos() async {
    await _servicoController
        .buscarServicoPorId(
          context: context,
          id: widget.empresa.id!,
        )
        .then(
          (value) => setState(
            () {
              _controller.servicos = value!.object;
              loading = false;
            },
          ),
        );
  }

  String nome = '';
  double _largura = 0;
  double _altura = 0;

  @override
  Widget build(BuildContext context) {
    _largura = MediaQuery.of(context).size.width;
    _altura = MediaQuery.of(context).size.height;
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
                servicos: _controller.servicos,
              ),
      ),
    );
  }

  Widget _body({
    required List<Servico> servicos,
  }) {
    return Stack(
      children: [
        Column(
          children: [
            _infoSelecionarServico(),
            _checkboSelect(servicos: servicos),
          ],
        ),
        _botaoSelecinarServico(),
      ],
    );
  }

  Widget _infoSelecionarServico() {
    return Container(
      padding: EdgeInsets.only(
        left: _largura * 0.1,
        top: _altura * 0.017,
      ),
      color: Colors.grey.withOpacity(0.2),
      child: TextAutenticacoesWidget(
        text: "Selecione o serviço",
        fontSize: 30,
        paddingBottom: 6,
      ),
    );
  }

  Widget _checkboSelect({
    required List<Servico> servicos,
  }) {
    return Expanded(
      child: Container(
        color: Colors.grey.withOpacity(0.2),
        child: ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: servicos.length,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemBuilder: (ctx, index) {
            return GestureDetectorComponent(
              largura: _largura,
              textNome: servicos[index].nome!,
              groupValue: nome,
              onChanged: (s) {
                nome = s.toString();
                setState(() {});
              },
              onTap: () {
                nome = servicos[index].nome!;
                setState(() {});
              },
            );
          },
        ),
      ),
    );
  }

  Widget _botaoSelecinarServico() {
    return Container(
      padding: EdgeInsets.only(
        bottom: _altura * 0.03,
      ),
      alignment: Alignment.bottomCenter,
      child: BotaoWidget(
        paddingTop: 10,
        paddingBottom: 0,
        labelText: "SELECIONAR FUNCIONÁRIO",
        largura: _largura * 0.6,
        corBotao: Colors.black87.withOpacity(0.9),
        corTexto: Colors.white,
        onPressed: () => {},
      ),
    );
  }
}

// https://medium.flutterdevs.com/modal-bottom-sheet-in-flutter-dae05debbed2 TODO
