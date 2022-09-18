import 'package:flutter/material.dart';
import 'package:systetica/style/app_colors..dart';

class ItemLista extends StatelessWidget {
  const ItemLista({
    Key? key,
    required this.descricao,
    required this.titulo,
    this.paddingHorizonta = 18,
    this.colorDescricao = Colors.black,
  }) : super(key: key);

  final String titulo;
  final String descricao;
  final double paddingHorizonta;
  final Color colorDescricao;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizonta,
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
            colorDescricao: Colors.black,
          ),
          sizedBox(
            height: 3,
          ),
          text(
            text: descricao,
            fontSize: 15.5,
            opacity: 0.5,
            fontWeight: FontWeight.normal,
            colorDescricao: colorDescricao,
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
    required Color colorDescricao,
  }) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: colorDescricao.withOpacity(opacity),
      ),
    );
  }

  SizedBox sizedBox({double? height = 10}) {
    return SizedBox(
      height: height,
    );
  }
}
