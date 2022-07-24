import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CampoDataWidget extends StatelessWidget {
  const CampoDataWidget({
    Key? key,
    this.paddingTop = 0,
    required this.hintText,
    required this.paddingBottom,
    required this.onChanged,
    required this.controller,
    this.validator,
  }) : super(key: key);

  final double paddingBottom;
  final double? paddingTop;
  final String hintText;
  final void Function(String) onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: paddingBottom,
        top: paddingTop!,
        left: 35,
        right: 35,
      ),
      child: _textFormField(
        context: context,
      ),
    );
  }

  TextFormField _textFormField({required BuildContext context}) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black,
      ),
      controller: controller,
      maxLength: 10,
      decoration: InputDecoration(
        counterStyle: const TextStyle(color: Colors.black),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 16.0,
        ),
        border: const OutlineInputBorder(
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
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: Colors.blueGrey,
          ),
        ),
        labelText: hintText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 17,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(
            Icons.calendar_today,
            color: Colors.black87,
          ),
        ),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
          //formatted date output using intl package =>  2021-03-16
          onChanged(formattedDate);
        }
      },
      validator: validator,
    );
  }
}
