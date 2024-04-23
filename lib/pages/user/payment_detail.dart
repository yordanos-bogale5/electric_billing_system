import 'package:flutter/material.dart';

class PaymentDetailsScreen extends StatelessWidget {
  final String name;
  final String mobileNumber;
  final String serviceNumber;
  final String accountNumber;

  PaymentDetailsScreen({
    required this.name,
    required this.mobileNumber,
    required this.serviceNumber,
    required this.accountNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Details'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
  'Payment Information:',
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
const SizedBox(height: 10),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Row(
      children: [
        const Text('Month: '),
        Text('04/24', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
    Row(
      children: [
        const Text('Amount: '),
        Text('600 Birr', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
    Row(
      children: [
        const Text('Due Date: '),
        Text('15/05/24', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  ],
),
const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Payment'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Are you sure you want to proceed with the payment?'),
                            const SizedBox(height: 20),
                            Image.asset('assets/chapa.png', width: 100, height: 100),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Add functionality to pay
                            },
                            child: const Text('Pay with Chapa'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text('Pay', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
