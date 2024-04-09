import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kabadi_app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        );
      },
      themeMode:ThemeMode.light,
      theme: ThemeData(
        colorSchemeSeed:  Colors.black,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        brightness: Brightness.light,
      ),

      scrollBehavior: const MaterialScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Kabadi',
      initialRoute: Routes.splashView,
      getPages: AppPages.routes,
    );
  }
}

