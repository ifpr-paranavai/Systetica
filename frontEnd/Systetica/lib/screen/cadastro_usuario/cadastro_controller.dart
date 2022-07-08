import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:systetica/components/loading/show_loading_widget.dart';
import 'package:systetica/components/show_modal_sucesso_widget.dart';
import 'package:systetica/components/texto_erro_widget.dart';
import 'package:systetica/model/CidadeDTO.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/request/dio_config.dart';
import 'package:systetica/screen/cadastro_usuario/cadastro_service.dart';
import 'package:systetica/screen/cadastro_usuario/view/ativar_usuario/ativar_usuario_page.dart';
import 'package:systetica/screen/inicio/view/inicio_page.dart';
import 'package:systetica/utils/validacoes.dart';

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

  cadastrarUsuario(BuildContext context, CidadeDTO? cidadeDTO) async {
    var connected = await ConnectionCheck.check();
    if (connected) {
      if (Validacoes.isEmptOrNull(nomeController.text) ||
          Validacoes.isEmptOrNull(dataNascimentoController.text) ||
          Validacoes.isEmptOrNull(cpfController.text) ||
          Validacoes.isEmptOrNull(telefone1.text) ||
          Validacoes.isEmptOrNull(emailController.text) ||
          Validacoes.isEmptOrNull(senhaController.text) ||
          Validacoes.isEmptOrNull(confirmaSenhaController.text) ||
          cidadeDTO == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
            padding: EdgeInsets.all(18),
            content: TextoErroWidget(
              mensagem: "Por Favor, preencha todos os campos",
            ),
          ),
        );
        return;
      }

      // Validar CPF
      if (CPFValidator.isValid(cpfController.text) == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
            padding: EdgeInsets.all(18),
            content: TextoErroWidget(
              mensagem: "CPF digitado não é válido",
            ),
          ),
        );
        return;
      }

      // Validar Email
      if (!EmailValidator.validate(emailController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
            padding: EdgeInsets.all(18),
            content: TextoErroWidget(
              mensagem: "E-mail digitado não é válido",
            ),
          ),
        );
        return;
      }

      // Verificar Tamanho da senha
      if (senhaController.text.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
            padding: EdgeInsets.all(18),
            content: TextoErroWidget(
              mensagem: "Senha deve possúir ao menos 6 caracteres",
            ),
          ),
        );
        return;
      }

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
        );

        //Loading apresentado na tela
        var contextLoading = context;
        var loading = ShowLoadingWidget.showLoadingLabel(
          contextLoading,
          "Aguarde...",
        );

        var infoResponse = await CadastroService.cadastroUsuario(usuarioDTO);

        // Finaliza o loading na tela
        Navigator.pop(contextLoading, loading);

        var showModalOkWidget = ShowModalOkWidget();
        if (infoResponse.success!) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AtivarUsuarioPage(),
            ),
          );
        } else {
          Navigator.pop(contextLoading, loading);
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
