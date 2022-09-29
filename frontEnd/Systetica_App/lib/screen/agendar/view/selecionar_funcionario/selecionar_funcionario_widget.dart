// ignore_for_file: unused_field, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:systetica/components/gesture_detector_foto_component.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/model/Usuario.dart';
import 'package:systetica/screen/agendar/agendar_controller.dart';
import 'package:systetica/screen/agendar/component/agendar_componente.dart';
import 'package:systetica/screen/agendar/view/selecionar_funcionario/selecionar_funcionario_page.dart';
import 'package:systetica/screen/agendar/view/selecionar_horario/selecionar_horario_page.dart';
import 'package:systetica/style/app_colors..dart';

class SelecionarFuncionarioWidget extends State<SelecionarFuncionarioPage> {
  final ScrollController _scrollController = ScrollController();
  final AgendarController _controller = AgendarController();
  var myPageTransition = MyPageTransition();

  List<Usuario> funcionarios = [];
  double _largura = 0;
  double _altura = 0;
  Color corBotao = Colors.grey.withOpacity(0.9);
  Color overlayCorBotao = Colors.transparent;
  late bool selecionadoUmFuncionario;

  @override
  void initState() {
    super.initState();
    funcionarios = widget.agendamento.empresa.usuariosFuncionario!;
    widget.agendamento.funcionario.selecionado == true
        ? ativarDesativarBotao()
        : selecionadoUmFuncionario = false;
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
              altura: _altura,
              largura: _largura,
              text: "SELECIONE O FUNCIONÁRIO",
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
            largura: _largura,
            altura: _altura,
            foto: funcionarios[index].imagemBase64!,
            textNome: funcionarios[index].nome!,
            funcionarioSelecionado: funcionarios[index].selecionado,
            onChanged: (selecao) {
              desmarcarFuncionario();

              funcionarios[index].selecionado = selecao;

              selecionarFuncionario(index);

              ativarDesativarBotao();
              setState(() {});
            },
            onTap: () {
              desmarcarFuncionario();
              funcionarios[index].selecionado == true
                  ? funcionarios[index].selecionado = false
                  : funcionarios[index].selecionado = true;
              selecionarFuncionario(index);
              ativarDesativarBotao();
              setState(() {});
            },
          );
        },
      ),
    );
  }

  void desmarcarFuncionario() {
    funcionarios.forEach((funcionario) {
      funcionario.selecionado == true ? funcionario.selecionado = false : null;
    });
  }

  void selecionarFuncionario(int index) {
    funcionarios[index].selecionado == true
        ? widget.agendamento.funcionario = funcionarios[index]
        : widget.agendamento.funcionario = Usuario();
  }

  void ativarDesativarBotao() {
    if (widget.agendamento.funcionario.id == null) {
      selecionadoUmFuncionario = false;
      corBotao = Colors.grey.withOpacity(0.9);
      overlayCorBotao = Colors.transparent;
    } else {
      selecionadoUmFuncionario = true;
      corBotao = Colors.black87.withOpacity(0.9);
      overlayCorBotao = AppColors.blue5;
    }
  }
}
