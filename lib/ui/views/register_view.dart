import 'package:admin_dashboard/providers/register_form_provicer.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: Builder(
        builder: ((context) {
          final registerFormProvider =
              Provider.of<RegisterFormProvider>(context, listen: false);
          return Container(
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
                child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 750),
              child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: registerFormProvider.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) => registerFormProvider.name = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Debe ingresar un nombre';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.buildInputDecoration(
                            hint: 'Ingrese su nombre',
                            icon: Icons.supervised_user_circle_outlined,
                            label: 'Nombre'),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) =>
                            registerFormProvider.email = value,
                        validator: (value) {
                          if (!EmailValidator.validate(value ?? '')) {
                            return 'Email no valido';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.buildInputDecoration(
                            hint: 'Ingrese su correo',
                            icon: Icons.email_outlined,
                            label: 'Email'),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) =>
                            registerFormProvider.password = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su contraseña';
                          }
                          if (value.length < 6) {
                            return 'La contraseña debe ser de mas de 6 caracteres ';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.buildInputDecoration(
                            hint: '************',
                            icon: Icons.lock_outline_sharp,
                            label: 'Constraseña'),
                      ),
                      const SizedBox(height: 20),
                      CustomOutlinedButton(
                        onPressed: () {
                          registerFormProvider.validateForm();
                        },
                        text: 'Crear cuenta',
                      ),
                      const SizedBox(height: 20),
                      LinkText(
                          text: 'Ingresar',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Flurorouter.loginRoute);
                          }),
                    ],
                  )),
            )),
          );
        }),
      ),
    );
  }
}
