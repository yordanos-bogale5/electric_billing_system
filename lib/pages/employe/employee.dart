import 'package:billing_sytem/pages/auth/log_in.dart';
import 'package:billing_sytem/pages/user/bill_status_detail.dart';
import 'package:flutter/material.dart';



class Users {
  final String name;
  double billAmount;
  bool isPaid;

  Users({required this.name, required this.billAmount, this.isPaid = false});
}

class EmployeeDashboardScreen extends StatefulWidget {
  @override
  _EmployeeDashboardScreenState createState() => _EmployeeDashboardScreenState();
}

class _EmployeeDashboardScreenState extends State<EmployeeDashboardScreen> {
  List<Users> users = [
    Users(name: 'Tadele Roba', billAmount: 100.0),
    Users(name: 'Amare Mamo', billAmount: 150.0),
    Users(name: 'Minalu Mesele', billAmount: 200.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Dashboard'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Log out'),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Dashboard Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: const Text('Add Bill Price'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddBillPriceScreen(users: users)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: const Text('View Users List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewUsersListScreen(users: users)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.report),
              title: const Text('Prepare Bill Reports'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrepareReportsScreen(users: users)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.check),
              title: const Text('Paid Users List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaidUsersListScreen(users: users)),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Welcome to Employee Dashboard'),
      ),
    );
  }
}

class AddBillPriceScreen extends StatefulWidget {
  final List<Users> users;

  AddBillPriceScreen({required this.users});

  @override
  _AddBillPriceScreenState createState() => _AddBillPriceScreenState();
}

class _AddBillPriceScreenState extends State<AddBillPriceScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedUser;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bill Price'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Select User'),
                value: _selectedUser,
                items: widget.users.map((user) {
                  return DropdownMenuItem<String>(
                    value: user.name,
                    child: Text(user.name),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedUser = value;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a user';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Bill Amount'),
                keyboardType: TextInputType.number,
                onSaved: (String? value) {
                  _billAmount = double.parse(value ?? '0');
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a bill amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final selectedUser =
                        widget.users.firstWhere((user) => user.name == _selectedUser);
                    selectedUser.billAmount = _billAmount;
     Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => BillStatusScreen(users: [], billAmount: 9,
    ),
  ),
);


                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewUsersListScreen extends StatelessWidget {
  final List<Users> users;

  ViewUsersListScreen({required this.users});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Users List'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].name),
            subtitle: Text('Bill Amount: \$${users[index].billAmount.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}

class PrepareReportsScreen extends StatelessWidget {
  final List<Users> users;

  PrepareReportsScreen({required this.users});

  @override
  Widget build(BuildContext context) {
    double totalBills = users.fold(0, (sum, user) => sum + user.billAmount);
    int paidUsersCount = users.where((user) => user.isPaid).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prepare Bill Reports'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Total Bill Amount: \$${totalBills.toStringAsFixed(2)}'),
            Text('Number of Paid Users: $paidUsersCount'),
            // You can add more report details here
          ],
        ),
      ),
    );
  }
}

class PaidUsersListScreen extends StatelessWidget {
  final List<Users> users;

  PaidUsersListScreen({required this.users});

  @override
  Widget build(BuildContext context) {
    List<Users> paidUsers = users.where((user) => user.isPaid).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paid Users List'),
      ),
      body: ListView.builder(
        itemCount: paidUsers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(paidUsers[index].name),
            subtitle: Text('Bill Amount: \$${paidUsers[index].billAmount.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
