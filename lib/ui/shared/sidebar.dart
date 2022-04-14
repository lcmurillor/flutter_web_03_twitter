import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/services.dart';
import 'package:admin_dashboard/ui/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);
  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Logo(),
          const SizedBox(height: 50),
          const TextSeparator(text: 'main'),
          MenuItem(
              isActive:
                  sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
              text: 'Dashboard',
              icon: Icons.compass_calibration_outlined,
              onPressed: () => navigateTo(Flurorouter.dashboardRoute)),
          MenuItem(
              text: 'Orders',
              icon: Icons.shopping_cart_outlined,
              onPressed: () => SideMenuProvider.closeMenu()),
          MenuItem(
              text: 'Analytic',
              icon: Icons.show_chart_outlined,
              onPressed: () => SideMenuProvider.closeMenu()),
          MenuItem(
              isActive:
                  sideMenuProvider.currentPage == Flurorouter.categorieRoute,
              text: 'Categories',
              icon: Icons.layers_outlined,
              onPressed: () => navigateTo(Flurorouter.categorieRoute)),
          MenuItem(
              text: 'Products',
              icon: Icons.dashboard_outlined,
              onPressed: () => SideMenuProvider.closeMenu()),
          MenuItem(
              text: 'Discount',
              icon: Icons.attach_money_outlined,
              onPressed: () => SideMenuProvider.closeMenu()),
          MenuItem(
              text: 'Customers',
              icon: Icons.people_alt_outlined,
              onPressed: () => navigateTo(Flurorouter.userRoute)),
          const SizedBox(height: 30),
          const TextSeparator(text: 'UI Elements'),
          MenuItem(
              isActive: sideMenuProvider.currentPage == Flurorouter.iconRoute,
              text: 'Icons',
              icon: Icons.list_alt_outlined,
              onPressed: () => navigateTo(Flurorouter.iconRoute)),
          MenuItem(
              text: 'Marketing',
              icon: Icons.mark_email_read_outlined,
              onPressed: () => SideMenuProvider.closeMenu()),
          MenuItem(
              text: 'Campaign',
              icon: Icons.note_add_outlined,
              onPressed: () => SideMenuProvider.closeMenu()),
          MenuItem(
              isActive: sideMenuProvider.currentPage == Flurorouter.blankRoute,
              text: 'Blank',
              icon: Icons.post_add_outlined,
              onPressed: () => navigateTo(Flurorouter.blankRoute)),
          const SizedBox(height: 30),
          const TextSeparator(text: 'Exit'),
          MenuItem(
              text: 'Logout',
              icon: Icons.exit_to_app_outlined,
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      gradient: LinearGradient(colors: [
        Color(0xff092044),
        Color(0xff092042),
      ]),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
