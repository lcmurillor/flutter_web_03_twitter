import 'package:admin_dashboard/datatables/datasources.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class UsersView extends StatelessWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    final usersDataSource = UsersDTS(usersProvider.users);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(physics: const ClampingScrollPhysics(), children: [
        Text('UsersView', style: CustomLabels.h1),
        const SizedBox(height: 10),
        PaginatedDataTable(
          sortAscending: usersProvider.ascending,
          sortColumnIndex: usersProvider.sortColumIndex,
          columns: [
            const DataColumn(label: Text('Avatar')),
            DataColumn(
                label: const Text('Nombre'),
                onSort: (index, __) {
                  usersProvider.sortColumIndex = index;
                  usersProvider.sort<String>((user) => user.nombre);
                }),
            DataColumn(
                label: const Text('Email'),
                onSort: (index, __) {
                  usersProvider.sortColumIndex = index;
                  usersProvider.sort<String>((user) => user.correo);
                }),
            const DataColumn(label: Text('UID')),
            const DataColumn(label: Text('Acciones')),
          ],
          source: usersDataSource,
          onPageChanged: (page) {
            //Imprimir la pagina en la que estamos
          },
        )
      ]),
    );
  }
}
