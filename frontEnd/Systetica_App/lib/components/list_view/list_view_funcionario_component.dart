import 'package:flutter/material.dart';

class ListViewFuncionarioComponent extends StatefulWidget {
  const ListViewFuncionarioComponent({
    Key? key,
    required this.largura,
    required this.altura,
    required this.infoNome,
    required this.onTap,
    required this.numero,
  }) : super(key: key);

  final double largura;
  final double altura;
  final String infoNome;
  final int numero;
  final GestureTapCallback onTap;

  @override
  State<ListViewFuncionarioComponent> createState() =>
      _ListViewFuncionarioComponent();
}

class _ListViewFuncionarioComponent
    extends State<ListViewFuncionarioComponent> {
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
