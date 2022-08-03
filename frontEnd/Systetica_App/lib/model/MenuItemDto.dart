// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MenuItemDto {
  MenuItemDto({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  static Widget buildItem(MenuItemDto item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
