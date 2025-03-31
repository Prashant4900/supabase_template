// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $lgoinRoute,
  $signupRoute,
  $forgotRoute,
  $accountRoute,
  $languageRoute,
  $themeRoute,
  $dashboardRoute,
  $licenseRoute,
];

RouteBase get $lgoinRoute => GoRouteData.$route(
  path: '/login',

  factory: $LgoinRouteExtension._fromState,
);

extension $LgoinRouteExtension on LgoinRoute {
  static LgoinRoute _fromState(GoRouterState state) => const LgoinRoute();

  String get location => GoRouteData.$location('/login');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signupRoute => GoRouteData.$route(
  path: '/signup',

  factory: $SignupRouteExtension._fromState,
);

extension $SignupRouteExtension on SignupRoute {
  static SignupRoute _fromState(GoRouterState state) => const SignupRoute();

  String get location => GoRouteData.$location('/signup');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $forgotRoute => GoRouteData.$route(
  path: '/forgot',

  factory: $ForgotRouteExtension._fromState,
);

extension $ForgotRouteExtension on ForgotRoute {
  static ForgotRoute _fromState(GoRouterState state) => const ForgotRoute();

  String get location => GoRouteData.$location('/forgot');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $accountRoute =>
    GoRouteData.$route(path: '/me', factory: $AccountRouteExtension._fromState);

extension $AccountRouteExtension on AccountRoute {
  static AccountRoute _fromState(GoRouterState state) => const AccountRoute();

  String get location => GoRouteData.$location('/me');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $languageRoute => GoRouteData.$route(
  path: '/language',

  factory: $LanguageRouteExtension._fromState,
);

extension $LanguageRouteExtension on LanguageRoute {
  static LanguageRoute _fromState(GoRouterState state) => const LanguageRoute();

  String get location => GoRouteData.$location('/language');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $themeRoute => GoRouteData.$route(
  path: '/theme',

  factory: $ThemeRouteExtension._fromState,
);

extension $ThemeRouteExtension on ThemeRoute {
  static ThemeRoute _fromState(GoRouterState state) => const ThemeRoute();

  String get location => GoRouteData.$location('/theme');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $dashboardRoute => ShellRouteData.$route(
  navigatorKey: DashboardRoute.$navigatorKey,
  factory: $DashboardRouteExtension._fromState,
  routes: [
    GoRouteData.$route(path: '/home', factory: $HomeRouteExtension._fromState),
    GoRouteData.$route(
      path: '/setting',

      factory: $SettingRouteExtension._fromState,
    ),
  ],
);

extension $DashboardRouteExtension on DashboardRoute {
  static DashboardRoute _fromState(GoRouterState state) =>
      const DashboardRoute();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location('/home');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingRouteExtension on SettingRoute {
  static SettingRoute _fromState(GoRouterState state) => const SettingRoute();

  String get location => GoRouteData.$location('/setting');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $licenseRoute => GoRouteData.$route(
  path: '/license',

  factory: $LicenseRouteExtension._fromState,
);

extension $LicenseRouteExtension on LicenseRoute {
  static LicenseRoute _fromState(GoRouterState state) => const LicenseRoute();

  String get location => GoRouteData.$location('/license');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
