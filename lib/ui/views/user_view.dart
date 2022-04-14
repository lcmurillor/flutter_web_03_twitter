import 'package:admin_dashboard/models/models.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/services/services.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  Usuario? user;

  @override
  void initState() {
    super.initState();
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final userFormProvider =
        Provider.of<UserFormProvider>(context, listen: false);
    usersProvider.getUserByID(widget.uid).then((userDB) {
      if (userDB != null) {
        userFormProvider.user = userDB;
        userFormProvider.formkey = GlobalKey<FormState>();
        setState(() {
          user = userDB;
        });
      } else {
        NavigationService.replaceTo('/dashboard/users');
      }
    });
  }

  @override
  void dispose() {
    user = null;
    Provider.of<UserFormProvider>(context, listen: false).user = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(physics: const ClampingScrollPhysics(), children: [
        Text('UserView', style: CustomLabels.h1),
        const SizedBox(height: 10),
        if (user == null)
          WhiteCard(
              child: Container(
            height: 400,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          )),
        if (user != null) const _UserViewBody()
      ]),
    );
  }
}

class _UserViewBody extends StatelessWidget {
  const _UserViewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(columnWidths: const {
      0: FixedColumnWidth(250)
    }, children: const [
      TableRow(children: [_AvatarContainer(), _UserViewForm()])
    ]);
  }
}

class _UserViewForm extends StatelessWidget {
  const _UserViewForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;
    return WhiteCard(
        title: 'Información general ${user.correo}',
        child: Form(
          key: userFormProvider.formkey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un nombre';
                  } else if (value.length < 2) {
                    return 'El nombre dede de ser de 2 letras como minimo';
                  }
                  return null;
                },
                onChanged: (value) =>
                    userFormProvider.copyUserWith(nombre: value),
                initialValue: user.nombre,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Nombre del usuaro',
                    label: 'Nombre',
                    icon: Icons.supervised_user_circle_outlined),
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (!EmailValidator.validate(value ?? '')) {
                    return 'Email no valido';
                  }
                  return null;
                },
                onChanged: (value) =>
                    userFormProvider.copyUserWith(correo: value),
                initialValue: user.correo,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Correo del usuaro',
                    label: 'Correo',
                    icon: Icons.mark_email_read_outlined),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 110),

                ///BOTON PARA GUARDAR LOS CMABIOS
                child: ElevatedButton(
                    onPressed: () async {
                      final saved = await userFormProvider.updateUser();
                      if (saved) {
                        NotificationsService.showSnackbar(
                            'El usuario se actualizó');
                        Provider.of<UsersProvider>(context, listen: false)
                            .refreshUser(user);
                      } else {
                        NotificationsService.showSnackbarError(
                            'No se pudo guardar');
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    child: Row(
                      children: const [
                        Icon(Icons.save_outlined, size: 20),
                        Text(' Guardar')
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}

class _AvatarContainer extends StatelessWidget {
  const _AvatarContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;
    final image = (user.img == null)
        ? const Image(image: AssetImage('no-image.jpg'))
        : FadeInImage.assetNetwork(placeholder: 'loader.gif', image: user.img!);
    return WhiteCard(
        width: 250,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Perfil', style: CustomLabels.h2),
              const SizedBox(height: 20),
              SizedBox(
                width: 150,
                height: 160,
                child: Stack(
                  children: [
                    ClipOval(child: image),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.white, width: 5)),

                        ///BOTON PARA CARGAR LA IMAGEN
                        child: FloatingActionButton(
                          backgroundColor: Colors.indigo,
                          onPressed: () async {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['jpg', 'jpeg', 'png'],
                                    allowMultiple: false);

                            if (result != null) {
                              //PlatformFile file = result.files.first;
                              NotificationsService.showBusyIndicator(context);
                              final newUser =
                                  await userFormProvider.uploadImage(
                                      '/uploads/usuarios/${user.uid}',
                                      result.files.first.bytes!);
                              Provider.of<UsersProvider>(context, listen: false)
                                  .refreshUser(newUser);
                              Navigator.pop(context);
                            } else {
                              // User canceled the picker
                            }
                          },
                          child:
                              const Icon(Icons.camera_alt_outlined, size: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                user.nombre,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }
}
