import 'package:flutter/material.dart';

import '../../../components/botoes/botao_widget.dart';
import '../../../components/text_autenticacoes_widget.dart';
import '../../../style/app_colors.dart';

class AgendarComponente {
  static Widget containerGeral({required Widget widget}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 15),
        alignment: Alignment.topCenter,
        color: AppColors.branco,
        child: widget,
      ),
    );
  }

  static Widget info({
    required double altura,
    required double largura,
    required String text,
  }) {
    return Container(
      padding: EdgeInsets.only(
        left: largura * 0.1,
        top: altura * 0.019,
      ),
      color: AppColors.branco,
      child: TextAutenticacoesWidget(
        text: text,
        fontSize: 30,
        paddingBottom: 6,
      ),
    );
  }

  static Widget botaoSelecinar({
    required double altura,
    required double largura,
    required Color corBotao,
    required Color overlayCorBotao,
    required VoidCallback? onPressed,
    String labelText = "CONTINUAR",
  }) {
    return Container(
      padding: EdgeInsets.only(
        bottom: altura * 0.03,
      ),
      alignment: Alignment.bottomCenter,
      child: BotaoWidget(
        paddingTop: 10,
        paddingBottom: 0,
        labelText: labelText,
        largura: largura * 0.6,
        corBotao: corBotao,
        corTexto: Colors.white,
        overlayColor: overlayCorBotao,
        onPressed: onPressed,
      ),
    );
  }
}
