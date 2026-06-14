import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:focal_agent_task/core/di/injection_container.dart' as di;

import 'features/employees/presentation/bloc/employees_bloc.dart';
import 'features/employees/presentation/pages/employees_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(_) => di.getIt<EmployeesBloc>()..add(LoadEmployeesEvent()),
      child: ScreenUtilPlusInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Forcal Agent Task',
            home: const EmployeesScreen(),
          );
        },
      ),
    );
  }
}
