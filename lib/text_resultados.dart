import 'package:flutter/material.dart';

class TextoResultados extends StatelessWidget {
  final Text title;
  final Text subtitle;
  final Icon icon;

  const TextoResultados(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: true,
      title: this.title,
      subtitle: this.subtitle,
      leading: this.icon,
    );
  }
}
