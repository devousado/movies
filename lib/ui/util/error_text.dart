import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ErroScreen extends StatelessWidget {
  ErroScreen({super.key, required this.error});
  String error;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
