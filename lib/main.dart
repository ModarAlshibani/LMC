import 'package:flutter/material.dart';
import 'package:lmc_app/core/di/dependency_injection.dart';
import 'package:lmc_app/core/routing/app_router.dart';
import 'package:lmc_app/features/lmc_app.dart';

void main() {
  setupLocator();
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(LmcApp(appRouter: AppRouter()));
}
