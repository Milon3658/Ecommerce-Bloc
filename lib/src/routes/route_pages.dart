import 'package:bloc_ecommerce/src/data/services/auth_service.dart';
import 'package:bloc_ecommerce/src/presentation/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/screens/screens.dart';

part 'routes.dart';

class RoutePages {
  static final authService = AuthService();
  static final ROUTER = GoRouter(
    // redirect: (context, state){
    //   if(authService.checkUserAuth()){
    //     if(state.fullPath == Routes.WELCOME || state.fullPath == Routes.LOGIN_ROUTE || state.fullPath ==  Routes.REGISTER_ROUTE){
    //       return Routes.HOME;
    //     }else{
    //       return state.fullPath;
    //     }
    //   }else{
    //     return Routes.WELCOME;
    //   }
    // },
    routes: [
      GoRoute(
          path: Routes.SPLASH,
          name: Routes.SPLASH,
          pageBuilder: (context, state) =>
              const MaterialPage(child: SplashScreen())),
      GoRoute(
          path: Routes.WELCOME,
          name: Routes.WELCOME,
          pageBuilder: (context, state) =>
              const MaterialPage(child: WelcomeScreen())),
      GoRoute(
          path: Routes.LOGIN_ROUTE,
          name: Routes.LOGIN_ROUTE,
          pageBuilder: (context, state) =>
              const MaterialPage(child: LoginScreen())),
      GoRoute(
          path: Routes.REGISTER_ROUTE,
          name: Routes.REGISTER_ROUTE,
          pageBuilder: (context, state) =>
              const MaterialPage(child: SignupScreen())),
      ShellRoute(
        builder: (context, state, child) => Wrapper(child: child),
        routes: [
          GoRoute(
              path: Routes.HOME,
              name: Routes.HOME,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: HomeScreen()))
        ],
      ),
    ],
  );
}
