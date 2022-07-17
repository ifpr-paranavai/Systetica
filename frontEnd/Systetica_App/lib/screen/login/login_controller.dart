import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:systetica/components/loading/show_loading_widget.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/components/show_modal_sucesso_widget.dart';
import 'package:systetica/components/texto_erro_widget.dart';
import 'package:systetica/database/orm/token_orm.dart';
import 'package:systetica/database/repository/token_repository.dart';
import 'package:systetica/model/LoginDTO.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/request/dio_config.dart';
import 'package:systetica/screen/home/view/home_page.dart';
import 'package:systetica/screen/inicio/view/inicio_page.dart';
import 'package:systetica/screen/login/login_service.dart';
import 'package:systetica/screen/login/view/alterar_senha/alterar_senha_page.dart';
import 'package:systetica/utils/validacoes.dart';

class LoginController {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final cpfController = TextEditingController();
  final codicoController = TextEditingController();
  final confirmaSenhaController = TextEditingController();
  var myPageTransition = MyPageTransition();
  final formKey = GlobalKey<FormState>();

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

  MultiValidator get cpfValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
      MinLengthValidator(
        11,
        errorText: 'Campo deve possuir no menos 11 caracteres',
      ),
    ]);
  }

  MultiValidator get codigoValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
      MinLengthValidator(
        6,
        errorText:
            'Campo deve possuir no menos 6 caracteres',
      ),
    ]);
  }

  Future<void> login(BuildContext context, Widget widget) async {
    var connected = await ConnectionCheck.check();
    if (connected) {
      if (formKey.currentState != null) {
        if (formKey.currentState?.validate() ?? true) {
          //Loading apresentado na tela
          var contextLoading = context;
          var loading = ShowLoadingWidget.showLoadingLabel(
            contextLoading,
            "Aguarde...",
          );
          try {
            LoginDTO login = LoginDTO(
              email: emailController.text,
              password: senhaController.text,
            );
            var tokenDto = await LoginService.login(login);

            // Verificar se já existe alguma Usuario cadastrado no banco
            TokenORM existeTokenORM = await TokenRepository.findToken();

            if (Validacoes.isIntegerNull(existeTokenORM.id) &&
                Validacoes.isEmptOrNull(existeTokenORM.accessToken) &&
                Validacoes.isEmptOrNull(existeTokenORM.refreshToken)) {
              TokenRepository.insertToken(tokenDto!);
            } else {
              existeTokenORM.id = existeTokenORM.id;
              TokenRepository.updateToken(existeTokenORM);
            }

            // Finaliza o loading na tela
            Navigator.pop(contextLoading, loading);

            Navigator.pushAndRemoveUntil(
              context,
              myPageTransition.pageTransition(
                child: const HomePage(),
                childCurrent: widget,
              ),
              (route) => false,
            );
          } catch (e) {
            // Finaliza o loading na tela
            Navigator.pop(contextLoading, loading);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.blueGrey,
                content: TextoErroWidget(
                  mensagem: "Usuário ou senha incorreto",
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

  Future<void> gerarCodigo(BuildContext context, Widget widget) async {
    var connected = await ConnectionCheck.check();
    if (connected) {
      if (formKey.currentState != null) {
        if (formKey.currentState?.validate() ?? true) {
          //Loading apresentado na tela
          var contextLoading = context;
          var loading = ShowLoadingWidget.showLoadingLabel(
            contextLoading,
            "Aguarde...",
          );
          try {
            UsuarioDTO usuarioDTO = UsuarioDTO(
              email: emailController.text,
              cpf: cpfController.text,
            );

            var infoResponse =
                await LoginService.gerarCodigoAlterarSenha(usuarioDTO);

            // Finaliza o loading na tela
            Navigator.pop(contextLoading, loading);

            var contextShowModal = context;
            var showModalOkWidget = ShowModalOkWidget();
            if (infoResponse.success!) {
              showModalOkWidget.showModalOk(
                context,
                title: "Sucesso",
                description:
                    "Código gerado e enviado em seu email com sucesso.",
                buttonText: "OK",
                onPressed: () {
                  Navigator.pop(
                    contextShowModal,
                    showModalOkWidget,
                  );
                  Navigator.of(context).push(
                    myPageTransition.pageTransition(
                      child: const AlterarSenhaPage(),
                      childCurrent: widget,
                    ),
                  );
                },
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

  Future<void> alterarSenha(BuildContext context, Widget widget) async {
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
          //Loading apresentado na tela
          var contextLoading = context;
          var loading = ShowLoadingWidget.showLoadingLabel(
            contextLoading,
            "Aguarde...",
          );
          try {
            UsuarioDTO usuarioDTO = UsuarioDTO(
              email: emailController.text,
              codigoAleatorio: int.parse(codicoController.text),
              password: senhaController.text,
            );
            var infoResponse = await LoginService.alterarSenha(usuarioDTO);

            // Finaliza o loading na tela
            Navigator.pop(contextLoading, loading);

            var showModalOkWidget = ShowModalOkWidget();
            if (infoResponse.success!) {
              showModalOkWidget.showModalOk(
                context,
                title: "Sucesso",
                description: "Senha alterada com sucesso",
                buttonText: "OK",
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    myPageTransition.pageTransition(
                      child: const InicioPage(),
                      childCurrent: widget,
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
}
