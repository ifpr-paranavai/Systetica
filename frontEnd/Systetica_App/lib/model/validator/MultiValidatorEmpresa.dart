// ignore_for_file: file_names

import 'package:form_field_validator/form_field_validator.dart';

class MultiValidatorEmpresa {
  MultiValidator get nomeValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
    ]);
  }

  MultiValidator get cnpjValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
      MinLengthValidator(
        18,
        errorText: 'Campo deve ter ao menos 18 dígitos',
      ),
    ]);
  }

  MultiValidator get telefone1Validator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
      MinLengthValidator(
        15,
        errorText: 'Campo deve ter ao menos 15 dígitos',
      ),
    ]);
  }

  MultiValidator get enderecoValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
    ]);
  }

  MultiValidator get numeroValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
      MinLengthValidator(
        2,
        errorText: 'Campo deve ter ao menos 2 dígitos',
      ),
    ]);
  }

  MultiValidator get cepValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
      MinLengthValidator(
        9,
        errorText: 'Campo deve ter ao menos 9 dígitos',
      ),
    ]);
  }

  MultiValidator get bairroValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
    ]);
  }

  MultiValidator get aberturaValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
    ]);
  }

  MultiValidator get fechamentoValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
    ]);
  }
}
