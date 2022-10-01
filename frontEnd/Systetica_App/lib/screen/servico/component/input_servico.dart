import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/input/campo_texto_widget.dart';
import 'package:systetica/components/input/custom_switch.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/validator/MultiValidatorServico.dart';
import 'package:systetica/screen/servico/servico_controller.dart';

class InputServico {
  // Opções para cadatrar servico
  TextAutenticacoesWidget textoCadastrarServico({required String texto}) {
    return TextAutenticacoesWidget(
      text: texto,
      fontSize: 30,
      paddingBottom: 6,
    );
  }

  CampoTextoWidget inputNomeServico({
    required double paddingHorizontal,
    required ServicoController controller,
    required MultiValidatorServico validatorServico,
  }) {
    return CampoTextoWidget(
      labelText: "Nome",
      paddingHorizontal: paddingHorizontal * 0.08,
      paddingBottom: 0,
      maxLength: 50,
      paddingTop: 14,
      isIconDate: true,
      icon: const Icon(
        Icons.construction,
        color: Colors.black87,
      ),
      controller: controller.nomeController,
      validator: validatorServico.nomeValidator,
    );
  }

  CampoTextoWidget inputTempoServico({
    required double paddingHorizontal,
    required ServicoController controller,
    required MultiValidatorServico validatorServico,
  }) {
    return CampoTextoWidget(
      labelText: "Duração do Serviço",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      paddingBottom: 0,
      maxLength: 3,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        CupertinoIcons.time_solid,
        color: Colors.black87,
      ),
      controller: controller.tempoServicoController,
      validator: validatorServico.tempoServicoValidator,
    );
  }

  CampoTextoWidget inputPreco({
    required double paddingHorizontal,
    required ServicoController controller,
    required MultiValidatorServico validatorServico,
  }) {
    return CampoTextoWidget(
      labelText: "Preço",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      mask: "##.##",
      paddingBottom: 0,
      maxLength: 6,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        CupertinoIcons.money_dollar,
        color: Colors.black87,
      ),
      controller: controller.precoController,
      validator: validatorServico.precoValidator,
    );
  }

  CampoTextoWidget inputDescricao({
    required double paddingHorizontal,
    required ServicoController controller,
    required MultiValidatorServico validatorServico,
  }) {
    return CampoTextoWidget(
      labelText: "Descrição",
      paddingHorizontal: paddingHorizontal * 0.08,
      paddingBottom: 0,
      maxLength: 250,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        CupertinoIcons.text_alignleft,
        color: Colors.black87,
      ),
      controller: controller.descricaoController,
    );
  }

  CustomSwitch customSwitch({
    required double paddingHorizontal,
    required ServicoController controller,
    required Function(bool) onChanged,
  }) {
    return CustomSwitch(
      paddingBottom: 0,
      paddingHorizontal: paddingHorizontal * 0.08,
      label: "Status",
      value: controller.status ?? true,
      onChanged: onChanged,
    );
  }

  BotaoWidget botaoCadastrar({
    required String label,
    required VoidCallback onPressed,
  }) {
    return BotaoWidget(
      paddingTop: 18,
      paddingBottom: 30,
      labelText: label,
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: onPressed,
    );
  }
}
