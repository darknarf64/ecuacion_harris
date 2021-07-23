import 'package:flutter/material.dart';

class PageBackground extends StatelessWidget {
  final Color colorprimario;
  final Color colorsecunadrio;

  const PageBackground(
      {Key? key, required this.colorprimario, required this.colorsecunadrio})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //gradiente guinda
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                this.colorprimario,
                this.colorsecunadrio,
              ])),
        ),
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.90,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white70),
          ),
        )
      ],
    );
  }
}
