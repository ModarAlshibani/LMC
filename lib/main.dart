import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';
import 'package:lmc_app/core/routing/routes.dart';
import 'package:lmc_app/features/for_all/login/logic/cubit/logout_cubit.dart';
import 'package:lmc_app/features/for_all/login/logic/usecases/logout_usecase.dart';
import 'package:lmc_app/features/for_all/placement_tests/data/repo/placement_test_di.dart';
import 'core/di/dependency_injection.dart';
import 'core/routing/app_router.dart';
import 'features/lmc_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  setupPlacementTestDependencies();
  
  final storage = FlutterSecureStorage();
  
  String? token;
  String? role;
  
  try {
    token = await storage.read(key: 'userToken');
    role = await storage.read(key: 'userRole');
  } on PlatformException catch (e) {
    print('Secure Storage Error: ${e.message}');
    
    if (e.message?.contains('BadPaddingException') == true || 
        e.message?.contains('BAD_DECRYPT') == true) {
      print('Decryption error detected. Clearing corrupted storage data...');
      
      try {
        await storage.deleteAll();
        print('Storage cleared successfully');
      } catch (clearError) {
        print('Error clearing storage: $clearError');
      }
    }
    
    token = null;
    role = null;
  } catch (e) {
    print('Unexpected storage error: $e');
    token = null;
    role = null;
  }

  print('Startup token: $token');
  print('Startup role: $role');

  late final String initialRoute;

  if (token != null && token.isNotEmpty) {if (role == 'Teacher') { 
      initialRoute = Routes.teacher_navbar;
    }  else if (role == 'Logistic') {
      initialRoute = Routes.teacher_navbar;
    }else {
      initialRoute = Routes.loginScreen;
    }
  } else {
    initialRoute = Routes.loginScreen;
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit(LogoutUseCase())),
      ],
      child: LmcApp(appRouter: AppRouter(), initialRoute: initialRoute),
    ),
  );
}