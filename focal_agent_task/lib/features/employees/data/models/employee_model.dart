import 'package:focal_agent_task/features/employees/domain/entities/employee.dart';

import '../../domain/enums/employee_category.dart';

class EmployeeModel {
  final String firstName;
  final String lastName;
  final String employeeId;
  final String category;

  EmployeeModel({
    required this.firstName,
    required this.lastName,
    required this.employeeId,
    required this.category,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      employeeId: json['employeeId'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'employeeId': employeeId,
      'category': category,
    };
  }

  Employee toEntity() {
    return Employee(
      firstName: firstName,
      lastName: lastName,
      employeeId: employeeId,
      category: EmployeeCategory.values.firstWhere(
        (c) => c.text.toLowerCase() == category.toLowerCase(),
        orElse: () => EmployeeCategory.none,
      ),
    );
  }

  factory EmployeeModel.fromEntity(Employee employee) {
    return EmployeeModel(
      firstName: employee.firstName,
      lastName: employee.lastName,
      employeeId: employee.employeeId,
      category: employee.category.text,
    );
  }
}
