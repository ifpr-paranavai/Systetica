import 'package:flutter/material.dart';
import 'package:systetica/components/texto_erro_widget.dart';
import 'package:systetica/model/CidadeDTO.dart';
import 'package:systetica/model/LoginDTO.dart';
import 'package:systetica/request/dio_config.dart';
import 'package:systetica/screen/autenticacao/autenticacao_service.dart';
import 'package:systetica/screen/autenticacao/cadastro/view/cadastro_page.dart';
import 'package:systetica/screen/autenticacao/login/login_service.dart';
import 'package:systetica/utils/validacoes.dart';

class AutenticacaoController {
  cadastrarUsuario(BuildContext context) async {
    var connected = await ConnectionCheck.check();
    if (connected) {
      try {
        List<CidadeDTO> cidades =
            await AutenticacaoService.buscarTodasCidades();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CadastroPage(
                    cidades: cidades,
                  )),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: TextoErroWidget(
                mensagem: "Ocorreu algum erro de comunicação com o servidor")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.blueGrey,
        padding: EdgeInsets.all(12),
        content: TextoErroWidget(
            mensagem: "Por Favor, conecte-se a rede para cadastrar um usuário"),
      ));
    }
  }
}
