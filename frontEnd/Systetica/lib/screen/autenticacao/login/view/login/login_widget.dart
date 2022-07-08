import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_acao_widget.dart';
import 'package:systetica/components/campos_texto/campo_texto_widget.dart';
import 'package:systetica/screen/autenticacao/login/login_controller.dart';
import 'package:systetica/screen/autenticacao/login/view/alterar_senha/gerar_codigo_page.dart';
import 'package:systetica/screen/autenticacao/login/view/login/login_page.dart';

class LoginWidget extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  LoginController controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Todo Criar um componente
              Container(
                padding: const EdgeInsets.only(top: 5),
                child: IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_left_outlined,
                    size: 35,
                  ),
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Image.network(
                  'https://ouch-cdn2.icons8.com/NTYRBz_YXFC9P7c65dq8pLHbsE2elQlA4WJzscQhYWA/rs:fit:380:456/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNDUy/L2U0ZGMyYjRkLWE2/N2ItNDg5Ni1iODNj/LWYzNzA5MjRmMzMw/OC5zdmc.png',
                  fit: BoxFit.cover,
                  width: 220,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  left: 35,
                  top: 0,
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.black87.withOpacity(0.9), fontSize: 35),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CampoTextoWidget(
                      labelText: "E-mail",
                      paddingBottom: 0,
                      maxLength: 50,
                      paddingTop: 10,
                      isIconDate: true,
                      icon: const Icon(
                        Icons.email,
                        color: Colors.black87,
                      ),
                      controller: controller.emailController,
                    ),
                    CampoTextoWidget(
                      labelText: "Senha",
                      maxLength: 16,
                      isPassword: true,
                      paddingBottom: 0,
                      paddingTop: 5,
                      controller: controller.senhaController,
                    ),
                    BotaoAcaoWidget(
                      paddingTop: 0,
                      paddingBottom: 0,
                      labelText: "LOGIN",
                      largura: 190,
                      corBotao: Colors.black87.withOpacity(0.9),
                      corTexto: Colors.white,
                      onPressed: () => controller.login(context),
                    ),
                    BotaoAcaoWidget(
                      paddingTop: 18,
                      paddingBottom: 0,
                      labelText: "ESQUECI SENHA",
                      largura: 190,
                      corBotao: Colors.black87.withOpacity(0.9),
                      corTexto: Colors.white,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GerarCodigoPage()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}