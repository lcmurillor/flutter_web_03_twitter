import 'package:admin_dashboard/models/models.dart';
import 'package:admin_dashboard/services/services.dart';
import 'package:flutter/material.dart';

class UsersDTS extends DataTableSource {
  final List<Usuario> users;

  UsersDTS(this.users);

  @override
  DataRow getRow(int index) {
    final Usuario user = users[index];
    final image = (user.img == null)
        ? const Image(
            image: AssetImage('no-image.jpg'),
            width: 35,
            height: 35,
          )
        : FadeInImage.assetNetwork(
            placeholder: 'loader.gif', width: 35, height: 35, image: user.img!);
    return DataRow.byIndex(index: index, cells: [
      DataCell(ClipOval(child: image)),
      DataCell(Text(user.nombre)),
      DataCell(Text(user.correo)),
      DataCell(Text(user.uid)),
      DataCell(IconButton(
          onPressed: () {
            NavigationService.navigateTo('/dashboard/users/${user.uid}');
          },
          icon: const Icon(Icons.edit_outlined)))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}
