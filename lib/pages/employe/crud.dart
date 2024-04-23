import 'package:flutter/material.dart';

class EmployeeCrudOps extends StatefulWidget {
  const EmployeeCrudOps({Key? key}) : super(key: key);

  @override
  State<EmployeeCrudOps> createState() => _EmployeeCrudOpsState();
}

class _EmployeeCrudOpsState extends State<EmployeeCrudOps> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  List<Map<String, String>> _employees = [];

  void _create() {
    setState(() {
      _employees.add({
        'firstname': _firstnameController.text,
        'lastName': _lastNameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
      });
    });

    _clearControllers();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Employee created successfully")),
    );
  }

  void _clearControllers() {
    _firstnameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Management'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Employee',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _firstnameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                hintText: 'eg. Daniel',
              ),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                hintText: 'eg. Kebede',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'eg. yordanos@gmail.com',
              ),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone No',
                hintText: 'eg. +251-9XX-XXX-XXX',
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _create,
                child: const Text("Create"),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Employee List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _employees.length,
              itemBuilder: (context, index) {
                final employee = _employees[index];
                return ListTile(
                  title: Text('${employee['firstname']} ${employee['lastName']}'),
                  subtitle: Text(employee['email']!),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _employees.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
