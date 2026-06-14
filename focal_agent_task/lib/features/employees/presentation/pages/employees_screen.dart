import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/sizes/ui_sizes.dart';
import '../../domain/entities/employee.dart';
import '../../domain/enums/employee_category.dart';
import '../bloc/employees_bloc.dart';
import '../widgets/employee_card.dart';
import '../widgets/error_widget.dart';

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final employeesBloc = context.read<EmployeesBloc>();
    final categories = EmployeeCategory.values.where(
      (employeeCategory) => employeeCategory != EmployeeCategory.none,
    );
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Employees'),
          actions: [
            BlocBuilder<EmployeesBloc, EmployeesState>(
              buildWhen: (prev, curr) =>
                  (prev is EmployeesLoading) != (curr is EmployeesLoading),
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.refresh_rounded),
                  tooltip: 'Refresh',
                  onPressed: state is EmployeesLoading
                      ? null
                      : () => employeesBloc.add(
                          LoadEmployeesEvent(forceRefresh: true),
                        ),
                );
              },
            ),
          ],
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.primary,
            indicatorColor: Theme.of(context).colorScheme.primary,
            tabs: categories.map((c) => Tab(text: c.text)).toList(),
          ),
        ),
        body: TabBarView(
          children: categories.map((category) {
            return _EmployeesBody(employeeCategory: category);
          }).toList(),
        ),
      ),
    );
  }
}

class _EmployeesBody extends StatelessWidget {
  final EmployeeCategory employeeCategory;

  const _EmployeesBody({required this.employeeCategory});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeesBloc, EmployeesState>(
      builder: (context, state) {
        return switch (state) {
          EmployeesInitial() || EmployeesLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          EmployeesError(:var message) => ErrorView(
            message: message,
            onRetry: () =>
                context.read<EmployeesBloc>().add(LoadEmployeesEvent()),
          ),
          EmployeesLoaded(:var employees) => _EmployeeList(
            employees: employees,
            employeeCategory: employeeCategory,
          ),
        };
      },
    );
  }
}

class _EmployeeList extends StatelessWidget {
  final List<Employee> employees;
  final EmployeeCategory employeeCategory;

  const _EmployeeList({
    required this.employees,
    required this.employeeCategory,
  });

  @override
  Widget build(BuildContext context) {
    final categoryEmployees = employees
        .where((e) => e.category == employeeCategory)
        .toList();
    if (categoryEmployees.isEmpty) {
      return const Center(child: Text('No employees in this department.'));
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: UISizes.defaultHorizontalPadding,
        vertical: UISizes.defaultVerticalPadding,
      ),
      itemCount: categoryEmployees.length,
      separatorBuilder: (_, index) =>
          SizedBox(height: UISizes.employeesListSpace),
      itemBuilder: (_, index) =>
          EmployeeCard(employee: categoryEmployees[index]),
    );
  }
}
