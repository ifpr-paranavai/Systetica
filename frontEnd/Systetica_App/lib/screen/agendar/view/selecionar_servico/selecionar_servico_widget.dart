// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';

import '../../../../components/gesture_detector_component.dart';
import '../../../../components/icon_arrow_widget.dart';
import '../../../../components/loading/loading_animation.dart';
import '../../../../components/page_transition.dart';
import '../../../../model/HorarioAgendamento.dart';
import '../../../../model/Servico.dart';
import '../../../../model/Usuario.dart';
import '../../../../model/agendamento.dart';
import '../../../../style/app_colors..dart';
import '../../../servico/servico_controller.dart';
import '../../agendar_controller.dart';
import '../../component/agendar_componente.dart';
import '../selecionar_funcionario/selecionar_funcionario_page.dart';
import 'selecionar_servico_page.dart';

class SelecionarServicoWidget extends State<SelecionarServicoPage> {
  final ScrollController _scrollController = ScrollController();
  final AgendarController _controller = AgendarController();
  final ServicoController _servicoController = ServicoController();
  var myPageTransition = MyPageTransition();

  late Agendamento agendamento;
  List<Servico> servicos = [];
  bool loading = true;
  bool servicoSelecionado = false;

  @override
  void initState() {
    super.initState();
    buscarServicos();
    agendamento = Agendamento(
      cliente: Usuario(),
      funcionario: Usuario(),
      empresa: widget.empresa,
      horarioAgendamento: HorarioAgendamento(),
      servicosSelecionados: [],
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
    _controller.largura = MediaQuery.of(context).size.width;
    _controller.altura = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.branco,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: _controller.altura * 0.011,
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
              altura: _controller.altura,
              largura: _controller.largura,
              text: "SELECIONE O SERVIÇO",
            ),
            _checkboxSelect(),
          ],
        ),
        AgendarComponente.botaoSelecinar(
          altura: _controller.altura,
          largura: _controller.largura,
          corBotao: _controller.corBotao,
          overlayCorBotao: _controller.overlayCorBotao,
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
            largura: _controller.largura,
            altura: _controller.altura,
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
      _controller.corBotao = Colors.grey.withOpacity(0.9);
      _controller.overlayCorBotao = Colors.transparent;
    } else {
      servicoSelecionado = true;
      _controller.corBotao = Colors.black87.withOpacity(0.9);
      _controller.overlayCorBotao = AppColors.blue5;
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
