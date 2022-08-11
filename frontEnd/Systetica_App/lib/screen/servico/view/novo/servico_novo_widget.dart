import 'package:flutter/material.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/model/Servico.dart';
import 'package:systetica/model/validator/MultiValidatorServico.dart';
import 'package:systetica/screen/servico/component/input_servico.dart';
import 'package:systetica/screen/servico/servico_controller.dart';
import 'package:systetica/screen/servico/view/novo/servico_novo_page.dart';

class ServicoNovoWidget extends State<ServicoNovoPage> {
  final ServicoController _controller = ServicoController();
  final InputServico _inputEmpresa = InputServico();
  final MultiValidatorServico _validatorServico = MultiValidatorServico();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller.servico = Servico();
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
          paddingTop: _altura * 0.01,
          onPressed: () => Navigator.pop(context),
        ),
        body: SingleChildScrollView(
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
                  _inputEmpresa.textoCadastrarServico(),
                  _inputEmpresa.inputNomeServico(
                    paddingHorizontal: _largura,
                    controller: _controller,
                    validatorServico: _validatorServico,
                  ),
                  _inputEmpresa.inputTempoServico(
                    paddingHorizontal: _largura,
                    controller: _controller,
                    validatorServico: _validatorServico,
                  ),
                  _inputEmpresa.inputPreco(
                    paddingHorizontal: _largura,
                    controller: _controller,
                    validatorServico: _validatorServico,
                  ),
                  _inputEmpresa.inputDescricao(
                    paddingHorizontal: _largura,
                    controller: _controller,
                    validatorServico: _validatorServico,
                  ),
                  _inputEmpresa.botaoCadastrar(
                    label: "Cadastrar",
                    onPressed: () => _controller.cadastrarServico(context).then(
                          (value) => Navigator.pop(context),
                        ),
                  ),
                ],
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
