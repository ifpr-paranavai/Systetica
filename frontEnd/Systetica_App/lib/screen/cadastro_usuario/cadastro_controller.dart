import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';

import '../../components/alert_dialog_widget.dart';
import '../../components/loading/show_loading_widget.dart';
import '../../components/texto_erro_widget.dart';
import '../../components/page_transition.dart';
import '../../model/Usuario.dart';
import '../../request/dio_config.dart';
import '../../screen/cadastro_usuario/view/ativar_usuario/ativar_usuario_page.dart';
import '../../style/app_colors.dart';
import '../inicio/view/inicio_page.dart';
import 'cadastro_service.dart';

class CadastroController {
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmaSenhaController = TextEditingController();
  final confirmaEstadoController = TextEditingController();
  final codicoController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var myPageTransition = MyPageTransition();

  Future<void> cadastrarUsuario(BuildContext context, Widget widget) async {
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

      if (formKey.currentState != null) {
        if (formKey.currentState?.validate() ?? true) {
          try {
            Usuario usuario = Usuario(
              nome: nomeController.text,
              telefone: telefoneController.text,
              email: emailController.text,
              password: senhaController.text,
            );

            //Loading apresentado na tela
            var contextLoading = context;
            var loading = ShowLoadingWidget.showLoadingLabel(
              contextLoading,
              "Aguarde...",
            );

            var infoResponse = await CadastroService.cadastrarUsuario(usuario);

            // Finaliza o loading na tela
            Navigator.pop(contextLoading, loading);

            var alertDialog = AlertDialogWidget();
            if (infoResponse.success!) {
              await alertDialog.alertDialog(
                showModalOk: false,
                context: context,
                titulo: "Usuário Cadastrado!",
                corTitulo: AppColors.bluePrincipal,
                descricao:
                    "Um email com código de ativação foi enviado.\nDesejar abrir seu email?",
                onPressedNao: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    myPageTransition.pageTransition(
                      child: const AtivarUsuarioPage(),
                      childCurrent: widget,
                    ),
                  );
                },
                onPressedOk: () async {
                  await OpenMailApp.openMailApp(
                    nativePickerTitle: 'Selecione o aplicativo de email.',
                  );
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    myPageTransition.pageTransition(
                      child: const AtivarUsuarioPage(),
                      childCurrent: widget,
                    ),
                  );
                },
              );
            } else {
              alertDialog.alertDialog(
                showModalOk: true,
                context: context,
                titulo: "Erro",
                descricao: infoResponse.message!,
                buttonText: "OK",
                onPressedOk: () => Navigator.pop(context),
              );
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

  Future<void> ativiarUsuario(BuildContext context) async {
    var connected = await ConnectionCheck.check();
    if (connected) {
      try {
        Usuario usuario = Usuario(
          email: emailController.text,
          codigoAleatorio: int.parse(codicoController.text),
        );

        //Loading apresentado na tela
        var contextLoading = context;
        var loading = ShowLoadingWidget.showLoadingLabel(
          contextLoading,
          "Aguarde...",
        );

        var infoResponse = await CadastroService.ativarUsuario(usuario);

        // Finaliza o loading na tela
        Navigator.pop(contextLoading, loading);

        var alertDialog = AlertDialogWidget();
        if (infoResponse.success!) {
          alertDialog.alertDialog(
            showModalOk: true,
            context: context,
            titulo: "Sucesso",
            descricao: "Usuário ativado com sucesso",
            buttonText: "OK",
            onPressedOk: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const InicioPage(),
              ),
              (route) => false,
            ),
          );
        } else {
          alertDialog.alertDialog(
            showModalOk: true,
            context: context,
            titulo: "Erro",
            descricao: infoResponse.message!,
            buttonText: "OK",
            onPressedOk: () => Navigator.pop(context),
          );
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
