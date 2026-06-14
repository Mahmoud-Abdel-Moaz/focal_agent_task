import '../../domain/enums/employee_category.dart';
import '../models/employee_model.dart';

abstract class MockEmployeesDataSource {
  Future<List<EmployeeModel>> getEmployees();
}

class MockEmployeesDataSourceImp implements MockEmployeesDataSource {
  @override
  Future<List<EmployeeModel>> getEmployees() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      EmployeeModel(
        employeeId: 'IT001',
        firstName: 'Alice',
        lastName: 'Chen',
        category: EmployeeCategory.iT.text,
      ),
      EmployeeModel(
        employeeId: 'IT002',
        firstName: 'Bob',
        lastName: 'Hassan',
        category: EmployeeCategory.iT.text,
      ),
      EmployeeModel(
        employeeId: 'IT003',
        firstName: 'Carlos',
        lastName: 'Rivera',
        category: EmployeeCategory.iT.text,
      ),
      EmployeeModel(
        employeeId: 'IT004',
        firstName: 'Diana',
        lastName: 'Kim',
        category: EmployeeCategory.iT.text,
      ),
      EmployeeModel(
        employeeId: 'HR001',
        firstName: 'Emma',
        lastName: 'Walsh',
        category: EmployeeCategory.hR.text,
      ),
      EmployeeModel(
        employeeId: 'HR002',
        firstName: 'Frank',
        lastName: 'Miller',
        category: EmployeeCategory.hR.text,
      ),
      EmployeeModel(
        employeeId: 'HR003',
        firstName: 'Grace',
        lastName: 'Hopper',
        category: EmployeeCategory.hR.text,
      ),
    ];
  }
}
