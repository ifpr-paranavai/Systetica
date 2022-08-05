import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/input/campo_pesquisa_widget.dart';
import 'package:systetica/components/input/campo_texto_widget.dart';
import 'package:systetica/components/item_list.dart';
import 'package:systetica/components/loading/loading_animation.dart';
import 'package:systetica/components/single_child_scroll_component.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/Cidade.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/MenuItem.dart';
import 'package:systetica/model/Page_impl.dart';
import 'package:systetica/model/validator/MultiValidatorEmpresa.dart';
import 'package:systetica/screen/empresa/empresa_controller.dart';
import 'package:systetica/screen/empresa/empresa_service.dart';
import 'package:systetica/screen/empresa/view/empresa_page.dart';
import 'package:systetica/screen/empresa/view/form/empresa_form_page.dart';
import 'package:systetica/style/app_colors..dart';

class EmpresaWidget extends State<EmpresaPage> {
  final EmpresaController _controller = EmpresaController();
  final MultiValidatorEmpresa _validatorEmpresa = MultiValidatorEmpresa();
  final _picker = ImagePicker();
  final List<MenuItemDto> _menuItems = [
    MenuItemDto(text: 'Editar', icon: Icons.edit),
  ];
  late ScrollController _scrollController;

  List<Cidade> cidades = [];
  Cidade? cidade;

