part of 'employees_bloc.dart';

sealed class EmployeesEvent extends Equatable {
  const EmployeesEvent();
}

final class LoadEmployeesEvent extends EmployeesEvent {
  final bool forceRefresh;

  const LoadEmployeesEvent({this.forceRefresh = false});

  @override
  List<Object> get props => [forceRefresh];
}
