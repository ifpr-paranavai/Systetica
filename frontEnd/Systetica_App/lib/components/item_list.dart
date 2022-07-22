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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizedBox(
            height: 7,
          ),
          text(
            text: titulo,
            fontSize: 16.5,
          ),
          sizedBox(
            height: 3,
          ),
          text(
            text: descricao,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          Divider(
            color: AppColors.redPrincipal.withOpacity(0.3),
          )
        ],
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
    );
  }

  SizedBox sizedBox({double? height = 10}) {
    return SizedBox(
      height: height,
    );
  }
}
