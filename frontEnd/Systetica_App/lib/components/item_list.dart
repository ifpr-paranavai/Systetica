import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:systetica/style/app_colors..dart';

class ItemLista extends StatelessWidget {
  const ItemLista({
    Key? key,
    required this.descricao,
    required this.titulo,
  }) : super(key: key);

  final String titulo;
  final String descricao;

//todo -renomear
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextButton.icon(
        onPressed: () => {},
        icon: const Padding(
          padding: EdgeInsets.only(bottom: 20, right: 8),
          child: Icon(Icons.edit),
        ),
        label: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              text(
                text: titulo,
                fontSize: 16.5,
              ),
              text(
                text: descricao,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              Divider(
                color: AppColors.redPrincipal.withOpacity(0.4),
              ),
            ],
          ),
        ),
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
      ),
    );
  }

  Text text({
    required String text,
    required double fontSize,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
    );
  }

  SizedBox sizedBox({double? height = 10}) {
    return SizedBox(
      height: height,
    );
  }
}
