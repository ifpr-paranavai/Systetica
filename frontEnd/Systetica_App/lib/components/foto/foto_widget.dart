import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:systetica/style/app_colors.dart';

class FotoWidget {
  Container boxFoto({
    required dynamic imagemUsuario,
    double cirulo = 160,
    bool iconErroAdd = false,
    VoidCallback? onPressed,
    double iconSizeErro = 100,
  }) {
    return Container(
      width: cirulo,
      height: cirulo,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black.withOpacity(0.6),
            spreadRadius: 2,
          )
        ],
      ),
      child: _imgPerfil(
        image: imagemUsuario,
        iconErroAdd: iconErroAdd,
        onPressed: onPressed,
        iconSizeErro: iconSizeErro,
      ),
    );
  }

  Widget _imgPerfil({
    required dynamic image,
    bool? iconErroAdd,
    VoidCallback? onPressed,
    required double iconSizeErro,
  }) {
    if (image == null || image == "") {
      return iconErroAdd == true
          ? _iconErroFotoAdd(onPressed: onPressed!)
          : _iconErroFoto(iconSizeErro: iconSizeErro);
    } else {
      image = base64Decode(image);
      if (image is Uint8List) {
        return _circleAvatar(backgroundImage: MemoryImage(image));
      } else {
        return _circleAvatar(backgroundImage: FileImage(image));
      }
    }
  }

  CircleAvatar _circleAvatar({required ImageProvider backgroundImage}) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      backgroundImage: backgroundImage,
    );
  }

  Container _iconErroFoto({required double iconSizeErro}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.redPrincipal,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black.withOpacity(0.6),
            spreadRadius: 2,
          )
        ],
      ),
      child: Icon(
        Icons.person,
        size: iconSizeErro,
        color: Colors.white,
      ),
    );
  }

  // Widgets de erro
  Widget _iconErroFotoAdd({
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        color: AppColors.redPrincipal,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black.withOpacity(0.6),
            spreadRadius: 2,
          )
        ],
      ),
      child: IconButton(
        icon: const Icon(
          Icons.edit,
          size: 100,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
