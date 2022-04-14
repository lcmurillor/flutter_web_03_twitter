import 'package:admin_dashboard/datatables/datasources.dart';
import 'package:admin_dashboard/models/models.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/ui/buttons/buttons.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:admin_dashboard/ui/modals/category_modal.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<CategoriesProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final List<Categoria> categorias =
        Provider.of<CategoriesProvider>(context).categorias;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(physics: const ClampingScrollPhysics(), children: [
        Text('Categorias', style: CustomLabels.h1),
        const SizedBox(height: 10),
        PaginatedDataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Categoria')),
            DataColumn(label: Text('Crado por')),
            DataColumn(label: Text('Acciones')),
          ],
          source: CategoriesDTS(categorias, context),
          header: const Text('Lista de todas las Categorias disponibles',
              maxLines: 2),
          onRowsPerPageChanged: (value) {
            setState(() {
              _rowsPerPage = value ?? 10;
            });
          },
          rowsPerPage: _rowsPerPage,
          actions: [
            CustomIconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (_) => const CategoryModal(categoria: null));
                },
                text: 'Agregar',
                icon: Icons.add_outlined),
          ],
        )
      ]),
    );
  }
}
