import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class UsersView extends StatelessWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(physics: const ClampingScrollPhysics(), children: [
        Text('UsersView', style: CustomLabels.h1),
        const SizedBox(height: 10),
        const WhiteCard(title: 'UsersView', child: Text('hola UsersView')),
        const WhiteCard(child: Text('hola mundo'))
      ]),
    );
  }
}
