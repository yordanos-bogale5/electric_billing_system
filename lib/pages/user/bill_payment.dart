import 'package:flutter/material.dart';

import 'payment_detail.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({Key? key}) : super(key: key);

  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();


  bool _isSelfSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Bill'),
      ),
      body: SingleChildScrollView(
     child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pay Bill For',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('For Self'),
                    leading: Radio(
                      value: true,
                      groupValue: _isSelfSelected,
                      onChanged: (value) {
                        setState(() {
                          _isSelfSelected = value as bool;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('For Others'),
                    leading: Radio(
                      value: false,
                      groupValue: _isSelfSelected,
                      onChanged: (value) {
                        setState(() {
                          _isSelfSelected = value as bool;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _mobileController,
              decoration: const InputDecoration(
                labelText: 'Reference Number',
              ),
            ),
            if (!_isSelfSelected) ...[
              // const SizedBox(height: 20),
              // TextField(
              //   controller: _serviceNumberController,
              //   decoration: const InputDecoration(
              //     labelText: 'Reference Number',
              //   ),
              // ),
              // const SizedBox(height: 20),
              // TextField(
              //   controller: _accountNumberController,
              //   decoration: const InputDecoration(
              //     labelText: 'Account Number',
              //   ),
              // ),
            ],
            const SizedBox(height: 20),
                    SizedBox(
              width: double.infinity, // Make the button width to fill the available space
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the next screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentDetailsScreen (name: '', mobileNumber: '', serviceNumber: '', accountNumber: '',),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, 
                  foregroundColor: Colors.white,
                ),
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

