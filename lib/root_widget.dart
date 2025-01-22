import 'package:flutter/material.dart';

import 'Models/employee.dart';
import 'common/io/data.dart';
import 'modules/home/presentation/home_screen.dart';
import 'modules/widgets/routes.dart';


class MobileAssessmentApp extends StatefulWidget {
  final bool isDebug;
  const MobileAssessmentApp({Key? key, this.isDebug = true}) : super(key: key);


  @override
  State<MobileAssessmentApp> createState() => _MobileAssessmentAppState();
}

class _MobileAssessmentAppState extends State<MobileAssessmentApp> {

  List<Employee> employees = [];

  @override
  void initState() {
    super.initState();

    fetchEmployees();// comment this method to test Api error response
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: widget.isDebug,
      home: HomeScreen(employees: employees),
      onGenerateRoute: generateRoute,
    );
  }

  void fetchEmployees() {

    final responseData = Api.successResponse['data'] as List;
    employees = responseData.map((e) => Employee.fromJson(e)).toList();
    setState(() {});
  }
}