  Future<List<Cidade>> buscarCidadeFiltro(String? nomeCidade) async {
    try {
      Info info = await EmpresaService.buscarCidade(nomeCidade: nomeCidade);
      return info.object;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

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
              return Stack(
                children: [
                  SingleChildScrollComponent(
                    widgetComponent: Center(
                      child: Column(
                        children: [
                          _sizedBox(height: _altura * 0.08),
                          _boxFoto(_controller.empresa.logoBase64),
                          _sizedBox(height: _altura * 0.07),
                          _textoEmpresa(),
                          _cardInfoEmpresa(
                            empresa: _controller.empresa,
                          ),
                          _sizedBox(height: _altura * 0.05),
                        ],
                      ),
                    ),
                  ),
                  _dropDownButton(empresa: _controller.empresa),
                ],
              );
            } else {
              return _erroRequisicao(_largura);
            }
          },
        ),
      ),
    );
  }

  // Scaffold paraDeCadastro(){
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
  //     floatingActionButton: IconArrowWidget(
  //       paddingTop: _altura * 0.01,
  //       onPressed: () => Navigator.pop(context),
  //     ),
  //     body: SingleChildScrollView(
  //       controller: _scrollController,
  //       child: Form(
  //         autovalidateMode: AutovalidateMode.onUserInteraction,
  //         key: _controller.formKey,
  //         child: Center(
  //           child: Column(
  //             children: [
  //               _sizedBox(height: _altura * 0.08),
  //               _boxFoto(_controller.empresa.logoBase64),
  //               _sizedBox(height: _altura * 0.07),
  //               inputCidade(),
  //               _textoCadastrarEmpresa(),
  //               _inputNomeEmpresa(paddingHorizontal: _largura),
  //               _inputCnpj(paddingHorizontal: _largura),
  //               _inputTelefone(paddingHorizontal: _largura),
  //               _inputTelefone2(paddingHorizontal: _largura),
  //               _inputEndereco(paddingHorizontal: _largura),
  //               _inputNumero(paddingHorizontal: _largura),
  //               _inputCep(paddingHorizontal: _largura),
  //               _inputBairro(paddingHorizontal: _largura),
  //               _botaoCadastrar(),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Future<void> _adicionarImagem() async {
    XFile? pickedImagem = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImagem != null) {
      CroppedFile _croppedFile = await _funcaoCroppedFile(pickedImagem);
      setState(
        () {
          File imagem = File(_croppedFile.path);
          _controller.logoBase64 = base64Encode(imagem.readAsBytesSync());
          _controller.imagemAlterada = true;
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

  Container _boxFoto(dynamic imagemUsuario) {
    return Container(
      width: 160,
      height: 160,
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
      child: _imgPerfil(imagemUsuario),
    );
  }

  Widget _imgPerfil(dynamic image) {
    if (image == null || image == "") {
      return _iconErroFoto();
    } else {
      image = base64Decode(image);
      if (image is Uint8List) {
        return _circleAvatar(backgroundImage: MemoryImage(image));
      } else {
        return _circleAvatar(backgroundImage: FileImage(image));
      }
    }
  }

  CircleAvatar _circleAvatar({required ImageProvider backgroundImage}) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      backgroundImage: backgroundImage,
    );
  }

  // Opções para info empresa
  DropdownButtonHideUnderline _dropDownButton({
    required Empresa empresa,
  }) {
    return DropdownButtonHideUnderline(
      child: Container(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, right: 8),
          child: DropdownButton2(
            customButton: const Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Icon(
                Icons.more_vert,
                size: 35,
                color: AppColors.redPrincipal,
              ),
            ),
            itemPadding: const EdgeInsets.all(15),
            dropdownWidth: 105,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.bluePrincipal,
            ),
            dropdownElevation: 8,
            offset: const Offset(-65, 2),
            focusColor: Colors.transparent,
            items: _menuItems
                .map(
                  (item) => DropdownMenuItem<MenuItemDto>(
                    value: item,
                    child: MenuItemDto.buildItem(item),
                  ),
                )
                .toList(),
            onChanged: (value) {
              Navigator.of(context)
                  .push(
                    _controller.myPageTransition.pageTransition(
                      child: EmpresaFormPage(empresa: empresa),
                      childCurrent: widget,
                      buttoToTop: true,
                    ),
                  )
                  .then(
                    (value) => setState(() {}),
                  );
            },
          ),
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
            _itemTelefone2(empresa.telefone2 ?? "Não cadastrado"),
            _itemEndereco(empresa.endereco!, empresa.numero!.toString()),
            _itemBairro(empresa.bairro!),
            _itemCep(empresa.cep.toString()),
            _itemCidade(empresa.cidade!.nome!, empresa.cidade!.estado!.uf),
          ],
        ),
      ),
    );
  }

  ItemLista _itemNome(String nome) {
    return ItemLista(
      titulo: "Empresa",
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

  // Opções para cadatrar empresa
  TextAutenticacoesWidget _textoCadastrarEmpresa() {
    return TextAutenticacoesWidget(
      text: "Cadastra Empresa",
      fontSize: 30,
      paddingBottom: 6,
    );
  }

  CampoTextoWidget _inputNomeEmpresa({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "Empresa",
      paddingHorizontal: paddingHorizontal * 0.08,
      paddingBottom: 0,
      maxLength: 100,
      paddingTop: 14,
      isIconDate: true,
      icon: const Icon(
        Icons.face_rounded,
        color: Colors.black87,
      ),
      controller: _controller.nomeController,
      validator: _validatorEmpresa.nomeValidator,
    );
  }

  CampoTextoWidget _inputCnpj({required double paddingHorizontal}) {
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
      controller: _controller.cnpjController,
      validator: _validatorEmpresa.cnpjValidator,
    );
  }

  CampoTextoWidget _inputTelefone({required double paddingHorizontal}) {
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
      controller: _controller.telefone1Controller,
      validator: _validatorEmpresa.telefone1Validator,
    );
  }

  CampoTextoWidget _inputTelefone2({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "Telefone Fixo",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      mask: "(##) ####-####",
      paddingBottom: 0,
      maxLength: 15,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.phone,
        color: Colors.black87,
      ),
      controller: _controller.telefone2Controller,
    );
  }

  CampoTextoWidget _inputEndereco({required double paddingHorizontal}) {
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
      controller: _controller.enderecoController,
      validator: _validatorEmpresa.enderecoValidator,
    );
  }

  CampoTextoWidget _inputNumero({required double paddingHorizontal}) {
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
      controller: _controller.numeroController,
      validator: _validatorEmpresa.numeroValidator,
    );
  }

  CampoTextoWidget _inputCep({required double paddingHorizontal}) {
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
      controller: _controller.cepController,
      validator: _validatorEmpresa.cepValidator,
    );
  }

  CampoTextoWidget _inputBairro({required double paddingHorizontal}) {
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
      controller: _controller.bairroController,
      validator: _validatorEmpresa.bairroValidator,
    );
  }

  CampoPesquisaWidget inputCidade() {
    return CampoPesquisaWidget(
      labelText: "Cidade",
      labelSeachText: "Digite nome da cidade",
      icon: const Icon(Icons.location_city),
      objects: cidades,
      objectAsString: (cidade) => cidade.nome,
      objectOnFind: (String? cidade) => buscarCidadeFiltro(cidade),
      onChanged: (value) {
        cidade = value;
      },
    );
  }

  BotaoWidget _botaoCadastrar() {
    return BotaoWidget(
      paddingTop: 18,
      paddingBottom: 30,
      labelText: "CADASTRAR",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () {},
    );
  }

  SizedBox _sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  // Widgets de erro
  Widget _iconErroFoto() {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        color: AppColors.redPrincipal,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black.withOpacity(0.6),
            spreadRadius: 2,
          )
        ],
      ),
      child: IconButton(
        icon: const Icon(
          Icons.edit,
          size: 100,
          color: Colors.white,
        ),
        onPressed: () => _adicionarImagem(),
      ),
    );
  }

  Center _erroRequisicao(double _largura) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imagemErro(),
            _textoErro(_largura),
          ],
        ),
      ),
    );
  }

  ImagensWidget _imagemErro() {
    return ImagensWidget(
      paddingLeft: 0,
      image: "erro.png",
      widthImagem: 320,
    );
  }

  TextAutenticacoesWidget _textoErro(double _largura) {
    return TextAutenticacoesWidget(
      paddingLeft: _largura * 0.10,
      paddingRight: _largura * 0.10,
      fontSize: 33,
      text: "Oopss...ocorreu algum erro. \nTente novamente mais tarde.",
    );
  }
}
