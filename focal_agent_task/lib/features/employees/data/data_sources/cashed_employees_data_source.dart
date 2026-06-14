import 'dart:convert';

import 'package:focal_agent_task/core/constants/shared_preferences_keys.dart';
import 'package:focal_agent_task/core/services/shared_pref_service.dart';

import '../../../../core/error/exceptions.dart';
import '../models/employee_model.dart';

abstract class CashedEmployeesDataSource {
  Future<List<EmployeeModel>?> getCachedEmployees();

  Future<void> cacheEmployees(List<EmployeeModel> employees);
}

class CashedEmployeesDataSourceImp implements CashedEmployeesDataSource {
  List<EmployeeModel>? _cachedEmployees;

  @override
  Future<List<EmployeeModel>?> getCachedEmployees() async {
    try {
      final cashedTextEmployees = await SharedPreferencesService.get(
        SharedPreferencesKeys.employees,
      );
      if (cashedTextEmployees == null) {
        return null;
      }
      if (cashedTextEmployees.isNotEmpty) {
        List<dynamic> jsonList = jsonDecode(cashedTextEmployees);
        _cachedEmployees = jsonList
            .map((item) => EmployeeModel.fromJson(item))
            .toList();
        return _cachedEmployees;
      } else {
        return [];
      }
    } catch (e) {
      throw CacheException('Error Get Cached Employees Data');
    }
  }

  @override
  Future<void> cacheEmployees(List<EmployeeModel> employees) async {
    _cachedEmployees = employees;
    try {
      final jsonEmployees = jsonEncode(
        employees.map((u) => u.toJson()).toList(),
      );
      await SharedPreferencesService.saveData(
        key: SharedPreferencesKeys.employees,
        value: jsonEmployees,
      );
    } catch (e) {
      throw CacheException('Error Cache Employees Data');
    }
  }
}
