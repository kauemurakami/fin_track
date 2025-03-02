
import './delegate_imports.dart';

class MyGoRouterDelegate {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _rootNavigatorKey;
  GoRouter get router => _router;

  final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.home.rpath,
    routes: <RouteBase>[
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/',
        redirect: (_, state) {
          print(state.fullPath);
          return AppRoutes.home.rpath;
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (_, state, navigationShell) {
          return DashboardPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home.rpath,
                name: AppRoutes.home,
                pageBuilder: (_, state) {
                  print(state.fullPath);
                  return CustomSlideTransition(
                    from: SlideFrom.left,
                    child: ChangeNotifierProvider<HomeProvider>(
                      create: (context) => HomeProvider(
                        HomeRepository(
                          getIt<DBService>(),
                        ),
                      ),
                      child: const HomePage(),
                    ),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.income.rpath,
                name: AppRoutes.income,
                pageBuilder: (_, state) {
                  print(state.fullPath);
                  return CustomFadeTransition(
                    child: ChangeNotifierProvider<IncomeProvider>(
                      create: (context) => IncomeProvider(),
                      child: const IncomePage(),
                    ),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.expenses.rpath,
                name: AppRoutes.expenses,
                pageBuilder: (context, state) {
                  print(state.fullPath);
                  return CustomSlideTransition(
                    from: SlideFrom.right,
                    child: ChangeNotifierProvider<ExpensesProvider>(
                      create: (_) => ExpensesProvider(
                        ExpensesRepository(
                          getIt<DBService>(),
                        ),
                      ),
                      child: const ExpensesPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      // GoRoute(
      //   path: AppRoutes.tourist.rpath,
      //   name: AppRoutes.tourist,
      //   pageBuilder: (_, state) {
      //     print(state.fullPath);
      //     return CustomSlideTransition(
      //       from: SlideFrom.right,
      //       child: ChangeNotifierProvider<TouristController>(
      //         create: (context) => TouristController(),
      //         child: const TouristPage(),
      //       ),
      //     );
      //   },
      // ),
    ],
  );
}
