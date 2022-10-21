import 'package:flutter/material.dart';
import 'package:systetica/style/app_colors.dart';

class ListViewHorariosComponent extends StatefulWidget {
  const ListViewHorariosComponent({
    Key? key,
    required this.dia,
    required this.horario,
  }) : super(key: key);

  final String dia;
  final String horario;

  @override
  State<ListViewHorariosComponent> createState() => _ListViewHorarioComponent();
}

class _ListViewHorarioComponent extends State<ListViewHorariosComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
        top: 4,
        bottom: 4,
        right: 18,
      ),
      child: Column(
        children: [
          Row(
            children: [
              info(
                informacao: widget.dia,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: info(
                    informacao: widget.horario,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: AppColors.redPrincipal.withOpacity(0.3),
          ),
        ],
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
        fontSize: 16.5,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
