import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/repositories/auth_repository.dart';
import 'package:flutter_template/setup.dart';
import 'package:flutter_template/views/screens/auth/account_screen.dart';
import 'package:flutter_template/views/screens/auth/forgot_screen.dart';
import 'package:flutter_template/views/screens/auth/login_screen.dart';
import 'package:flutter_template/views/screens/auth/signup_screen.dart';
import 'package:flutter_template/views/screens/dashboard.dart';
import 'package:flutter_template/views/screens/home/home_screen.dart';
import 'package:flutter_template/views/screens/setting/language_screen.dart';
import 'package:flutter_template/views/screens/setting/setting_screen.dart';
import 'package:flutter_template/views/screens/setting/theme_screen.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

class MyRoutes {
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const setting = '/setting';
  static const forgot = '/forgot';
  static const resetPassword = '/reset-password/:oobCode';
  static const me = '/me';
  static const language = '/language';
  static const theme = '/theme';
}

final routerConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: MyRoutes.login,
  routes: $appRoutes,
  debugLogDiagnostics: true,
  redirect: (BuildContext context, GoRouterState state) async {
    final currentUser = await getIt<AuthRepository>().currentUser;

    final isAuthenticated = currentUser != null;
    final isAuthenticating = state.matchedLocation == MyRoutes.login;

    if (!isAuthenticated) {
      if (state.matchedLocation.startsWith(MyRoutes.signup)) {
        return MyRoutes.signup;
      }

      if (state.matchedLocation.startsWith(MyRoutes.forgot)) {
        return MyRoutes.forgot;
      }

      return MyRoutes.login;
    }

    if (isAuthenticating) {
      return MyRoutes.home;
    }

    return null;
  },
);

@TypedGoRoute<LgoinRoute>(path: MyRoutes.login)
class LgoinRoute extends GoRouteData {
  const LgoinRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MyLoginScreen();
}

@TypedGoRoute<SignupRoute>(path: MyRoutes.signup)
class SignupRoute extends GoRouteData {
  const SignupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MySignupScreen();
}

@TypedGoRoute<ForgotRoute>(path: MyRoutes.forgot)
class ForgotRoute extends GoRouteData {
  const ForgotRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MyForgotScreen();
}

@TypedGoRoute<AccountRoute>(path: MyRoutes.me)
class AccountRoute extends GoRouteData {
  const AccountRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MyAccountScreen();
}

@TypedGoRoute<LanguageRoute>(path: MyRoutes.language)
class LanguageRoute extends GoRouteData {
  const LanguageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MyLanguageScreen();
}

@TypedGoRoute<ThemeRoute>(path: MyRoutes.theme)
class ThemeRoute extends GoRouteData {
  const ThemeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MyThemeScreen();
}

@TypedShellRoute<DashboardRoute>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeRoute>(path: MyRoutes.home),
    TypedGoRoute<SettingRoute>(path: MyRoutes.setting),
  ],
)
class DashboardRoute extends ShellRouteData {
  const DashboardRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return MyDashboard(child: navigator);
  }

  // Add this static method to provide the navigator key
  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;
}

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(child: MyHomeScreen());
  }
}

class SettingRoute extends GoRouteData {
  const SettingRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(child: MySettingScreen());
  }
}
