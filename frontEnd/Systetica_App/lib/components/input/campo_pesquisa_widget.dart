// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:systetica/model/Cidade.dart';

class CampoPesquisaWidget extends StatefulWidget {
  CampoPesquisaWidget({Key? key,
    required this.compareFn,
    required this.asyncItems,
    required this.onChanged,
    required this.labelSeachTextPrincipal,
    required this.labelSeachTextPesquisa,
    required this.paddingHorizontal})
      : super(key: key);
  final myKey = GlobalKey<DropdownSearchState<dynamic>>();

  DropdownSearchCompareFn<Cidade>? compareFn;
  DropdownSearchOnFind<Cidade>? asyncItems;
  Function(Cidade?)? onChanged;
  String labelSeachTextPrincipal;
  String labelSeachTextPesquisa;

  double paddingHorizontal;

  @override
  _CampoPesquisaWidget createState() => _CampoPesquisaWidget();
}

class _CampoPesquisaWidget extends State<CampoPesquisaWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8,
        left: widget.paddingHorizontal,
        right: widget.paddingHorizontal,
      ),
      child: DropdownSearch<Cidade>(
        validator: (value) => value == null ? 'Campo obrigatório' : null,
        asyncItems: widget.asyncItems,
        compareFn: widget.compareFn,
        popupProps: PopupPropsMultiSelection.modalBottomSheet(
          isFilterOnline: true,
          showSelectedItems: true,
          showSearchBox: true,
          itemBuilder: _popupItemPesquisa,
          favoriteItemProps: FavoriteItemProps(
            showFavoriteItems: true,
            favoriteItems: (us) {
              return us.where((e) => e.nome!.contains("Mrs")).toList();
            },
          ),
          emptyBuilder: (context, erro) =>
          const Center(
            child: Text(
              'Nenhuma cidade encontrada',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 18),
            ),
          ),
          searchFieldProps: _textFieldProps(
            label: widget.labelSeachTextPesquisa,
          ),
        ),
        dropdownDecoratorProps: _dropDownDecoratorProps(
          label: widget.labelSeachTextPrincipal,
        ),
        dropdownButtonProps: _dropdownButtonProps(),
        itemAsString: (Cidade cidade) => cidade.nome ?? "",
        onChanged: widget.onChanged,
      ),
    );
  }

  Widget _popupItemPesquisa(BuildContext context, Cidade cidade, bool select) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
          selected: select,
          title: Text(cidade.nome ?? ''),
        ),
      ),
    );
  }

  // Personalização do field de pesquisa
  TextFieldProps _textFieldProps({required String label}) {
    return TextFieldProps(
      padding: const EdgeInsets.only(bottom: 5, left: 8, right: 8),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          top: 13,
          bottom: 13,
          left: 8,
        ),
        labelText: label,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueGrey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }

  // Personalização do Input de pesquisa
  DropDownDecoratorProps _dropDownDecoratorProps({required String label}) {
    return DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        labelText: label,
        //Borda Principal
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: Colors.blueGrey,
          ),
        ),
        //Borda ao Clicar
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        isDense: true,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
        alignLabelWithHint: false,
        enabled: false,
        filled: false,
        isCollapsed: false,
      ),
    );
  }

  // Personalização do Icone
  DropdownButtonProps _dropdownButtonProps() {
    return const DropdownButtonProps(
      color: Colors.black,
      autofocus: false,
      enableFeedback: false,
    );
  }
}
