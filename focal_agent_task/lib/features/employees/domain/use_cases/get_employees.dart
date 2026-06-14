import 'package:focal_agent_task/features/employees/domain/entities/employee.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../repositories/employee_repository.dart';

class GetAllEmployees {
  final EmployeeRepository repository;

  GetAllEmployees(this.repository);

  Future<Either<Failure, List<Employee>>> call({
    bool forceRefresh = false,
  }) async {
    return await repository.getEmployees(forceRefresh: forceRefresh);
  }
}
