import 'package:admin_dashboard/ui/buttons/custom_outlined.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
          child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 750),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              style: const TextStyle(color: Colors.white),
              decoration: buildInputDecoration(
                  hint: 'Ingrese su correo',
                  icon: Icons.email_outlined,
                  label: 'Email'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              decoration: buildInputDecoration(
                  hint: '************',
                  icon: Icons.lock_outline_sharp,
                  label: 'Constraseña'),
            ),
            const SizedBox(height: 20),
            CustomOutlinedButton(
              onPressed: () {},
              text: 'Ingresar',
            ),
            const SizedBox(height: 20),
            LinkText(text: 'Nueva cuenta', onPressed: () {}),
          ],
        )),
      )),
    );
  }

  InputDecoration buildInputDecoration(
      {required String hint, required String label, required IconData icon}) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.3))),
        hintText: hint,
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        hintStyle: const TextStyle(color: Colors.grey),
        labelStyle: const TextStyle(color: Colors.grey));
  }
}
