// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key});

  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  List<Map<String, String>> instructors = [];
  late String firstName;
  late String lastName;
  late String email;
  late String address;
  late String password;
  late String salary;
  late String role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Open a dialog to add a new course
              _showAddInstrDialog(context);
            },
            child: const Text('Add Employee'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: instructors.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Instructors ${index + 1}'),
                  subtitle: Text(
                    'Employee Name: ${instructors[index]['Employee name']} | '
                        'Father Name: ${instructors[index]['father name']} | '
                        'Email: ${instructors[index]['email']} | '
                        'Password: ${instructors[index]['password']} | '
                        'Address: ${instructors[index]['address']} |  '
                        'Salary: ${instructors[index]['salary']} | '
                        'Role: ${instructors[index]['role']}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddInstrDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Employee'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Employee Name'),
                  onChanged: (value) {
                    firstName = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Father Name'),
                  onChanged: (value) {
                    lastName = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Address'),
                  onChanged: (value) {
                    address = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Salary'),
                  onChanged: (value) {
                    salary = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Role'),
                  onChanged: (value) {
                    role = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add the instructor to the list
                setState(() {
                  instructors.add({
                    'Instructor name': firstName,
                    'father name': lastName,
                    'email': email,
                    'address': address,
                    'password': password,
                    'salary': salary,
                    'role': role,
                  });
                });

                // Send data to the server
                final url = Uri.https(
                  'https://electric-billing-system-4356f-default-rtdb.firebaseio.com/',
                  'employees.json',
                );
                http.post(
                  url,
                  headers: {
                    'Content-Type': 'application/json',
                  },
                  body: json.encode({
                    'Employees name': firstName,
                    'father name': lastName,
                    'email': email,
                    'address': address,
                    'password': password,
                    'salary': salary,
                    'role': role,
                  }),
                );

                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}