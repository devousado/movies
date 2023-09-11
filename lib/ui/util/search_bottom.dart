import 'package:flutter/material.dart';

Widget searcWidget(
    {required void Function(String)? onSubmitted,
    required TextEditingController textEditingController}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey, // Cor da sombra
          blurRadius: 3, // Raio do desfoque da sombra
          spreadRadius: 2.0, // Espalhamento da sombra
          offset: Offset(1, 2), // Deslocamento da sombra (horizontal, vertical)
        ),
      ],
    ),
    child: TextField(
        onSubmitted: onSubmitted,
        controller: textEditingController,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          prefixIcon: const Icon(
            Icons.search,
            size: 20,
          ),
          prefixIconColor: Colors.black,
          filled: true,
          fillColor: Colors.grey,
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.grey)),
        )),
  );
}
