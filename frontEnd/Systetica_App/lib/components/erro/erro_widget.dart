import 'package:flutter/material.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';

class ErroWidget {
  Widget erroRequisicao({
    required bool listaVazia,
    required double largura,
    required double altura,
    String imagem = "list-vazia.png",
    required String nenhumItem,
  }) {
    return Expanded(
      child: Container(
        color: Colors.grey.withOpacity(0.2),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: altura * 0.14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    _imagemErro(
                      listaVazia: listaVazia,
                      imagem: imagem,
                    ),
                    _textoErro(
                      largura: largura,
                      listaVazia: listaVazia,
                      nenhumItem: nenhumItem,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ImagensWidget _imagemErro({
    required bool listaVazia,
    required String imagem,
  }) {
    return ImagensWidget(
      paddingLeft: 0,
      image: listaVazia ? imagem : "erro.png",
      widthImagem: 320,
    );
  }

  TextAutenticacoesWidget _textoErro({
    required double largura,
    required bool listaVazia,
    required String nenhumItem,
  }) {
    return TextAutenticacoesWidget(
      alignment: Alignment.center,
      paddingLeft: largura * (listaVazia ? 0.10 : 0.15),
      paddingRight: largura * 0.10,
      fontSize: 30,
      text: listaVazia
          ? nenhumItem
          : "Oopss...ocorreu algum erro. \nTente novamente mais tarde.",
    );
  }
}
