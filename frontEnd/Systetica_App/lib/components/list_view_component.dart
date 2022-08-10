import 'package:flutter/material.dart';

class ListViewComponent extends StatefulWidget {
  const ListViewComponent({
    Key? key,
    required this.largura,
    required this.altura,
    required this.titulo1,
    required this.titulo2,
    required this.descricao1,
    required this.descricao2,
    required this.onTap,
    required this.numero,
  }) : super(key: key);

  final double largura;
  final double altura;
  final String titulo1;
  final String titulo2;
  final String descricao1;
  final String descricao2;
  final int numero;
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
              text(
                titulo: widget.numero.toString(),
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    row(
                      titulo: widget.titulo1,
                      descricao: widget.descricao1,
                    ),
                    const SizedBox(height: 5),
                    row(
                      titulo: widget.titulo2,
                      descricao: widget.descricao2,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: widget.altura * 0.8,
                    width: widget.largura * 0.11,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen.withOpacity(.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.construction,
                      color: Colors.lightGreen.withOpacity(.9),
                      size: 30,
                    ),
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

  Row row({
    required String titulo,
    required String descricao,
  }) {
    return Row(
      children: [
        text(
          titulo: titulo,
          fontWeight: FontWeight.w700,
          fontSize: 16.5,
        ),
        text(
          titulo: descricao,
          fontWeight: FontWeight.normal,
          fontSize: 15.5,
        ),
      ],
    );
  }

  Text text({
    required String titulo,
    required FontWeight fontWeight,
    required double fontSize,
  }) {
    return Text(
      titulo,
      maxLines: 1,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
