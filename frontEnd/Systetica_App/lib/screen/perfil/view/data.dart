import 'package:systetica/model/CidadeDTO.dart';
import 'package:systetica/model/EstadoDTO.dart';
import 'package:systetica/model/UsuarioDTO.dart';

UsuarioDTO getUsuarioData() {
  return UsuarioDTO(
      id: 1,
      nome: "Franciel Ruam Ferreira Santos",
      cpf: "123.456.789-10",
      dataNascimento: '10/04/2000',
      email: "ruanvha15@gmail.com",
      imagem:
          "https://futebolizando.com.br/wp-content/uploads/2021/02/cris-753x570.jpg",
      telefone1: "(44) 99988-7744",
      cidade: CidadeDTO(
        id: 1,
        nome: "Paranavaí",
        estado: EstadoDTO(
          id: 1,
          nome: "Paraná",
          uf: 'PR',
        ),
      ));
}
