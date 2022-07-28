import 'package:form_field_validator/form_field_validator.dart';

class MultiValidatorUsuario {
  MultiValidator get nomeValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
    ]);
  }

  MultiValidator get telefoneValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
      MinLengthValidator(
        15,
        errorText: 'Campo deve ter ao menos 15 dígitos',
      ),
    ]);
  }

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

  MultiValidator get codigoValidator {
    return MultiValidator([
      RequiredValidator(errorText: 'Campo obrigatório'),
      MinLengthValidator(
        6,
        errorText: 'Campo deve possuir no menos 6 caracteres',
      ),
    ]);
  }
}