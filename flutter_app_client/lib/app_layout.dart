import 'package:flutter/material.dart';

import 'constants/layout_constants.dart';

class AppLayout extends StatelessWidget {
  final Widget childWidget;
  final Widget? bottomWidget;

  const AppLayout({super.key, required this.childWidget, this.bottomWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Фильмы со Стетхемом'),
        backgroundColor: LayoutConstants.headerColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: childWidget,
      ),
      bottomNavigationBar: bottomWidget,
    );
  }
}
