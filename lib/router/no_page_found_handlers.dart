import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/ui/views/views.dart';
import 'package:fluro/fluro.dart';

class NoPageFoundHandlers {
  static Handler noPageFound = Handler(handlerFunc: (context, parameters) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl('/404');
    return const NoPageFoundView();
  });
}
