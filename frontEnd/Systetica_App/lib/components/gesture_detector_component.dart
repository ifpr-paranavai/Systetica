import 'package:flutter/material.dart';
import 'package:systetica/style/app_colors..dart';

class GestureDetectorComponent extends StatefulWidget {
  const GestureDetectorComponent({
    Key? key,
    required this.largura,
    required this.altura,
    required this.textNome,
    required this.precoMinuto,
    required this.servicoSelecionado,
    required this.onChanged,
    required this.onTap,
  }) : super(key: key);

  final double largura;
  final double altura;
  final String textNome;
  final String precoMinuto;
  final bool servicoSelecionado;
  final ValueChanged<dynamic>? onChanged;
  final GestureTapCallback? onTap;

  @override
  State<GestureDetectorComponent> createState() => _GestureDetectorComponent();
}

class _GestureDetectorComponent extends State<GestureDetectorComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.only(
          right: 15,
          left: 15,
          bottom: widget.largura * 0.04,
        ),
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
        child: Row(
          children: [
            _container(
              paddingLeft: 15,
              paddingRight: 0,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.textNome,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    widget.precoMinuto,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            _container(
              paddingLeft: 0,
              paddingRight: 15,
              alignment: Alignment.centerRight,
              widget: Checkbox(
                value: widget.servicoSelecionado,
                onChanged: widget.onChanged,
                shape: const CircleBorder(),
                fillColor: MaterialStateProperty.all(AppColors.bluePrincipal),
              ),
            ),
          ],
        ),
      ),
      onTap: widget.onTap,
    );
  }

  Widget _container({
    required double paddingLeft,
    required double paddingRight,
    required Widget widget,
    AlignmentGeometry alignment = Alignment.centerLeft,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          left: paddingLeft,
          right: paddingRight,
        ),
        alignment: alignment,
        height: 80,
        child: widget,
      ),
    );
  }
}
