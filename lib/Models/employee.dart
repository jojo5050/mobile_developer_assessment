import 'package:hive/hive.dart';

part 'employee.g.dart';

@HiveType(typeId: 0)
class Employee {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String designation;

  @HiveField(4)
  final int level;

  @HiveField(5)
  final double productivityScore;

  @HiveField(6)
  final String currentSalary;

  @HiveField(7)
  final int employmentStatus;

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.designation,
    required this.level,
    required this.productivityScore,
    required this.currentSalary,
    required this.employmentStatus,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      designation: json['designation'],
      level: json['level'],
      productivityScore: json['productivity_score'],
      currentSalary: json['current_salary'],
      employmentStatus: json['employment_status'],
    );
  }
}