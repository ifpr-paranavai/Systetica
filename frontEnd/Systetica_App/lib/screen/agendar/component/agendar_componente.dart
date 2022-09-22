import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';

class AgendarComponente {
  static Widget containerGeral({required Widget widget}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 15),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0.2, 0.03),
            colors: [Colors.grey.withOpacity(0.2), Colors.white],
          ),
        ),
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
        top: altura * 0.017,
      ),
      color: Colors.grey.withOpacity(0.2),
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
  }) {
    return Container(
      padding: EdgeInsets.only(
        bottom: altura * 0.03,
      ),
      alignment: Alignment.bottomCenter,
      child: BotaoWidget(
        paddingTop: 10,
        paddingBottom: 0,
        labelText: "CONTINUAR",
        largura: largura * 0.6,
        corBotao: corBotao,
        corTexto: Colors.white,
        overlayColor: overlayCorBotao,
        onPressed: onPressed,
      ),
    );
  }
}
