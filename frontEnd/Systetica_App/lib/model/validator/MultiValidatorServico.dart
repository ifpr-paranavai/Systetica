// ignore_for_file: file_names

import 'package:form_field_validator/form_field_validator.dart';

class MultiValidatorServico {
  MultiValidator get nomeValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
    ]);
  }

  MultiValidator get tempoServicoValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
    ]);
  }

  MultiValidator get precoValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
      MinLengthValidator(
        3,
        errorText: 'Campo deve ter ao menos 3 dígitos',
      ),
    ]);
  }
}
