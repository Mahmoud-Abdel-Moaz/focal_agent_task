import 'package:equatable/equatable.dart';

import '../enums/employee_category.dart';

class Employee extends Equatable {
  final String firstName;
  final String lastName;
  final String employeeId;
  final EmployeeCategory category;

  const Employee({
    required this.firstName,
    required this.lastName,
    required this.employeeId,
    required this.category,
  });

  String get fullName =>
      "$firstName${firstName.isNotEmpty && lastName.isNotEmpty ? ' $lastName' : lastName}";

  @override
  List<Object?> get props => [firstName, lastName, employeeId, category];
}
