import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:systetica/components/item_list.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/screen/perfil/perfil_controller.dart';
import 'package:systetica/screen/perfil/view/data.dart';
import 'package:systetica/screen/perfil/view/perfil_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class PerfilWidget extends State<PerfilPage> {
  var myPageTransition = MyPageTransition();
  final PerfilController _controller = PerfilController();
  UsuarioDTO data = getUsuarioData();
  final _picker = ImagePicker();


  Future<void> _adicionarImagem() async {
    PickedFile? pickedImagem =
    await _picker.getImage(source: ImageSource.gallery);
    if (pickedImagem != null) {
      setState(
            () {
          File imagem = File(pickedImagem.path);
          _controller.imagemBase64 = base64Encode(imagem.readAsBytesSync());
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: const Alignment(0.2, 0.05),
                colors: [Colors.grey.withOpacity(0.19), Colors.white],
              ),
            ),
            child: Column(
              children: [
                sizedBox(),
                SizedBox(
                  width: 180,
                  height: 180,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.6),
                          spreadRadius: 2,
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
                Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      sizedBox(height: 5),
                      itemEmail(),
                      itemCpf(),
                      itemDataNascimento(),
                      itemTelefone2(),
                      itemCidade(),
                      itemEstado(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CircleAvatar imgPerfil() {
    return CircleAvatar(
      backgroundColor: Colors.black,
      backgroundImage: const NetworkImage(
        "https://saobras.al.gov.br/cpl/img/login.png",
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 98, left: 98),
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
              onPressed: () => _adicionarImagem().then(
                (value) => setState(() {}),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text textNome() {
    return textNomeTelefone(
      text: data.nome!,
      fonrSize: 23,
    );
  }

  Text textTelefonePrincipal() {
    return textNomeTelefone(
      text: data.telefone1!,
      fonrSize: 18,
    );
  }

  Text textNomeTelefone({
    required String text,
    required double fonrSize,
  }) {
    return Text(
      text,
      style: GoogleFonts.lora(
        fontSize: fonrSize,
        color: Colors.black,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }

  ItemLista itemEmail() {
    return ItemLista(
      titulo: "E-mail",
      descricao: data.email!,
    );
  }

  ItemLista itemCpf() {
    return ItemLista(
      titulo: "CPF",
      descricao: data.cpf!,
    );
  }

  ItemLista itemDataNascimento() {
    return ItemLista(
      titulo: "Data de Nascimento",
      descricao: data.dataNascimento!,
    );
  }

  ItemLista itemTelefone2() {
    return ItemLista(
      titulo: "Telefone 2",
      descricao: data.telefone2 ?? "Nenhum",
    );
  }

  ItemLista itemCidade() {
    return ItemLista(
      titulo: "Cidade",
      descricao: data.cidade!.nome,
    );
  }

  ItemLista itemEstado() {
    return ItemLista(
      titulo: "Estado",
      descricao: data.cidade!.estado!.nome + " - " + data.cidade!.estado!.uf,
    );
  }

  SizedBox sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
