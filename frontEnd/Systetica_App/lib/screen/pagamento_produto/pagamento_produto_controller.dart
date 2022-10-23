import 'package:flutter/material.dart';
import 'package:systetica/screen/pagamento_produto/pagamento_produto_service.dart';
import 'package:systetica/utils/util.dart';

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

  Future<Info> cadastrarPagamentoProduto({
    required BuildContext context,
    required PagamentoProduto pagamentoProduto,
  }) async {
    Info info = Info(success: true);
    var connected = await ConnectionCheck.check();
    if (connected) {
      if (formKey.currentState != null) {
        if (formKey.currentState?.validate() ?? true) {
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
              valorTotal:
                  Util.calcularValorTotal(pagamentoProduto.produtos!, desconto),
            );

            Token _token = await TokenRepository.findToken();

            info = await PagamentoProdutoService.cadastrarPagamentoProduto(
              token: _token,
              pagamentoProduto: pagamentoProduto,
            );

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
              return info;
            } else {
              await alertDialog.alertDialog(
                showModalOk: true,
                context: context,
                titulo: "Erro",
                descricao: info.message!,
                buttonText: "OK",
                onPressedOk: () => Navigator.pop(context),
              );
              info.success = false;
              return info;
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
            info.success = false;
            return info;
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
      info.success = false;
      return info;
    }
    info.success = false;
    return info;
  }
}
