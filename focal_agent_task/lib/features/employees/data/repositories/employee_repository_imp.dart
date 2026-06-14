import 'package:focal_agent_task/core/error/exceptions.dart';
import 'package:focal_agent_task/core/error/failures.dart';

import 'package:focal_agent_task/features/employees/domain/entities/employee.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repositories/employee_repository.dart';
import '../data_sources/cashed_employees_data_source.dart';
import '../data_sources/mock_employees_data_source.dart';

class EmployeeRepositoryImp extends EmployeeRepository {
  final MockEmployeesDataSource mockEmployeesDataSource;
  final CashedEmployeesDataSource cashedEmployeesDataSource;

  EmployeeRepositoryImp({
    required this.mockEmployeesDataSource,
    required this.cashedEmployeesDataSource,
  });

  @override
  Future<Either<Failure, List<Employee>>> getEmployees({
    bool forceRefresh = false,
  }) async {
    try {
      final cachedEmployees = await cashedEmployeesDataSource
          .getCachedEmployees();
      if (forceRefresh || cachedEmployees == null) {
        final employees = await mockEmployeesDataSource.getEmployees();
        await cashedEmployeesDataSource.cacheEmployees(employees);
        return Right(
          employees.map((employeeModel) => employeeModel.toEntity()).toList(),
        );
      } else {
        return Right(
          cachedEmployees
              .map((employeeModel) => employeeModel.toEntity())
              .toList(),
        );
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to fetch cached employees'));
    }
  }
}
