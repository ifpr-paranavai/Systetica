import 'package:flutter/material.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/screen/perfil/view/form/perfil_form_widget.dart';

class PerfilFormPage extends StatefulWidget {
  PerfilFormPage({Key? key, required this.usuarioDTO}) : super(key: key);
  UsuarioDTO? usuarioDTO;

  @override
  PerfilFormWidget createState() => PerfilFormWidget();
}
