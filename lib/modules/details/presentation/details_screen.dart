import 'package:employee_inventory/Models/employee.dart';
import 'package:flutter/material.dart';

import '../../widgets/button/app_button.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final Employee employee;
  const EmployeeDetailsScreen({Key? key, required this.employee}) : super(key: key);

  @override
  _EmployeeDetailsScreenState createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late String employmentStatus;
  late String newSalary;

  @override
  void initState() {
    super.initState();
    employmentStatus = getEmploymentStatus(widget.employee);
    newSalary = getNewSalary(widget.employee);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Employee Details")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.employee.firstName} ${widget.employee.lastName}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Designation: ${widget.employee.designation}"),
            Text("Productivity Score: ${widget.employee.productivityScore}"),
            Text("Current Salary: ${widget.employee.currentSalary}"),
            Text("Employment Status: $employmentStatus"),
            Text("New Salary (after raise): $newSalary"),
            SizedBox(height: 20),
            Text(
              "New Status: $employmentStatus",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            Text(
              "New Salary: $newSalary",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 10,),
            widget.employee.level == 0
                ? AppButton(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Employee terminated successfully")),
                );
              },
              buttonText: "Terminate",
              isPrimary: true,
            )
                : Column(
              children: [
                AppButton(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Employe Demoted successfully")),
                    );
                  },
                  buttonText: "Demote",
                  isPrimary: false,
                ),
                SizedBox(height: 10),
                AppButton(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Employee terminated successfully")),
                    );
                  },
                  buttonText: "Terminate",
                  isPrimary: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  String getEmploymentStatus(Employee employee) {
    double score = employee.productivityScore;
    int level = employee.level;
    if (score >= 80) return "Promoted";
    if (score >= 50) return "No Change";
    if (score >= 40) return (level == 0) ? "Terminated" : "Demoted";
    return "Terminated";
  }


  String getNewSalary(Employee employee) {

    int level = employee.level;
    String employmentStatus = getEmploymentStatus(employee);

    Map<int, String> salaryLevels = {
      0: "70,000",
      1: "100,000",
      2: "120,000",
      3: "180,000",
      4: "200,000",
      5: "250,000",
    };

    if (employmentStatus == "Promoted" && level < 5) return salaryLevels[level + 1]!;
    if (employmentStatus == "Demoted" && level > 0) return salaryLevels[level - 1]!;
    return salaryLevels[level]!;
  }

}