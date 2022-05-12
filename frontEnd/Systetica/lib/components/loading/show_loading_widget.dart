
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Class para criar Animação de carregamento na telas
class ShowLoadingWidget  {

  //Passa-se um texto para apresentar junto com o loading
  static showLoadingLabel(BuildContext context, String labelTexto) async {
    var loading = _createLoading(context, labelTexto);
    return loading;
  }

  //Criar um loading com o "aguarde" por padrão
  static showLoading(BuildContext context) async {
    var loading = _createLoading(context, "Aguarde...");
    return loading;
  }

  static _createLoading(BuildContext context, String labelTexto) async {
    var loading = await showDialog(barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          content: Row(
            children: [
              const CircularProgressIndicator(color: Colors.black),
              Container(
                  margin: const EdgeInsets.only(left: 40),
                  child: Text(labelTexto, style: const TextStyle(color: Colors.black, fontSize: 18),overflow: TextOverflow.clip, maxLines: 1)
              ),
            ],
          ),
        );
      },
    );
    return loading;
  }

}
