import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CampoPesquisaWidget extends StatefulWidget {
  CampoPesquisaWidget({Key? key,
    required this.objects,
    required this.objectAsString,
    required this.objectOnFind,
    required this.onChanged,
    required this.labelText,
    required this.labelSeachText,
    required this.icon,
  }) : super(key: key);

  List<dynamic>? objects;
  DropdownSearchItemAsString<dynamic>? objectAsString;
  DropdownSearchOnFind<dynamic>? objectOnFind;
  ValueChanged<dynamic>? onChanged;
  String? labelText;
  String? labelSeachText;
  Widget icon;

  @override
  _CampoPesquisaWidget createState() => _CampoPesquisaWidget();
}

class _CampoPesquisaWidget extends State<CampoPesquisaWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 15,
        left: 35,
        right: 35,
      ),
      child: _dropdownSearch(),
    );
  }

  DropdownSearch<dynamic> _dropdownSearch() {
    return DropdownSearch<dynamic>(

      // popupBackgroundColor: Colors.grey.shade50,
      popupShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      validator: (value) => value == null ? 'Campo obrigatório' : null,

      // Pesonalização do Field de pesquisa abaixo
      searchFieldProps: TextFieldProps(
        padding: const EdgeInsets.only(top: 15, bottom: 4, left: 8, right: 8),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            top: 13,
            bottom: 13,
            left: 8,
          ),
          labelText: widget.labelSeachText,

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
      ),

      // Cor de fundo ao clicar
      dropdownSearchDecoration: InputDecoration(
        labelText: widget.labelText,
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

      // Personalização Icon
      dropdownButtonProps: IconButtonProps(
        padding: const EdgeInsets.only(
          right: 20,
        ),
        icon: widget.icon,
        color: Colors.black,
        autofocus: false,
        enableFeedback: false,
      ),

      mode: Mode.MENU,
      isFilteredOnline: true,
      showClearButton: false,
      showSearchBox: true,
      onFind: widget.objectOnFind,
    );
  }
}