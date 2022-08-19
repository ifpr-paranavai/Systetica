// ignore_for_file: file_names

import 'package:form_field_validator/form_field_validator.dart';

class MultiValidatorServico {
  MultiValidator get nomeValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
    ]);
  }
  MultiValidator get marcaValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
    ]);
  }

  MultiValidator get precoVendaValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
      MinLengthValidator(
        3,
        errorText: 'Campo deve ter ao menos 3 dígitos',
      ),
    ]);
  }

  MultiValidator get precoCompraValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
      MinLengthValidator(
        3,
        errorText: 'Campo deve ter ao menos 3 dígitos',
      ),
    ]);
  }

  MultiValidator get quantEstoqueValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
    ]);
  }
}
