import 'package:flutter/material.dart';

class ShowModalOkWidget {
  showModalOk(
    BuildContext context, {
    String? title,
    required String description,
    required String buttonText,
    double fontSizeDescription = 18,
    required VoidCallback? onPressed,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: WillPopScope(
          onWillPop: () async => false,
          child: _alertDialog(
            title: title,
            description: description,
            buttonText: buttonText,
            onPressed: onPressed,
            fontSizeDescription: fontSizeDescription,
          ),
        ),
      ),
    );
  }

  AlertDialog _alertDialog({
    required String? title,
    required String description,
    required String buttonText,
    required double fontSizeDescription,
    required VoidCallback? onPressed,
  }) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: title != null
          ? Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
            )
          : null,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      content: Text(
        description,
        maxLines: 5,
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSizeDescription,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
