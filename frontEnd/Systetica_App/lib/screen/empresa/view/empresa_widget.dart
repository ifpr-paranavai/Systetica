import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systetica/components/foto/foto_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/item_list.dart';
import 'package:systetica/components/loading/loading_animation.dart';
import 'package:systetica/components/single_child_scroll_component.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/MenuItem.dart';
import 'package:systetica/model/validator/MultiValidatorEmpresa.dart';
import 'package:systetica/screen/empresa/component/input_empresa.dart';
import 'package:systetica/screen/empresa/empresa_controller.dart';
import 'package:systetica/screen/empresa/view/empresa_page.dart';
import 'package:systetica/screen/empresa/view/form/empresa_form_page.dart';
import 'package:systetica/style/app_colors..dart';
import 'package:systetica/utils/util.dart';

class EmpresaWidget extends State<EmpresaPage> {
  final EmpresaController _controller = EmpresaController();
  final MultiValidatorEmpresa _multiValidatorEmpresa = MultiValidatorEmpresa();
  final InputEmpresa _inputEmpresa = InputEmpresa();
  final _picker = ImagePicker();
  final List<MenuItemDto> _menuItems = [
    MenuItemDto(text: 'Editar', icon: Icons.edit),
  ];
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller.empresa = Empresa();
  }

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.of(context).size.height;
    double _largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: _altura * 0.01,
          onPressed: () => Navigator.pop(context),
        ),
        body: FutureBuilder<Info?>(
          future: _controller.buscarEmpresaEmail(context),
          builder: (context, snapShot) {
            if (!snapShot.hasData) {
              return const LoadingAnimation();
            } else if (snapShot.hasData && snapShot.data!.success!) {
              _controller.empresa = snapShot.data!.object;
              return widgetInfoEmpresa(
                altura: _altura,
                empresa: _controller.empresa,
                logoBase64: _controller.empresa.logoBase64,
              );
            } else {
              return widgetCadastrarEmpresa(
                altura: _altura,
                largura: _largura,
              );
            }
          },
        ),
      ),
    );
  }

  Stack widgetInfoEmpresa({
    required double altura,
    required Empresa empresa,
    String? logoBase64,
  }) {
    return Stack(
      children: [
        SingleChildScrollComponent(
          widgetComponent: Center(
            child: Column(
              children: [
                _sizedBox(height: altura * 0.08),
                FotoWidget().boxFoto(
                  imagemUsuario: logoBase64,
                ),
                _sizedBox(height: altura * 0.06),
                _textoEmpresa(),
                _cardInfoEmpresa(
                  empresa: empresa,
                ),
                _sizedBox(height: altura * 0.05),
              ],
            ),
          ),
        ),
        _dropDownButton(empresa: empresa, altura: altura),
      ],
    );
  }

  SingleChildScrollView widgetCadastrarEmpresa({
    required double altura,
    required double largura,
  }) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _controller.formKey,
        child: Center(
          child: Column(
            children: [
              _sizedBox(height: altura * 0.08),
              FotoWidget().boxFoto(
                imagemUsuario: _controller.logoBase64,
                iconErroAdd: true,
                onPressed: () => _adicionarImagem(),
              ),
              _sizedBox(height: altura * 0.07),
              _inputEmpresa.textoCadastrarEmpresa(),
              _inputEmpresa.inputNomeEmpresa(
                paddingHorizontal: largura,
                controller: _controller,
                validatorEmpresa: _multiValidatorEmpresa,
              ),
              _inputEmpresa.inputCnpj(
                paddingHorizontal: largura,
                controller: _controller,
                validatorEmpresa: _multiValidatorEmpresa,
              ),
              _inputEmpresa.inputTelefone(
                paddingHorizontal: largura,
                controller: _controller,
                validatorEmpresa: _multiValidatorEmpresa,
              ),
              _inputEmpresa.inputTelefone2(
                paddingHorizontal: largura,
                controller: _controller,
              ),
              _inputEmpresa.inputCep(
                paddingHorizontal: largura,
                controller: _controller,
                validatorEmpresa: _multiValidatorEmpresa,
              ),
              _inputEmpresa.inputEndereco(
                paddingHorizontal: largura,
                controller: _controller,
                validatorEmpresa: _multiValidatorEmpresa,
              ),
              _inputEmpresa.inputBairro(
                paddingHorizontal: largura,
                controller: _controller,
                validatorEmpresa: _multiValidatorEmpresa,
              ),
              _inputEmpresa.inputNumero(
                paddingHorizontal: largura,
                controller: _controller,
                validatorEmpresa: _multiValidatorEmpresa,
              ),
              _inputEmpresa.inputCidade(
                paddingHorizontal: largura,
                controller: _controller,
              ),
              _inputEmpresa.botaoCadastrar(
                label: "CADASTRAR",
                onPressed: () => _controller
                    .cadastrarEmpresa(context)
                    .then((value) => setState(() {})),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Opções para foto
  Future<void> _adicionarImagem() async {
    XFile? pickedImagem = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImagem != null) {
      CroppedFile _croppedFile = await _funcaoCroppedFile(pickedImagem);
      setState(
        () {
          File imagem = File(_croppedFile.path);
          _controller.logoBase64 = base64Encode(imagem.readAsBytesSync());
        },
      );
    }
  }

  Future<CroppedFile> _funcaoCroppedFile(XFile pickedImagem) async {
    CroppedFile? _croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedImagem.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
      ],
      cropStyle: CropStyle.circle,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Recortar',
          toolbarColor: AppColors.bluePrincipal,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          backgroundColor: Colors.white,
          activeControlsWidgetColor: AppColors.redPrincipal,
        ),
        IOSUiSettings(
          title: 'Recortar',
        ),
      ],
    );
    return _croppedFile!;
  }

  // Opções para info empresa
  DropdownButtonHideUnderline _dropDownButton({
    required Empresa empresa,
    required double altura,
  }) {
    return DropdownButtonHideUnderline(
      child: Container(
        alignment: Alignment.topRight,
        padding: EdgeInsets.only(top: altura * 0.02, right: 8),
        child: DropdownButton2(
          itemPadding: const EdgeInsets.all(15),
          dropdownWidth: 105,
          dropdownElevation: 8,
          offset: const Offset(-65, 2),
          focusColor: Colors.transparent,
          customButton: const Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Icon(
              Icons.more_vert,
              size: 35,
              color: AppColors.redPrincipal,
            ),
          ),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.bluePrincipal,
          ),
          items: _menuItems
              .map((item) => DropdownMenuItem<MenuItemDto>(
                    value: item,
                    child: MenuItemDto.buildItem(item),
                  ))
              .toList(),
          onChanged: (value) {
            Navigator.of(context)
                .push(_controller.myPageTransition.pageTransition(
                  child: EmpresaFormPage(empresa: empresa),
                  childCurrent: widget,
                  buttoToTop: true,
                ))
                .then(
                  (value) => setState(() {}),
                );
          },
        ),
      ),
    );
  }

  TextAutenticacoesWidget _textoEmpresa() {
    return TextAutenticacoesWidget(
      text: "Empresa",
      fontSize: 30,
      paddingBottom: 6,
    );
  }

  Padding _cardInfoEmpresa({required Empresa empresa}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black,
            width: 0.1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _sizedBox(height: 5),
            _itemNome(empresa.nome!),
            _itemCnpj(empresa.cnpj!),
            _itemTelefone1(empresa.telefone1!),
            _itemTelefone2(Util.isEmptOrNull(empresa.telefone2)
                ? "Não cadastrado"
                : empresa.telefone2!),
            _itemEndereco(empresa.endereco!, empresa.numero!.toString()),
            _itemBairro(empresa.bairro!),
            _itemAbertura(empresa.horarioAbertura!),
            _itemFechamento(empresa.horarioFechamento!),
            _itemCep(empresa.cep.toString()),
            _itemCidade(empresa.cidade!.nome!, empresa.cidade!.estado!.uf),
          ],
        ),
      ),
    );
  }

  ItemLista _itemNome(String nome) {
    return ItemLista(
      titulo: "Nome",
      descricao: nome,
    );
  }

  ItemLista _itemCnpj(String email) {
    return ItemLista(
      titulo: "CNPJ",
      descricao: email,
    );
  }

  ItemLista _itemTelefone1(String telefone) {
    return ItemLista(
      titulo: "Telefone Principal",
      descricao: telefone,
    );
  }

  ItemLista _itemTelefone2(String telefone) {
    return ItemLista(
      titulo: "Telefone Fixo",
      descricao: telefone,
    );
  }

  ItemLista _itemEndereco(String endereco, String numero) {
    return ItemLista(
      titulo: "Endereço",
      descricao: endereco + " -  Nº " + numero,
    );
  }

  ItemLista _itemBairro(String bairro) {
    return ItemLista(
      titulo: "Bairro",
      descricao: bairro,
    );
  }

  ItemLista _itemAbertura(String abertura) {
    return ItemLista(
      titulo: "Abertura",
      descricao: abertura,
    );
  }

  ItemLista _itemFechamento(String fechamento) {
    return ItemLista(
      titulo: "Fechamento",
      descricao: fechamento,
    );
  }

  ItemLista _itemCep(String cep) {
    return ItemLista(
      titulo: "CEP",
      descricao: cep,
    );
  }

  ItemLista _itemCidade(String cidade, String sigla) {
    return ItemLista(
      titulo: "Cidade",
      descricao: cidade + " - " + sigla,
    );
  }

  SizedBox _sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
