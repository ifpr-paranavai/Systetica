import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:systetica/components/item_list.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/screen/perfil/view/data.dart';
import 'package:systetica/screen/perfil/view/perfil_page.dart';

class PerfilWidget extends State<PerfilPage> {
  UsuarioDTO data = getUsuarioData();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              sizedBox(),
              SizedBox(
                width: 200,
                height: 200,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 13,
                        color: Colors.black.withOpacity(0.8),
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: imgPerfil(),
                ),
              ),
              Column(
                children: [
                  sizedBox(height: 10),
                  textNome(),
                  sizedBox(height: 8),
                  textTelefonePrincipal(),
                ],
              ),
              sizedBox(height: 20),
              Column(
                children: [
                  ItemLista(
                    titulo: "E-mail",
                    descricao: data.email!,
                  ),
                  ItemLista(
                    titulo: "CPF",
                    descricao: data.cpf!,
                  ),
                  ItemLista(
                    titulo: "Data de Nascimento",
                    descricao: data.dataNascimento!,
                  ),
                  ItemLista(
                    titulo: "Telefone 2",
                    descricao: data.telefone2 ?? "Nenhum",
                  ),
                  ItemLista(
                    titulo: "Cidade",
                    descricao: data.cidade!.nome,
                  ),
                  ItemLista(
                    titulo: "Estado",
                    descricao: data.cidade!.estado!.nome +
                        " - " +
                        data.cidade!.estado!.uf,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  CircleAvatar imgPerfil() {
    return CircleAvatar(
      backgroundImage: NetworkImage(
        data.imagem!,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 113, left: 113),
        child: SizedBox(
          width: 40,
          height: 40,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              iconSize: 20,
              color: Colors.black,
              icon: const Icon(
                Icons.edit,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }

  Text textNome() {
    return textTitulo(
      text: data.nome!,
      fonrSize: 23,
    );
  }

  Text textTelefonePrincipal() {
    return textTitulo(
      text: data.telefone1!,
      fonrSize: 18,
    );
  }

  Text textTitulo({
    required String text,
    required double fonrSize,
  }) {
    return Text(
      text,
      style: GoogleFonts.lora(
        fontSize: fonrSize,
        color: Colors.black,
      ),
    );
  }

  SizedBox sizedBox({double? height = 40}) {
    return SizedBox(
      height: height,
    );
  }
}
