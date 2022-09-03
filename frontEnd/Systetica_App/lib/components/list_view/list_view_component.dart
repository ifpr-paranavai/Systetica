import 'package:flutter/material.dart';

class ListViewComponent extends StatefulWidget {
  const ListViewComponent({
    Key? key,
    required this.largura,
    required this.altura,
    required this.infoNome,
    this.infoPreco = "",
    required this.onTap,
    required this.numero,
    this.maxLinesInfo = 1,
  }) : super(key: key);

  final double largura;
  final double altura;
  final String infoNome;
  final String infoPreco;
  final int numero;
  final int maxLinesInfo;
  final GestureTapCallback onTap;

  @override
  State<ListViewComponent> createState() => _ListViewComponent();
}

class _ListViewComponent extends State<ListViewComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: widget.largura * 0.05),
      height: widget.altura * 0.10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(
          color: Colors.black,
          width: 0.1,
        ),
      ),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 18,
            top: 10,
            bottom: 10,
            right: 18,
          ),
          child: Row(
            children: [
              info(
                informacao: widget.numero.toString(),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: 180,
                child: info(
                  informacao: widget.infoNome,
                  maxLines: widget.maxLinesInfo,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: info(
                    informacao: widget.infoPreco,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: widget.onTap,
      ),
    );
  }

  Widget info({
    required String informacao,
    int maxLines = 1,
  }) {
    return Text(
      informacao,
      maxLines: maxLines,
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 19,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
