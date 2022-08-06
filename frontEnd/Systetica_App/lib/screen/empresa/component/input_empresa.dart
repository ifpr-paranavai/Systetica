import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/input/campo_pesquisa_widget.dart';
import 'package:systetica/components/input/campo_texto_widget.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/validator/MultiValidatorEmpresa.dart';
import 'package:systetica/screen/empresa/empresa_controller.dart';

class InputEmpresa {
  // Opções para cadatrar empresa
  TextAutenticacoesWidget textoCadastrarEmpresa() {
    return TextAutenticacoesWidget(
      text: "Cadastrar Empresa",
      fontSize: 30,
      paddingBottom: 6,
    );
  }

  CampoTextoWidget inputNomeEmpresa({
    required double paddingHorizontal,
    required EmpresaController controller,
    required MultiValidatorEmpresa validatorEmpresa,
  }) {
    return CampoTextoWidget(
      labelText: "Nome",
      paddingHorizontal: paddingHorizontal * 0.08,
      paddingBottom: 0,
      maxLength: 100,
      paddingTop: 14,
      isIconDate: true,
      icon: const Icon(
        Icons.face_rounded,
        color: Colors.black87,
      ),
      controller: controller.nomeController,
      validator: validatorEmpresa.nomeValidator,
    );
  }

  CampoTextoWidget inputCnpj({
    required double paddingHorizontal,
    required EmpresaController controller,
    required MultiValidatorEmpresa validatorEmpresa,
  }) {
    return CampoTextoWidget(
      labelText: "CNPJ",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      mask: "##.###.###/####-##",
      paddingBottom: 0,
      maxLength: 18,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.credit_card,
        color: Colors.black87,
      ),
      controller: controller.cnpjController,
      validator: validatorEmpresa.cnpjValidator,
    );
  }

  CampoTextoWidget inputTelefone({
    required double paddingHorizontal,
    required EmpresaController controller,
    required MultiValidatorEmpresa validatorEmpresa,
  }) {
    return CampoTextoWidget(
      labelText: "Telefone",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      mask: "(##) #####-####",
      paddingBottom: 0,
      maxLength: 15,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.phone_android,
        color: Colors.black87,
      ),
      controller: controller.telefone1Controller,
      validator: validatorEmpresa.telefone1Validator,
    );
  }

  CampoTextoWidget inputTelefone2({
    required double paddingHorizontal,
    required EmpresaController controller,
  }) {
    return CampoTextoWidget(
      labelText: "Telefone Fixo",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      mask: "(##) ####-####",
      paddingBottom: 0,
      maxLength: 14,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.phone,
        color: Colors.black87,
      ),
      controller: controller.telefone2Controller,
    );
  }

  CampoTextoWidget inputEndereco({
    required double paddingHorizontal,
    required EmpresaController controller,
    required MultiValidatorEmpresa validatorEmpresa,
  }) {
    return CampoTextoWidget(
      labelText: "Endereco",
      paddingHorizontal: paddingHorizontal * 0.08,
      paddingBottom: 0,
      maxLength: 100,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.maps_home_work,
        color: Colors.black87,
      ),
      controller: controller.enderecoController,
      validator: validatorEmpresa.enderecoValidator,
    );
  }

  CampoTextoWidget inputNumero({
    required double paddingHorizontal,
    required EmpresaController controller,
    required MultiValidatorEmpresa validatorEmpresa,
  }) {
    return CampoTextoWidget(
      labelText: "Nº",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      paddingBottom: 0,
      maxLength: 8,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.numbers,
        color: Colors.black87,
      ),
      controller: controller.numeroController,
      validator: validatorEmpresa.numeroValidator,
    );
  }

  CampoTextoWidget inputCep({
    required double paddingHorizontal,
    required EmpresaController controller,
    required MultiValidatorEmpresa validatorEmpresa,
  }) {
    return CampoTextoWidget(
      labelText: "CEP",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      mask: "#####-###",
      paddingBottom: 0,
      maxLength: 9,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.mail,
        color: Colors.black87,
      ),
      controller: controller.cepController,
      validator: validatorEmpresa.cepValidator,
    );
  }

  CampoTextoWidget inputBairro({
    required double paddingHorizontal,
    required EmpresaController controller,
    required MultiValidatorEmpresa validatorEmpresa,
  }) {
    return CampoTextoWidget(
      labelText: "Bairro",
      paddingHorizontal: paddingHorizontal * 0.08,
      paddingBottom: 0,
      maxLength: 100,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.map,
        color: Colors.black87,
      ),
      controller: controller.bairroController,
      validator: validatorEmpresa.bairroValidator,
    );
  }

  CampoPesquisaWidget inputCidade({
    required double paddingHorizontal,
    required EmpresaController controller,
  }) {
    return CampoPesquisaWidget(
      paddingHorizontal: paddingHorizontal * 0.08,
      labelSeachTextPrincipal: "Cidade",
      labelSeachTextPesquisa: "Digite nome da cidade",
      compareFn: (cidade, buscaCidade) => cidade == buscaCidade,
      asyncItems: (filtro) => controller.buscarCidadeFiltro(filtro),
      onChanged: (value) {
        controller.cidade = value;
      },
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
