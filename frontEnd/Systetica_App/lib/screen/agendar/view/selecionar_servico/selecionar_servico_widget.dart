// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:systetica/components/gesture_detector_component.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/loading/loading_animation.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/model/HorarioAgendamento.dart';
import 'package:systetica/model/Servico.dart';
import 'package:systetica/model/Usuario.dart';
import 'package:systetica/model/agendamento.dart';
import 'package:systetica/screen/agendar/agendar_controller.dart';
import 'package:systetica/screen/agendar/component/agendar_componente.dart';
import 'package:systetica/screen/agendar/view/selecionar_funcionario/selecionar_funcionario_page.dart';
import 'package:systetica/screen/agendar/view/selecionar_servico/selecionar_servico_page.dart';
import 'package:systetica/screen/servico/servico_controller.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:systetica/style/app_colors..dart';

class SelecionarServicoWidget extends State<SelecionarServicoPage> {
  final ScrollController _scrollController = ScrollController();
  final AgendarController _controller = AgendarController();
  final ServicoController _servicoController = ServicoController();
  var myPageTransition = MyPageTransition();

  late Agendamento agendamento;
  List<Servico> servicos = [];
  double _largura = 0;
  double _altura = 0;
  bool loading = true;
  Color corBotao = Colors.grey.withOpacity(0.9);
  Color overlayCorBotao = Colors.transparent;
  bool servicoSelecionado = false;

  @override
  void initState() {
    super.initState();
    buscarServicos();
    agendamento = Agendamento(
      servicosSelecionados: [],
      funcionario: Usuario(),
      empresa: widget.empresa,
      horarioAgendamento: HorarioAgendamento(),
    );
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
              servicos = value!.object;
              loading = false;
            },
          ),
        );
  }

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
        body: loading ? const LoadingAnimation() : _body(),
      ),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        Column(
          children: [
            AgendarComponente.info(
              altura: _altura,
              largura: _largura,
              text: "SELECIONE O SERVIÇO",
            ),
            _checkboxSelect(),
          ],
        ),
        AgendarComponente.botaoSelecinar(
          altura: _altura,
          largura: _largura,
          corBotao: corBotao,
          overlayCorBotao: overlayCorBotao,
          onPressed: () => {
            servicoSelecionado == true
                ? Navigator.of(context).push(
                    myPageTransition.pageTransition(
                      child: SelecionarFuncionarioPage(
                        agendamento: agendamento,
                      ),
                      childCurrent: widget,
                      buttoToTop: true,
                    ),
                  )
                : null,
          },
        ),
      ],
    );
  }

  Widget _checkboxSelect() {
    return AgendarComponente.containerGeral(
      widget: ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: servicos.length,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemBuilder: (context, index) {
          String precoMinuto =
              "${UtilBrasilFields.obterReal(servicos[index].preco!)} - "
              "${servicos[index].tempoServico!} min";
          int totalList = servicos.length - 1;

          return GestureDetectorComponent(
            paddingBottom: index == totalList ? 0.3 : 0.04,
            largura: _largura,
            altura: _altura,
            textNome: servicos[index].nome!,
            precoMinuto: precoMinuto,
            servicoSelecionado: servicos[index].servicoSelecionado,
            onChanged: (selecao) {
              servicos[index].servicoSelecionado = selecao;
              _adicionarRemoverServico(index);
              _ativarDesativarBotao();
              setState(() {});
            },
            onTap: () {
              _selecionarHorario(index);
              _adicionarRemoverServico(index);
              _ativarDesativarBotao();
              setState(() {});
            },
          );
        },
      ),
    );
  }

  void _selecionarHorario(int index) {
    servicos[index].servicoSelecionado == true
        ? servicos[index].servicoSelecionado = false
        : servicos[index].servicoSelecionado = true;
  }

  void _ativarDesativarBotao() {
    if (agendamento.servicosSelecionados.isEmpty) {
      servicoSelecionado = false;
      corBotao = Colors.grey.withOpacity(0.9);
      overlayCorBotao = Colors.transparent;
    } else {
      servicoSelecionado = true;
      corBotao = Colors.black87.withOpacity(0.9);
      overlayCorBotao = AppColors.blue5;
    }
  }

  void _adicionarRemoverServico(int index) {
    servicos[index].servicoSelecionado == true
        ? agendamento.servicosSelecionados.add(servicos[index])
        : agendamento.servicosSelecionados.removeWhere(
            (servico) => servico.id == servicos[index].id,
          );
  }
}
