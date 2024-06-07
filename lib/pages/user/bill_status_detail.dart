import 'package:flutter/material.dart';
import 'user.dart';

class BillStatusScreen extends StatelessWidget {
  final List<Users> users;
  final double billAmount;

  BillStatusScreen({required this.users, required this.billAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Iterate over the users list to display each user's name
            for (var user in users)
              Text('Name: ${user.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const Text('Reference Number: 123456', style: TextStyle(fontSize: 18)), // Assuming the reference number is static
            const SizedBox(height: 10),
            Text('Bill Amount: \$${billAmount}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press here
                },
                child: const Text('Proceed to Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
