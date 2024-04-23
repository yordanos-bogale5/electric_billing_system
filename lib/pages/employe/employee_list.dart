// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print

import 'package:billing_sytem/pages/employe/add_employee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Employee {
  final String id;
  String name;
  String fathersName;
  String role;
  String address;
  double salary;

 Employee({
    required this.id,
    required this.name,
    required this.fathersName,
    required this.role,
    required this.address,
    required this.salary,
  });
}

class EmployeeList {
  final String id;
  final String name;
  final String email;
  final String address;
  final double salary;
  final String role;

  EmployeeList({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.salary,
    required this.role,
  });
}

class EmployeList extends StatefulWidget {
  @override
  _EmployeListState createState() => _EmployeListState();
}

class _EmployeListState extends State<EmployeList> {
  late List<EmployeeList> _loadedEmployees;

  @override
  void initState() {
    super.initState();
    _loadedEmployees = [];
    _loadEmployees();
  }
void _loadEmployees() async {
  final url = Uri.https(
      'https://electric-billing-system-4356f-default-rtdb.firebaseio.com/', 'Add-Employee.json');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? listData = json.decode(response.body);
      final List<EmployeeList> loadedItems = [];

      if (listData != null) {
        listData.forEach((id,  employeesData) {
          loadedItems.add(
            EmployeeList(
              id: id,
              name: employeesData['name'],
              email:  employeesData['email'],
              address:  employeesData['address'],
              salary:  employeesData['salary'],
              role:  employeesData['role'],
            ),
          );
        });

        setState(() {
          _loadedEmployees = loadedItems;
        });
      } else {
        print('Firebase data is empty.');
      }
    } else {
      print('Failed to fetch instructors: ${response.statusCode}');
    }
  } catch (error) {
    print('Error loading instructors: $error');
  }
}


  void _addEmployees(BuildContext context) async {
    final result = await Navigator.of(context).push<EmployeeList>(
      MaterialPageRoute(
        builder: (ctx) => const AddEmployee( key: Key(' AddEmployees '),),
      ),
    );

    if (result != null) {
      _loadEmployees();
    }
  }

 void _updateEmployees(EmployeeList employees) async {
  final url = Uri.https(
      'https://electric-billing-system-4356f-default-rtdb.firebaseio.com/',
      'Add-Employees/${employees.id}.json');

  final response = await http.patch(
    url,
    body: json.encode({
      'name': 'Updated ${employees.name}',
      'salary': employees.salary + 5000.0,
    }),
  );

  if (response.statusCode == 200) {
    // Update the local state if the server update is successful
    setState(() {
      _loadedEmployees= [
        ..._loadedEmployees.where((item) => item.id != employees.id),
        EmployeeList(
          id: employees.id,
          name: 'Updated ${employees.name}',
          email: employees.email,
          address: employees.address,
          salary: employees.salary + 5000.0,
          role: employees.role,
        ),
      ];
    });
  } else {
    // Handle error scenario
    print('Failed to update employees: ${response.statusCode}');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EmployeesList'),
      ),
      body: ListView.builder(
        itemCount: _loadedEmployees.length,
        itemBuilder: (context, index) {
          final employees = _loadedEmployees[index];
          return ListTile(
            title: Text('ID: ${employees.id} | ${employees.name}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${employees.email}'),
                Text('Address: ${employees.address}'),
                Text('Salary: \$${employees.salary}'),
                Text('Role: ${employees.role}'),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                _updateEmployees(employees);
              },
              child: const Text('Update'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEmployees(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

