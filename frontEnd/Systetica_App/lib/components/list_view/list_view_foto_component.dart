import 'package:flutter/material.dart';
import 'package:systetica/components/foto/foto_widget.dart';

class ListViewFotoOrNumeroComponent extends StatefulWidget {
  const ListViewFotoOrNumeroComponent({
    Key? key,
    required this.largura,
    required this.altura,
    required this.infoNome,
    required this.onTap,
    this.numero,
    this.foto,
    this.widgetFoto = true,
  }) : super(key: key);

  final double largura;
  final double altura;
  final String infoNome;
  final int? numero;
  final String? foto;
  final bool widgetFoto;
  final GestureTapCallback onTap;

  @override
  State<ListViewFotoOrNumeroComponent> createState() => _ListViewFotooComponent();
}

class _ListViewFotooComponent extends State<ListViewFotoOrNumeroComponent> {
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
              widget.widgetFoto
                  ? Container(
                      width: widget.largura * 0.18,
                      alignment: Alignment.centerLeft,
                      child: FotoWidget().boxFoto(
                        imagemUsuario: widget.foto,
                        cirulo: 75,
                      ),
                    )
                  : info(
                      informacao: widget.numero.toString(),
                    ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: info(
                    informacao: widget.infoNome,
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
  }) {
    return Text(
      informacao,
      maxLines: 1,
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 19,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
