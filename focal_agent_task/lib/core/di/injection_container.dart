import 'package:focal_agent_task/features/employees/domain/use_cases/get_employees.dart';
import 'package:focal_agent_task/features/employees/presentation/bloc/employees_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/employees/data/data_sources/cached_employees_data_source.dart';
import '../../features/employees/data/data_sources/mock_employees_data_source.dart';
import '../../features/employees/data/repositories/employee_repository_imp.dart';
import '../../features/employees/domain/repositories/employee_repository.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // ! Features - Employees
  // bloc
  getIt.registerFactory(
    () => EmployeesBloc(
      getIt()
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetAllEmployees(getIt()));

  // Repository
  getIt.registerLazySingleton<EmployeeRepository>(() =>
      EmployeeRepositoryImp(
        mockEmployeesDataSource: getIt(),
        cachedEmployeesDataSource: getIt(),
      ),
  );

  // Data sources
  getIt.registerLazySingleton<CachedEmployeesDataSource>(
        () => CachedEmployeesDataSourceImp(),
  );
  getIt.registerLazySingleton<MockEmployeesDataSource>(
    () => MockEmployeesDataSourceImp(),
  );

}
