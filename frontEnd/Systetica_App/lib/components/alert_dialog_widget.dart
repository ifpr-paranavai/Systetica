import 'package:flutter/material.dart';
import 'package:systetica/style/app_colors..dart';

class AlertDialogWidget {
  alertDialog({
    required bool showModalOk,
    required BuildContext context,
    required String titulo,
    required String descricao,
    String? buttonText,
    double fontSizedescricao = 18,
    VoidCallback? onPressedOk,
    VoidCallback? onPressedNao,
  }) async {
    if (showModalOk == true) {
      return await _alertDialogOk(
        context: context,
        titulo: titulo,
        descricao: descricao,
        buttonText: buttonText!,
        onPressed: onPressedOk,
        fontSizedescricao: fontSizedescricao,
      );
    } else {
      return await _alertDialogSimNao(
        context: context,
        titulo: titulo,
        descricao: descricao,
        fontSizedescricao: fontSizedescricao,
        onPressedSim: onPressedOk,
        onPressedNao: onPressedNao,
      );
    }
  }

  Future<Widget> _alertDialogOk({
    required BuildContext context,
    required String titulo,
    required String descricao,
    required String buttonText,
    required double fontSizedescricao,
    required VoidCallback? onPressed,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _certer(
        title: _textTitulo(
          titulo: titulo,
        ),
        content: _textDescricao(
          descricao: descricao,
          fontSizedescricao: fontSizedescricao,
        ),
        actions: [
          _textButton(
            texto: buttonText,
            fontSizedescricao: fontSizedescricao,
            overlayColor: Colors.green.withOpacity(0.5),
            onPressed: onPressed!,
          ),
        ],
      ),
    );
  }

  _alertDialogSimNao({
    required BuildContext context,
    required String titulo,
    required String descricao,
    required double fontSizedescricao,
    required VoidCallback? onPressedSim,
    required VoidCallback? onPressedNao,
  }) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => _certer(
        title: _textTitulo(
          titulo: titulo,
          colorText: AppColors.redPrincipal,
        ),
        content: _textDescricao(
          descricao: descricao,
          fontSizedescricao: fontSizedescricao,
        ),
        actions: [
          _textButton(
            texto: "Não",
            fontSizedescricao: fontSizedescricao,
            overlayColor: AppColors.bluePrincipal.withOpacity(0.5),
            onPressed: onPressedNao!,
          ),
          _textButton(
            texto: "Sim",
            fontSizedescricao: fontSizedescricao,
            overlayColor: Colors.green.withOpacity(0.5),
            onPressed: onPressedSim!,
          ),
        ],
      ),
    );
  }

  Center _certer({
    required Widget title,
    required Widget content,
    required List<Widget> actions,
  }) {
    return Center(
      child: WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          title: title,
          content: content,
          actions: actions,
        ),
      ),
    );
  }

  Text _textTitulo({
    required String titulo,
    Color colorText = Colors.black,
  }) {
    return Text(
      titulo,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: colorText,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Text _textDescricao({
    required String descricao,
    required double fontSizedescricao,
  }) {
    return Text(
      descricao,
      maxLines: 5,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSizedescricao,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  TextButton _textButton({
    required String texto,
    required double fontSizedescricao,
    required Color overlayColor,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      child: Text(
        texto,
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSizedescricao,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          overlayColor,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
