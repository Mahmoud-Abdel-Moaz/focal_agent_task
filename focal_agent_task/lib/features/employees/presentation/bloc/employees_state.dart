part of 'employees_bloc.dart';

sealed class EmployeesState extends Equatable {
  const EmployeesState();
}

final class EmployeesInitial extends EmployeesState {
  @override
  List<Object> get props => [];
}

final class EmployeesLoading extends EmployeesState {
  @override
  List<Object> get props => [];
}

final class EmployeesLoaded extends EmployeesState {
  final List<Employee> employees;

  const EmployeesLoaded(this.employees);

  @override
  List<Object> get props => [employees];
}

final class EmployeesError extends EmployeesState {
  final String message;

  const EmployeesError(this.message);

  @override
  List<Object> get props => [message];
}
