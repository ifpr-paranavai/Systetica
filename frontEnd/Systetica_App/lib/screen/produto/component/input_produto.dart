import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/input/campo_texto_widget.dart';
import 'package:systetica/components/input/custom_switch.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/validator/MultiValidatorProduto.dart';
import 'package:systetica/screen/produto/produto_controller.dart';

class InputProduto {
  // Opções para cadatrar produto
  TextAutenticacoesWidget textoCadastrarProduto({required String texto}) {
    return TextAutenticacoesWidget(
      text: texto,
      fontSize: 30,
      paddingBottom: 6,
    );
  }

  CampoTextoWidget inputNomeProduto({
    required double paddingHorizontal,
    required ProdutoController controller,
    required MultiValidatorProduto validatorProduto,
  }) {
    return CampoTextoWidget(
      labelText: "Nome",
      paddingHorizontal: paddingHorizontal * 0.08,
      paddingBottom: 0,
      maxLength: 50,
      paddingTop: 14,
      isIconDate: true,
      icon: const Icon(
        Icons.add_shopping_cart,
        color: Colors.black87,
      ),
      controller: controller.nomeController,
      validator: validatorProduto.nomeValidator,
    );
  }

  CampoTextoWidget inputMarcaProduto({
    required double paddingHorizontal,
    required ProdutoController controller,
    required MultiValidatorProduto validatorProduto,
  }) {
    return CampoTextoWidget(
      labelText: "Marca",
      paddingHorizontal: paddingHorizontal * 0.08,
      paddingBottom: 0,
      maxLength: 50,
      paddingTop: 14,
      isIconDate: true,
      icon: const Icon(
        Icons.add_shopping_cart_sharp,
        color: Colors.black87,
      ),
      controller: controller.marcaController,
      validator: validatorProduto.marcaValidator,
    );
  }

  CampoTextoWidget inputPrecoCompra({
    required double paddingHorizontal,
    required ProdutoController controller,
    required MultiValidatorProduto validatorProduto,
  }) {
    return CampoTextoWidget(
      labelText: "Preço Compra",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      paddingBottom: 0,
      maxLength: 6,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        CupertinoIcons.money_dollar,
        color: Colors.black87,
      ),
      controller: controller.precoCompraController,
      validator: validatorProduto.precoCompraValidator,
    );
  }

  CampoTextoWidget inputPrecoVenda({
    required double paddingHorizontal,
    required ProdutoController controller,
    required MultiValidatorProduto validatorProduto,
  }) {
    return CampoTextoWidget(
      labelText: "Preço Venda",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      paddingBottom: 0,
      maxLength: 6,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        CupertinoIcons.money_dollar,
        color: Colors.black87,
      ),
      controller: controller.precoVendaController,
      validator: validatorProduto.precoVendaValidator,
    );
  }

  CampoTextoWidget inputQuantidadeEstoqueProduto({
    required double paddingHorizontal,
    required ProdutoController controller,
    required MultiValidatorProduto validatorProduto,
  }) {
    return CampoTextoWidget(
      labelText: "Quantidade Estoque",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      paddingBottom: 0,
      maxLength: 4,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.numbers,
        color: Colors.black87,
      ),
      controller: controller.quantEstoqueVendaController,
      validator: validatorProduto.quantEstoqueValidator,
    );
  }

  CustomSwitch customSwitch({
    required double paddingHorizontal,
    required ProdutoController controller,
    required Function(bool) onChanged,
  }) {
    return CustomSwitch(
      paddingBottom: 0,
      paddingHorizontal: paddingHorizontal * 0.08,
      label: "Status",
      value: controller.status ?? true,
      onChanged: onChanged,
    );
  }

  BotaoWidget botaoCadastrar({
    required String label,
    required VoidCallback onPressed,
  }) {
    return BotaoWidget(
      paddingTop: 18,
      paddingBottom: 30,
      labelText: label,
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: onPressed,
    );
  }
}
