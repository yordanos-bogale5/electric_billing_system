import 'package:flutter/material.dart';
import 'package:chapa_unofficial/chapa_unofficial.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  Future<void> _startPayment(BuildContext context) async {
    try {
      String txRef = TxRefRandomGenerator.generate(prefix: 'Pharmabet');
      String? paymentUrl = await Chapa.getInstance.startPayment(
        context: context,
        onInAppPaymentSuccess: (successMsg) {
          // Handle success events
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaymentSuccessScreen()),
          );
        },
        onInAppPaymentError: (errorMsg) {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Payment failed: $errorMsg')));
        },
        amount: '1000',
        currency: 'ETB',
        txRef: txRef,
      );
    } on ChapaException catch (e) {
      // Handle exceptions
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } catch (e) {
      // Handle any other exceptions
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'HP 14 Laptop, Intel Celeron N4020, 4 GB RAM, 64 GB Storage, 14-inch Micro-edge HD Display, Windows 11 Home, Thin & Portable, 4K Graphics, One Year of Microsoft 365 (14-dq0040nr, Snowflake White)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                Text(
                  '3.9',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  ' 1,350',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const Text(
              'HP 14 Laptop Description...',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Image.network('https://th.bing.com/th/id/R.196920a00ae01fd85ecca3135fa6ee22?rik=DiPAW76Ps1GUgw&pid=ImgRaw&r=0'),
                  Image.network('https://cdn.mos.cms.futurecdn.net/gBeu6qgL4pc8K7HEjw4Kok.jpg'),
                  Image.network('https://microless.com/cdn/products/6da67d70a7dfb260ce8e47a3b14e05db-hi.jpg'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _startPayment(context),
                  icon: const Icon(Icons.rotate_left_rounded),
                  label: const Text('VIEW IN 3D'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Success'),
      ),
      body: Center(
        child: const Text('Your payment was successful!'),
      ),
    );
  }
}
