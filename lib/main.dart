import 'dart:async';

import 'package:env_reader/env_reader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/common/extensions.dart';
import 'package:flutter_template/firebase_options.dart';
import 'package:flutter_template/gen/env/env_model.dart';
import 'package:flutter_template/gen/l10n/app_localizations.dart';
import 'package:flutter_template/routes/router.dart';
import 'package:flutter_template/services/app_analytics.dart';
import 'package:flutter_template/services/app_logger.dart';
import 'package:flutter_template/services/app_prefs.dart';
import 'package:flutter_template/setup.dart';
import 'package:flutter_template/theme/theme_manager.dart';
import 'package:flutter_template/views/screens/auth/cubit/auth_cubit.dart';
import 'package:flutter_template/views/screens/home/cubit/todo_cubit.dart';
import 'package:flutter_template/views/screens/setting/cubit/setting_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    // Initialize Splash Screen
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    // Initialize Env
    await Env.load(
      EnvStringLoader(await rootBundle.loadString('assets/env/.env')),
      'MyOptionalSecretKey',
    );

    // Initialize ScreenUtil
    await ScreenUtil.ensureScreenSize();

    // Firebase initialization
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Supabase initialization
    await Supabase.initialize(
      url: EnvModel.supabaseUrl,
      anonKey: EnvModel.supabaseAnon,
    );

    // Initialize App Analytics
    await AppAnalytics.init();

    // Initialize Shared Preferences
    await AppPref.init();

    // Initialize AppLogger
    await AppLogger.init();

    // Initialize Dependency Injection
    setup();

    runApp(const MyApp());
  }, catchUnhandledExceptions);
}

void catchUnhandledExceptions(Object error, StackTrace? stack) {
  debugPrintStack(stackTrace: stack, label: error.toString());
  FirebaseCrashlytics.instance.recordError(error, stack);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingCubit>(create: (context) => SettingCubit()..init()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()..init()),
        BlocProvider<TodoCubit>(
          create: (context) => TodoCubit()..getAllTodos(),
        ),
      ],
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(402, 874),
            minTextAdapt: true,
            ensureScreenSize: true,
            useInheritedMediaQuery: true,
            builder: (context, _) {
              final seedColor =
                  AppPrefHelper.getIsDynamicColor()
                      ? (AppPrefHelper.getDynamicColor() == 0
                          ? colorPalette[0]
                          : AppPrefHelper.getDynamicColor().toARGB32())
                      : Colors.purple;

              return MaterialApp.router(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                locale: Locale(state.locale),
                supportedLocales: const [
                  Locale('en'),
                  Locale('hi'),
                  Locale('es'),
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
                ),
                darkTheme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    brightness: Brightness.dark,
                    seedColor: seedColor,
                  ),
                ),
                themeMode: state.themeMode,
                routerConfig: routerConfig,
              );
            },
          );
        },
      ),
    );
  }
}
