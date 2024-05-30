import 'package:flutter/material.dart';
import 'package:chapa_unofficial/chapa_unofficial.dart';
//import 'selection_screen.dart'; // Make sure to create this screen

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

  Future<void> _startPayment(BuildContext context) async {
    try {
      String txRef = TxRefRandomGenerator.generate(prefix: 'BillingSystem');
      String? paymentUrl = await Chapa.getInstance.startPayment(
        context: context,
        onInAppPaymentSuccess: (successMsg) {
          // Handle success events
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const SelectionScreen()),
          // );
        },
        onInAppPaymentError: (errorMsg) {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
        },
        amount: '1000',
        currency: 'ETB',
        txRef: txRef,
      );
    } on ChapaException catch (e) {
      // Handle specific exceptions
      String errorMsg = '';
      if (e is AuthException) {
        errorMsg = 'Authentication error';
      } else if (e is InitializationException) {
        errorMsg = 'Initialization error';
      } else if (e is NetworkException) {
        errorMsg = 'Network error';
      } else if (e is ServerException) {
        errorMsg = 'Server error';
      } else {
        errorMsg = 'Unknown error';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
    }
  }

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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Month: '),
                    Text('04/24', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    Text('Amount: '),
                    Text('600 Birr', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    Text('Due Date: '),
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
                              Navigator.of(context).pop(); // Close the dialog
                              _startPayment(context); // Start the payment process
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
            const SizedBox(height: 20),
            GestureDetector(
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => const SelectionScreen()),
              //   );
              // },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      '',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
