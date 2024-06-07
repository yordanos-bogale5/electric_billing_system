import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ViewComplain extends StatelessWidget {
  final String customerId;
  final String complaintLevel;
  final String complaintType;
  final String description;
  final List<PlatformFile> attachments;

  const ViewComplain({
    Key? key,
    required this.customerId,
    required this.complaintLevel,
    required this.complaintType,
    required this.description,
    required this.attachments,
  }) : super(key: key);

  Widget _buildAttachmentList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: attachments.length,
      itemBuilder: (context, index) {
        final file = attachments[index];
        return ListTile(
          title: Text(file.name),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Complaint'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer ID: $customerId',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Complaint Level: $complaintLevel',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Complaint Type: $complaintType',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Attachments:',
              style: TextStyle(fontSize: 18),
            ),
            _buildAttachmentList(),
          ],
        ),
      ),
    );
  }
}
