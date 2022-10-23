import 'package:flutter/material.dart';

import '../style/app_colors.dart';
import '../utils/util.dart';
import 'imagens_widget.dart';
import 'text_autenticacoes_widget.dart';
import 'item_list.dart';

class HorarioComponent {
  Widget titulo({
    required double largura,
    required double altura,
    String text = "AGENDAMENTOS"
  }) {
    return Container(
      padding: EdgeInsets.only(
        left: largura,
        top: altura,
      ),
      color: AppColors.branco,
      child: TextAutenticacoesWidget(
        text: text,
        fontSize: 30,
        paddingBottom: 6,
        paddingLeft: 0,
      ),
    );
  }

  Widget cardHorario({
    required List<Widget> children,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 15),
        alignment: Alignment.topCenter,
        color: AppColors.branco,
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget cardInformacoes({
    required double largura,
    required String nome,
    required String dataAgendamento,
    required String horarioAgendamento,
    required String situacao,
  }) {
    return Column(
      children: [
        HorarioComponent().sizedBox(height: 5),
        Row(
          children: [
            SizedBox(
              width: largura,
              child: HorarioComponent().itemNome(
                nome,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right_outlined,
              size: 32,
            ),
          ],
        ),
        HorarioComponent().itemDataHorario(
          Util.dataEscrito(
                DateTime.parse(dataAgendamento),
              ) +
              ' ás ' +
              horarioAgendamento,
        ),
        HorarioComponent().itemStatus(situacao),
      ],
    );
  }

  ItemLista itemNome(String nome) {
    return ItemLista(
      titulo: "Nome",
      descricao: nome,
      maxLines: 1,
    );
  }

  ItemLista itemDataHorario(String data) {
    return ItemLista(
      titulo: "Data e horário",
      descricao: data,
    );
  }

  ItemLista itemStatus(String status) {
    return ItemLista(
      titulo: "Status",
      descricao: status,
    );
  }

  SizedBox sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  ImagensWidget imagemErro({
    required double altura,
  }) {
    return ImagensWidget(
      paddingTop: altura * 0.1,
      image: "calendario.png",
      widthImagem: 300,
    );
  }

  TextAutenticacoesWidget textoErro() {
    return TextAutenticacoesWidget(
      alignment: Alignment.center,
      paddingTop: 10,
      fontSize: 30,
      text: "Nenhum agendamento encontrado.",
    );
  }

  Widget tituloDetalhes({
    required String texto,
    Color corFornte = Colors.black87,
  }) {
    return Container(
      padding: const EdgeInsets.only(
        left: 22,
        bottom: 8,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        texto,
        maxLines: 1,
        style: TextStyle(
          fontSize: 16,
          color: corFornte.withOpacity(0.6),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget listSelecao({
    required double largura,
    required String nome,
    required IconData icon,
    String subTitulo = '',
    int maxLines = 1,
    bool terSubTituulo = true,
    Color colorIcon = AppColors.bluePrincipal,
  }) {
    return Container(
      margin: EdgeInsets.only(
        bottom: largura * 0.05,
        left: 20,
        right: 20,
      ),
      width: largura,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(
          color: Colors.black,
          width: 0.1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 18,
          right: 5,
          top: 13,
          bottom: 13,
        ),
        child: Row(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                child: Icon(
                  icon,
                  color: colorIcon,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: largura * 0.67,
                  child: info(
                    maxLines: maxLines,
                    informacao: nome,
                  ),
                ),
                terSubTituulo == true
                    ? info(
                        maxLines: maxLines,
                        informacao: subTitulo,
                        fontSize: 15.5,
                      )
                    : const SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget info({
    required String informacao,
    int maxLines = 1,
    double fontSize = 18,
  }) {
    return Text(
      informacao,
      maxLines: maxLines,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: fontSize,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
