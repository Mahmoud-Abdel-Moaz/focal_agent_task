import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/employee.dart';
import '../../domain/use_cases/get_employees.dart';

part 'employees_event.dart';

part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  final GetAllEmployees _getAllEmployees;

  EmployeesBloc(this._getAllEmployees) : super(EmployeesInitial()) {
    on<LoadEmployeesEvent>((event, emit) async {
      emit(EmployeesLoading());
      final result = await _getAllEmployees(forceRefresh: event.forceRefresh);
      result.fold((failure) => emit(EmployeesError(failure.message)), (
        employees,
      ) {
        emit(EmployeesLoaded(employees));
      });
    });
  }
}
