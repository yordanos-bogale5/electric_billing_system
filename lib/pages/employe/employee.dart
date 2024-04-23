import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('employee Dashboard'),
      ),
      body: const Center(
        child: Text('Welcome to employee Dashboard'),
      ),
    );
  }
}
