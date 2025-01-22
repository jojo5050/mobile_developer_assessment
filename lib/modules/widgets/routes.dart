import 'package:employee_inventory/modules/details/presentation/details_screen.dart';
import 'package:employee_inventory/modules/home/presentation/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/employee.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print("..............Navigating to: ${settings.name}, Arguments: ${settings.arguments}");
  switch (settings.name) {
    case '/employee_details':
      final employee = settings.arguments as Employee?;
      if (employee == null) {
        print("............Error: Employee data is NULL!");
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("Error: Employee data is missing!")),
          ),
        );
      }

      return MaterialPageRoute(
        builder: (_) => EmployeeDetailsScreen(employee: employee),
      );

    default:
      return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text("404: Page Not Found"))));
  }
}