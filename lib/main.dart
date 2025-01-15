import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vlens_flutter/ui/ids_instructions/view/ids_instructions_screen.dart';

import 'di/di_setup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  setupDI().then((_) {
    runApp(
      EasyLocalization(
          supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: const MyApp()),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'poppins',
        colorScheme: const ColorScheme(
          primary: Colors.transparent,
          secondary: Colors.transparent,
          surface: Colors.transparent,
          error: Colors.transparent,
          onPrimary: Colors.transparent,
          onSecondary: Colors.transparent,
          onSurface: Colors.transparent,
          onError: Colors.transparent,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home:  IDsInstructionsScreen(),
    );
  }
}
