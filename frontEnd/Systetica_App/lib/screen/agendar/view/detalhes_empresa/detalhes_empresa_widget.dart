import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:systetica/components/foto/foto_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/item_list.dart';
import 'package:systetica/components/single_child_scroll_component.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/screen/agendar/view/detalhes_empresa/detalhes_empresa_page.dart';
import 'package:systetica/utils/util.dart';

class DetalhaEmpresaWidget extends State<DetalhaEmpresaPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  double _altura = 0;
  double _largura = 0;

  @override
  Widget build(BuildContext context) {
    _altura = MediaQuery.of(context).size.height;
    _largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: _altura * 0.01,
          onPressed: () => Navigator.pop(context),
        ),
        body: Stack(
          children: [
            SingleChildScrollComponent(
              widgetComponent: Center(
                child: Column(
                  children: [
                    _sizedBox(height: _altura * 0.08),
                    FotoWidget().boxFoto(
                      imagemUsuario: widget.empresa.logoBase64,
                    ),
                    _sizedBox(height: _altura * 0.04),
                    _infoEmpresa(),
                    _cardInfoEmpresa(
                      empresa: widget.empresa,
                    ),
                    _sizedBox(height: _altura * 0.02),
                    _infoEnderecoEmpresa(),
                    _cardInfoEnderecoEmpresa(
                      empresa: widget.empresa,
                    ),
                    _sizedBox(height: _altura * 0.07),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextAutenticacoesWidget _infoEmpresa() {
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
            _itemTelefone1(empresa.telefone1!),
            _itemTelefone2(Util.isEmptOrNull(empresa.telefone2)
                ? "Não cadastrado"
                : empresa.telefone2!),
          ],
        ),
      ),
    );
  }

  TextAutenticacoesWidget _infoEnderecoEmpresa() {
    return TextAutenticacoesWidget(
      text: "Endereço",
      fontSize: 30,
      paddingBottom: 6,
    );
  }

  ItemLista _itemNome(String nome) {
    return ItemLista(
      titulo: "Nome",
      descricao: nome,
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

  Padding _cardInfoEnderecoEmpresa({required Empresa empresa}) {
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
            _itemEndereco(empresa.endereco!, empresa.numero!.toString()),
            _itemBairro(empresa.bairro!),
            _abrirLocalizacao(
              latitude: double.parse(empresa.latitude!),
              longitude: double.parse(empresa.longitude!),
            ),
          ],
        ),
      ),
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

  Widget _abrirLocalizacao({
    required double latitude,
    required double longitude,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 18),
      width: _largura,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.2)),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: const Align(
          alignment: Alignment.topLeft,
          child: ItemLista(
            titulo: "Localização",
            descricao: "Clique aqui",
            paddingHorizonta: 0,
          ),
        ),
        onPressed: () => MapsLauncher.launchCoordinates(
          latitude,
          longitude,
        ),
      ),
    );
  }

  SizedBox _sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
