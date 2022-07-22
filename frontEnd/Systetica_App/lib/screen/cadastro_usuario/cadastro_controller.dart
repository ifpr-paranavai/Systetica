import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:systetica/components/loading/show_loading_widget.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/components/show_modal_sucesso_widget.dart';
import 'package:systetica/components/texto_erro_widget.dart';
import 'package:systetica/model/CidadeDTO.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/request/dio_config.dart';
import 'package:systetica/screen/cadastro_usuario/cadastro_service.dart';
import 'package:systetica/screen/cadastro_usuario/view/ativar_usuario/ativar_usuario_page.dart';
import 'package:systetica/screen/inicio/view/inicio_page.dart';

class CadastroController {
  final nomeController = TextEditingController();
  final dataNascimentoController = TextEditingController();
  final cpfController = TextEditingController();
  final telefone1 = TextEditingController();
  final telefone2 = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmaSenhaController = TextEditingController();
  final confirmaEstadoController = TextEditingController();
  final codicoController = TextEditingController();
  String imagemBase64 = "";
  var myPageTransition = MyPageTransition();
  final formKey = GlobalKey<FormState>();

  MultiValidator get nomeValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
    ]);
  }

  MultiValidator get dataValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
    ]);
  }

  MultiValidator get cpfValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
      MinLengthValidator(
        11,
        errorText: 'Campo deve possuir no menos 11 caracteres',
      ),
    ]);
  }

  MultiValidator get telefoneValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
    ]);
  }

  MultiValidator get emailValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
      EmailValidator(errorText: 'E-mail inválido'),
    ]);
  }

  MultiValidator get senhaValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
      MinLengthValidator(
        6,
        errorText: 'Campo deve ter ao menos 6 dígitos',
      ),
    ]);
  }

  MultiValidator get confirmaSenhaValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
      MinLengthValidator(
        6,
        errorText: 'Campo deve ter ao menos 6 caracteres',
      ),
    ]);
  }

  MultiValidator get codigoValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
      MinLengthValidator(
        6,
        errorText: 'Campo deve possuir no menos 6 caracteres',
      ),
    ]);
  }

  Future<void> cadastrarUsuario(
    BuildContext context,
    CidadeDTO? cidadeDTO,
    Widget widget,
  ) async {
    var connected = await ConnectionCheck.check();
    if (connected) {
      // Verificar se senha e confirma senha são idênticos
      if (senhaController.text != confirmaSenhaController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
            padding: EdgeInsets.all(18),
            content: TextoErroWidget(
              mensagem: "Senha e confirma senha devem ser iguais",
            ),
          ),
        );
        return;
      }

      if (imagemBase64.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
            padding: EdgeInsets.all(18),
            content: TextoErroWidget(
              mensagem: "Por favor, adicione uma foto de perfil",
            ),
          ),
        );
        return;
      }
      if (formKey.currentState != null) {
        if (formKey.currentState?.validate() ?? true) {
          try {
            UsuarioDTO usuarioDTO = UsuarioDTO(
              nome: nomeController.text,
              dataNascimento: dataNascimentoController.text,
              cpf: cpfController.text,
              telefone1: telefone1.text,
              telefone2: telefone2.text,
              email: emailController.text,
              password: senhaController.text,
              cidade: cidadeDTO,
              imagemBase64: imagemBase64,
            );

            //Loading apresentado na tela
            var contextLoading = context;
            var loading = ShowLoadingWidget.showLoadingLabel(
              contextLoading,
              "Aguarde...",
            );

            var infoResponse =
                await CadastroService.cadastroUsuario(usuarioDTO);

            // Finaliza o loading na tela
            Navigator.pop(contextLoading, loading);

            var showModalOkWidget = ShowModalOkWidget();
            if (infoResponse.success!) {
              Navigator.of(context).push(
                myPageTransition.pageTransition(
                  child: const AtivarUsuarioPage(),
                  childCurrent: widget,
                ),
              );
            } else {
              showModalOkWidget.showModalOk(context,
                  title: "Erro",
                  description: infoResponse.message!,
                  buttonText: "OK",
                  onPressed: () => Navigator.pop(context));
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.blueGrey,
                content: TextoErroWidget(
                  mensagem: "Ocorreu algum erro de comunicação com o servidor",
                ),
              ),
            );
          }
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          padding: EdgeInsets.all(12),
          content: TextoErroWidget(
            mensagem: "Por Favor, conecte-se a rede para cadastrar um usuário",
          ),
        ),
      );
    }
  }

  ativiarUsuario(BuildContext context) async {
    var connected = await ConnectionCheck.check();
    if (connected) {
      try {
        UsuarioDTO usuarioDTO = UsuarioDTO(
          email: emailController.text,
          codigoAleatorio: int.parse(codicoController.text),
        );

        //Loading apresentado na tela
        var contextLoading = context;
        var loading = ShowLoadingWidget.showLoadingLabel(
          contextLoading,
          "Aguarde...",
        );

        var infoResponse = await CadastroService.ativarUsuario(usuarioDTO);

        // Finaliza o loading na tela
        Navigator.pop(contextLoading, loading);

        var showModalOkWidget = ShowModalOkWidget();
        if (infoResponse.success!) {
          showModalOkWidget.showModalOk(
            context,
            title: "Sucesso",
            description: "Usuário foi ativiado com sucesso",
            buttonText: "OK",
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const InicioPage(),
                ),
                (route) => false),
          );
        } else {
          showModalOkWidget.showModalOk(context,
              title: "Erro",
              description: infoResponse.message!,
              buttonText: "OK",
              onPressed: () => Navigator.pop(context));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: TextoErroWidget(
              mensagem: "Ocorreu algum erro de comunicação com o servidor",
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          padding: EdgeInsets.all(12),
          content: TextoErroWidget(
            mensagem: "Por Favor, conecte-se a rede para cadastrar um usuário",
          ),
        ),
      );
    }
  }
}
