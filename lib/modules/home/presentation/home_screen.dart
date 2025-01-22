import 'dart:math';

import 'package:employee_inventory/modules/details/presentation/details_screen.dart';
import 'package:employee_inventory/modules/widgets/button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../Models/employee.dart';
import '../../../common/io/data.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.employees}) : super(key: key);
  final List<Employee> employees;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool hasError = false;
  late List<dynamic> employees;
  TextEditingController searchController = TextEditingController();
  late Box<Employee> employeeBox;
  String selectedFilter = "Name";
  List<Employee> filteredEmployees = [];

  var errMessage;

  @override
  void initState() {
    super.initState();
    // uncomment this method "fetchEmployeesForSimulation()" to test api error simulation
  //  fetchEmployeesForSimulation();
    employeeBox = Hive.box<Employee>('employees');
    filteredEmployees = widget.employees;

  }


  void filterEmployees(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredEmployees = widget.employees;
      } else {
        filteredEmployees = widget.employees.where((employee) {
          switch (selectedFilter) {
            case "Name":
              return (employee.firstName + " " + employee.lastName)
                  .toLowerCase()
                  .contains(query.toLowerCase());
            case "Designation":
              return employee.designation.toLowerCase().contains(query.toLowerCase());
            case "Level":
              return employee.level.toString() == query;
            default:
              return true;
          }
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Employees")),
      body:
      hasError
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 50),
              SizedBox(height: 10),
              Text(
                "${errMessage}",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
              SizedBox(height: 10),
                   AppButton(
                     onTap: (){
                       setState(() {
                         hasError = false;
                       });
                       fetchEmployeesForSimulation();
                     },
                     buttonText: 'Try Again',)
            ],
          ),
        ),
      ):
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: "Search",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => filterEmployees(value),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedFilter,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFilter = newValue!;
                    });
                  },
                  items: ["Name", "Designation", "Level"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredEmployees.length,
              itemBuilder: (context, index) {

                final employee = filteredEmployees[index];
                print("printing employee index as.......$employee");
                return Card(
                  elevation: 4,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),),
                  child: ListTile(
                    title: Text("${employee.firstName} ${employee.lastName}"),
                    subtitle: Text("Designation: ${employee.designation} | Level: ${employee.level}"),
                    onTap: () {
                      print("taped........");
                      print("printing taped index as.......$employee");
                      Navigator.pushNamed(context, '/employee_details', arguments: employee);
                  
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void fetchEmployeesForSimulation() {
    setState(() {
      hasError = false;
    });

    Future.delayed(Duration(seconds: 2), () {
      final response = Api.errorResponse;

      if (response["status"] == "error") {
        setState(() {
          hasError = true;
        });
        errMessage = response["message"];
        print("printing..............error message as $errMessage");
      } else {

        final responseData = Api.successResponse['data'] as List;
        employees = responseData.map((e) => Employee.fromJson(e)).toList();
        setState(() {});
      }
    });
  }
}


