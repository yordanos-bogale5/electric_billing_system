import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmpCrudOps extends StatefulWidget {
  const EmpCrudOps({Key? key}) : super(key: key);

  @override
  State<EmpCrudOps> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EmpCrudOps> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _snController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _items = [];
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? items = prefs.getString('employees');
    if (items != null) {
      setState(() {
        _items = List<Map<String, dynamic>>.from(json.decode(items));
      });
    }
  }

  Future<void> _saveItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('employees', json.encode(_items));
  }

  Future<void> _create([Map<String, dynamic>? item]) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        if (item != null) {
          _nameController.text = item['name'];
          _fatherNameController.text = item['fatherName'];
          _emailController.text = item['email'];
          _passwordController.text = item['password'];
          _addressController.text = item['address'];
          _salaryController.text = item['salary'];
          _roleController.text = item['role'];
          _snController.text = item['sn'].toString();
          _numberController.text = item['number'].toString();
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    item == null ? "Add Employee" : "Update Employee",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                _buildTextField(_nameController, 'Name', 'eg.Yordanos'),
                _buildTextField(_fatherNameController, 'Father Name', 'eg.Bogale'),
                _buildTextField(_emailController, 'Email', 'eg.yordanos@gmail.com'),
                _buildTextField(_passwordController, 'Password', 'eg.******'),
                _buildTextField(_addressController, 'Address', 'eg.Bole'),
                _buildTextField(_salaryController, 'Salary', 'eg.20000'),
                _buildTextField(_roleController, 'Role', 'eg.Bill oficer'),
                _buildTextField(_snController, 'S.N', 'eg.001', keyboardType: TextInputType.number),
                _buildTextField(_numberController, 'Number', 'eg.10', keyboardType: TextInputType.number),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final String name = _nameController.text;
                      final String fatherName = _fatherNameController.text;
                      final String email = _emailController.text;
                      final String password = _passwordController.text;
                      final String address = _addressController.text;
                      final String salary = _salaryController.text;
                      final String role = _roleController.text;
                      final int? sn = int.tryParse(_snController.text);
                      final int? number = int.tryParse(_numberController.text);

                      if (name.isNotEmpty && number != null && sn != null) {
                        if (item == null) {
                          setState(() {
                            _items.add({
                              "name": name,
                              'fatherName': fatherName,
                              'email': email,
                              'password': password,
                              'address': address,
                              'salary': salary,
                              'role': role,
                              "number": number,
                              "sn": sn,
                            });
                          });
                        } else {
                          setState(() {
                            final index = _items.indexOf(item);
                            _items[index] = {
                              "name": name,
                              'fatherName': fatherName,
                              'email': email,
                              'password': password,
                              'address': address,
                              'salary': salary,
                              'role': role,
                              "number": number,
                              "sn": sn,
                            };
                          });
                        }
                        _saveItems();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(item == null ? "Create" : "Update"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
    );
  }

  Future<void> _delete(Map<String, dynamic> item) async {
    setState(() {
      _items.remove(item);
    });
    _saveItems();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("You have successfully deleted an employee")),
    );
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  bool isSearchClicked = false;

  @override
  Widget build(BuildContext context) {
    final filteredItems = _items.where((item) {
      return item['name'].toLowerCase().contains(searchText.toLowerCase());
    }).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: isSearchClicked
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                      hintText: 'Search..'),
                ),
              )
            : const Text('Employee Management'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearchClicked = !isSearchClicked;
                });
              },
              icon: Icon(isSearchClicked ? Icons.close : Icons.search))
        ],
      ),
      body: filteredItems.isEmpty
          ? Center(
              child: Text("No employees found."),
            )
          : ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item =  filteredItems[index];
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.grey,
                      child: Text(
                        item['sn'].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    title: Text(
                      item['name'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    subtitle: Text(
                      item['fatherName'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              color: Colors.black,
                              onPressed: () => _create(item),
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              color: Colors.black,
                              onPressed: () => _delete(item),
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        backgroundColor: const Color.fromARGB(255, 88, 136, 190),
        child: const Icon(Icons.add),
      ),
    );
  }
}
