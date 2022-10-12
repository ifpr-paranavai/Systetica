// ignore_for_file: unused_field, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';

import '../../../../components/gesture_detector_foto_component.dart';
import '../../../../components/icon_arrow_widget.dart';
import '../../../../components/page_transition.dart';
import '../../../../model/Usuario.dart';
import '../../../../style/app_colors..dart';
import '../../agendar_controller.dart';
import '../../component/agendar_componente.dart';
import '../selecionar_horario/selecionar_horario_page.dart';
import 'selecionar_funcionario_page.dart';


class SelecionarFuncionarioWidget extends State<SelecionarFuncionarioPage> {
  final ScrollController _scrollController = ScrollController();
  final AgendarController _controller = AgendarController();
  var myPageTransition = MyPageTransition();

  List<Usuario> funcionarios = [];
  late bool selecionadoUmFuncionario;

  @override
  void initState() {
    super.initState();
    funcionarios = widget.agendamento.empresa.usuariosFuncionario!;
    widget.agendamento.funcionario.selecionado == true
        ? _ativarDesativarBotao()
        : selecionadoUmFuncionario = false;
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
        body: _body(),
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
              text: "SELECIONE O FUNCIONÁRIO",
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
            selecionadoUmFuncionario == true
                ? Navigator.of(context).push(
                    myPageTransition.pageTransition(
                      child: SelecionarHorarioPage(
                        agendamento: widget.agendamento,
                      ),
                      buttoToTop: true,
                      childCurrent: widget,
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
        itemCount: funcionarios.length,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemBuilder: (context, index) {
          return GestureDetectorFotoComponent(
            largura: _controller.largura,
            altura: _controller.altura,
            foto: funcionarios[index].imagemBase64!,
            textNome: funcionarios[index].nome!,
            funcionarioSelecionado: funcionarios[index].selecionado,
            onChanged: (selecao) {
              _desmarcarFuncionario();

              funcionarios[index].selecionado = selecao;

              _selecionarFuncionario(index);

              _ativarDesativarBotao();
              setState(() {});
            },
            onTap: () {
              _desmarcarFuncionario();
              _marcarFuncionarioSelecionado(index);
              _selecionarFuncionario(index);
              _ativarDesativarBotao();
              setState(() {});
            },
          );
        },
      ),
    );
  }

  void _desmarcarFuncionario() {
    funcionarios.forEach((funcionario) {
      funcionario.selecionado == true ? funcionario.selecionado = false : null;
    });
  }

  void _marcarFuncionarioSelecionado(int index) {
    funcionarios[index].selecionado == true
        ? funcionarios[index].selecionado = false
        : funcionarios[index].selecionado = true;
  }

  void _selecionarFuncionario(int index) {
    funcionarios[index].selecionado == true
        ? widget.agendamento.funcionario = funcionarios[index]
        : widget.agendamento.funcionario = Usuario();
  }

  void _ativarDesativarBotao() {
    if (widget.agendamento.funcionario.id == null) {
      selecionadoUmFuncionario = false;
      _controller.corBotao = Colors.grey.withOpacity(0.9);
      _controller.overlayCorBotao = Colors.transparent;
    } else {
      selecionadoUmFuncionario = true;
      _controller.corBotao = Colors.black87.withOpacity(0.9);
      _controller.overlayCorBotao = AppColors.blue5;
    }
  }
}
