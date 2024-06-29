import 'package:bu_edmrs/API/bindings.dart';
import 'package:bu_edmrs/pages/home.dart';
import 'package:bu_edmrs/pages/login.dart';
import 'package:bu_edmrs/common/logged_in_check.dart';
import 'package:bu_edmrs/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class App extends StatelessWidget {
  App({super.key});
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: isLoggedIn() ? Home() : const LoginScreen(),
      initialBinding: InitialBindings(),
    );
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataService>(() => DataService());
  }
}
