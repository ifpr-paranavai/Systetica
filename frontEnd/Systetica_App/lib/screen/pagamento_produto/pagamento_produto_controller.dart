import 'package:flutter/material.dart';
import 'package:systetica/screen/pagamento_produto/pagamento_produto_service.dart';

import '../../components/alert_dialog_widget.dart';
import '../../components/loading/show_loading_widget.dart';
import '../../components/page_transition.dart';
import '../../components/texto_erro_widget.dart';
import '../../database/repository/token_repository.dart';
import '../../model/FormaPagamento.dart';
import '../../model/Info.dart';
import '../../model/Pagamento.dart';
import '../../model/PagamentoProduto.dart';
import '../../model/Token.dart';
import '../../request/dio_config.dart';

class PagamentoProdutoController {
  final descontoController = TextEditingController();

  final myPageTransition = MyPageTransition();
  final formKey = GlobalKey<FormState>();
  late PagamentoProduto pagamentoProduto = PagamentoProduto();

  Color corBotao = Colors.grey.withOpacity(0.9);
  Color overlayCorBotao = Colors.transparent;
  double largura = 0;
  double altura = 0;
  FormaPagamento? formaPagamento;

  Future<void> cadastrarPagamentoProduto({
    required BuildContext context,
    required PagamentoProduto pagamentoProduto,
    required double valorTotal,
  }) async {
    var connected = await ConnectionCheck.check();
    if (connected) {
      if (formKey.currentState != null) {
        if (formKey.currentState?.validate() ?? true) {
          Info info = Info(success: true);
          try {
            var contextLoading = context;
            var loading = ShowLoadingWidget.showLoadingLabel(
              contextLoading,
              "Aguarde...",
            );

            double desconto = descontoController.text.isEmpty
                ? 0
                : double.parse(descontoController.text);

            pagamentoProduto.pagamento = Pagamento(
              formaPagamento: formaPagamento,
              desconto: desconto,
              valorTotal: valorTotal - desconto,
            );

            Token _token = await TokenRepository.findToken();

            info = await PagamentoProdutoService.cadastrarPagamentoProduto(
              token: _token,
              pagamentoProduto: pagamentoProduto,
            ); // service

            // Finaliza o loading na tela
            Navigator.pop(contextLoading, loading);

            var alertDialog = AlertDialogWidget();
            if (info.success!) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.blueGrey,
                  content: TextoErroWidget(
                    mensagem: info.message!,
                  ),
                ),
              );
            } else {
              await alertDialog.alertDialog(
                showModalOk: true,
                context: context,
                titulo: "Erro",
                descricao: info.message!,
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
            mensagem: "Por Favor, conecte-se a rede para cadastrar pagamento",
          ),
        ),
      );
    }
  }
}
