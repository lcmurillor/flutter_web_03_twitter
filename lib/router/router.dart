import 'package:admin_dashboard/router/admin_handlers.dart';
import 'package:admin_dashboard/router/dashboard_handlers.dart';
import 'package:admin_dashboard/router/no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';

  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';

  static String dashboardRoute = '/dashboard';
  static String iconRoute = '/dashboard/icons';
  static String blankRoute = '/dashboard/blank';
  static String categorieRoute = '/dashboard/categories';

  static void configureRoute() {
    router.define(rootRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(registerRoute,
        handler: AdminHandlers.register, transitionType: TransitionType.none);

    router.define(dashboardRoute,
        handler: DashboardHandlers.dashboard,
        transitionType: TransitionType.none);
    router.define(iconRoute,
        handler: DashboardHandlers.icons, transitionType: TransitionType.none);
    router.define(blankRoute,
        handler: DashboardHandlers.blank, transitionType: TransitionType.none);

    router.define(categorieRoute,
        handler: DashboardHandlers.categories,
        transitionType: TransitionType.none);

    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
