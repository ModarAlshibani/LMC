import 'package:flutter/material.dart';
import 'core/di/dependency_injection.dart';
import 'core/routing/app_router.dart';
import 'features/lmc_app.dart';

void main() {

  setupLocator();
  runApp(LmcApp(appRouter: AppRouter()));

}
