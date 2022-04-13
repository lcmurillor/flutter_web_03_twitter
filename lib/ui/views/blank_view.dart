import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class BlankView extends StatelessWidget {
  const BlankView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(physics: const ClampingScrollPhysics(), children: [
        Text('BlankView ', style: CustomLabels.h1),
        const SizedBox(height: 10),
        const WhiteCard(title: 'estadisticas', child: Text('hola mundo')),
        const WhiteCard(child: Text('hola mundo'))
      ]),
    );
  }
}
