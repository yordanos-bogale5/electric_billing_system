import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _kebeleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bankaccountController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();

  final TextEditingController _searchController = TextEditingController();

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('employees');

  String searchText = '';

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
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
                const Center(
                  child: Text(
                    "Add Employee",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
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
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'eg. ******',
                  ),
                ),
                TextField(
                  controller: _kebeleController,
                  decoration: const InputDecoration(
                    labelText: 'Kebele',
                    hintText: 'eg. 1111/09',
                  ),
                ),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    hintText: 'eg. Bole',
                  ),
                ),
                TextField(
                  controller: _serviceController,
                  decoration: const InputDecoration(
                    labelText: 'Residential',
                    hintText: 'eg. Bole',
                  ),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone No',
                    hintText: 'eg. +251-9XX-XXX-XXX',
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _bankaccountController,
                  decoration: const InputDecoration(
                    labelText: 'Bank Account',
                    hintText: 'eg. 10129794887',
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _houseController,
                  decoration: const InputDecoration(
                    labelText: 'House No',
                    hintText: 'eg. 1',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final String firstname = _firstnameController.text;
                      final String lastName = _lastNameController.text;
                      final String email = _emailController.text;
                      final String password = _passwordController.text;
                      final String kebele = _kebeleController.text;
                      final String address = _addressController.text;
                      final String service = _serviceController.text;
                      final String phone = _phoneController.text;
                      final String bankaccount = _bankaccountController.text;
                      final String house = _houseController.text;

                      await _items.add({
                        "firstname": firstname,
                        'lastName': lastName,
                        'email': email,
                        'password': password,
                        'kebele': kebele,
                        'address': address,
                        'service': service,
                        'phone': phone,
                        "bankaccount": bankaccount,
                        "house": house,
                      });

                      _firstnameController.text = '';
                      _lastNameController.text = '';
                      _emailController.text = '';
                      _passwordController.text = '';
                      _kebeleController.text = '';
                      _addressController.text = '';
                      _serviceController.text = '';
                      _phoneController.text = '';
                      _bankaccountController.text = '';
                      _houseController.text = '';

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Employee created successfully"),
                      ));

                      Navigator.of(context).pop();
                    },
                    child: const Text("Create"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _firstnameController.text = documentSnapshot['firstname'];
      _lastNameController.text = documentSnapshot['lastName'];
      _emailController.text = documentSnapshot['email'];
      _passwordController.text = documentSnapshot['password'];
      _kebeleController.text = documentSnapshot['kebele'];
      _addressController.text = documentSnapshot['address'];
      _serviceController.text = documentSnapshot['service'];
      _phoneController.text = documentSnapshot['phone'];
      _bankaccountController.text = documentSnapshot['bankaccount'];
      _houseController.text = documentSnapshot['house'];
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
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
                const Center(
                  child: Text(
                    "Update employee info",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
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
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'eg. ******',
                  ),
                ),
                TextField(
                  controller: _kebeleController,
                  decoration: const InputDecoration(
                    labelText: 'Kebele',
                    hintText: 'eg. 1111/09',
                  ),
                ),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    hintText: 'eg. Bole',
                  ),
                ),
                TextField(
                  controller: _serviceController,
                  decoration: const InputDecoration(
                    labelText: 'Residential',
                    hintText: 'eg. Bole',
                  ),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone No',
                    hintText: 'eg. +251-9XX-XXX-XXX',
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _bankaccountController,
                  decoration: const InputDecoration(
                    labelText: 'Bank Account',
                    hintText: 'eg. 10129794887',
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _houseController,
                  decoration: const InputDecoration(
                    labelText: 'House No',
                    hintText: 'eg. 1',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String firstname = _firstnameController.text;
                    final String lastName = _lastNameController.text;
                    final String email = _emailController.text;
                    final String password = _passwordController.text;
                    final String kebele = _kebeleController.text;
                    final String address = _addressController.text;
                    final String service = _serviceController.text;
                    final String phone = _phoneController.text;
                    final String bankaccount = _bankaccountController.text;
                    final String house = _houseController.text;

                    await _items
                        .doc(documentSnapshot!.id)
                        .update({
                      "firstname": firstname,
                      'lastName': lastName,
                      'email': email,
                      'password': password,
                      'kebele': kebele,
                      'address': address,
                      'service': service,
                      'phone': phone,
                      "bankaccount": bankaccount,
                      "house": house,
                    });

                    _firstnameController.text = '';
                    _lastNameController.text = '';
                    _emailController.text = '';
                    _passwordController.text = '';
                    _kebeleController.text = '';
                    _addressController.text = '';
                    _serviceController.text = '';
                    _phoneController.text = '';
                    _bankaccountController.text = '';
                    _houseController.text = '';

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Employee updated successfully"),
                    ));

                    Navigator.of(context).pop();
                  },
                  child: const Text("Update"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _delete(String productID) async {
    await _items.doc(productID).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Employee deleted successfully"),
    ));
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  bool isSearchClicked = false;

  @override
  Widget build(BuildContext context) {
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
      body: StreamBuilder(
        stream: _items.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            final List<DocumentSnapshot> items = streamSnapshot.data!.docs
                .where((doc) => doc['firstname'].toLowerCase().contains(
              searchText.toLowerCase(),
            ))
                .toList();
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot = items[index];
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
                          documentSnapshot['phone'].toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      title: Text(
                        documentSnapshot['firstname'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Text(
                        documentSnapshot['lastName'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                color: Colors.black,
                                onPressed: () => _update(documentSnapshot),
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                color: Colors.black,
                                onPressed: () => _delete(documentSnapshot.id),
                                icon: const Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        backgroundColor: const Color.fromARGB(255, 88, 136, 190),
        child: const Icon(Icons.add),
      ),
    );
  }
}
