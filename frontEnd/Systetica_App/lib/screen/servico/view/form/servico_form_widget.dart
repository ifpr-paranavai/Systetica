import 'package:flutter/material.dart';

import '../../../../components/icon_arrow_widget.dart';
import '../../../../model/Servico.dart';
import '../../../../model/validator/MultiValidatorServico.dart';
import '../../../../style/app_colors..dart';
import '../../component/input_servico.dart';
import '../../servico_controller.dart';
import 'servico_form_page.dart';

class ServicoFormWidget extends State<ServicoFormPage> {
  final ServicoController _controller = ServicoController();
  final InputServico _inputServico = InputServico();
  final MultiValidatorServico _validatorServico = MultiValidatorServico();
  late ScrollController _scrollController;
  bool edicao = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Servico? servico = widget.servico;
    if (servico == null) {
      _controller.servico = Servico();
    } else {
      edicao = true;
      _controller.servico = servico;
      _controller.nomeController.text = _controller.servico.nome!;
      _controller.tempoServicoController.text =
          _controller.servico.tempoServico.toString();
      _controller.descricaoController.text = _controller.servico.descricao!;
      _controller.precoController.text = _controller.servico.preco.toString();
      _controller.status = _controller.servico.status;
    }
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
          paddingTop: _altura * 0.01,
          onPressed: () => Navigator.pop(context),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _controller.formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _sizedBox(height: _altura * 0.15),
                    _inputServico.textoCadastrarServico(
                      texto: "Cadastrar Serviço",
                    ),
                    _inputServico.inputNomeServico(
                      paddingHorizontal: _largura,
                      controller: _controller,
                      validatorServico: _validatorServico,
                    ),
                    _inputServico.inputTempoServico(
                      paddingHorizontal: _largura,
                      controller: _controller,
                      validatorServico: _validatorServico,
                    ),
                    _inputServico.inputPreco(
                      paddingHorizontal: _largura,
                      controller: _controller,
                      validatorServico: _validatorServico,
                    ),
                    _inputServico.inputDescricao(
                      paddingHorizontal: _largura,
                      controller: _controller,
                      validatorServico: _validatorServico,
                    ),
                    edicao
                        ? _inputServico.customSwitch(
                            paddingHorizontal: _largura,
                            controller: _controller,
                            onChanged: (bool value) {
                              setState(() {
                                _controller.status = value;
                              });
                            },
                          )
                        : Container(),
                    _inputServico.botaoCadastrar(
                      label: edicao ? "SALVAR" : "CADASTRAR",
                      onPressed: () => edicao
                          ? _controller.atualizarServico(context).then(
                                (value) => Navigator.pop(context),
                              )
                          : _controller.cadastrarServico(context).then(
                                (value) => Navigator.pop(context),
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
