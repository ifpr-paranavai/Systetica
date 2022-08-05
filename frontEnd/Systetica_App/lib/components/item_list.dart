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
        horizontal: 18,
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
            opacity: 0.6,
            fontWeight: FontWeight.w700,
          ),
          sizedBox(
            height: 3,
          ),
          text(
            text: descricao,
            fontSize: 15.5,
            opacity: 0.5,
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
    required double opacity,
    required FontWeight fontWeight,
  }) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: Colors.black.withOpacity(opacity),
      ),
    );
  }

  SizedBox sizedBox({double? height = 10}) {
    return SizedBox(
      height: height,
    );
  }
}
