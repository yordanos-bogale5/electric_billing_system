import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ComplainScreen extends StatefulWidget {
  const ComplainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ComplainScreenState createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
  List<PlatformFile>? _files = [];
  final _formKey = GlobalKey<FormState>();
  final _contactNumberController = TextEditingController();

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        setState(() {
          _files!.addAll(result.files);
        });
      }
    } catch (e) {
      print('Error picking files: $e');
    }
  }

  Widget _buildFileList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _files!.length,
      itemBuilder: (context, index) {
        final file = _files![index];
        return ListTile(
          title: Text(file.name),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _files!.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _contactNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File a Complaint'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'New Complaint Request',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Get started by filling in the information below to create your new complaint request.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '* Required Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Full Name / ሙሉ ስም',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Contact Number / ስልክ ቁጥር',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
               Row(
                  children: [
                  
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _contactNumberController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                          prefixText: '+251',
                          prefixStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              const Text(
                'Email / ኢሚል',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Dispute Number / ቅሬታ የሚጠይቁበት ቁጥር',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Account Number / የክፍያ ቁጥር',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Complaint Type / የቅሬታ ዓይነት',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButtonFormField<String>(
                items: <String>['Complaint 1', 'Complaint 2', 'Complaint 3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {},
                // Add functionality to handle complaint type selection
              ),
              const SizedBox(height: 10),
              const Text(
                'Description / ማመልከቻ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Attachment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ElevatedButton(
  onPressed: _pickFiles,
  child: const Text('Attach File'),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue, 
    foregroundColor: Colors.white, 
    minimumSize: Size(double.infinity, 50), // Set width to fill available space
  ),
),

              if (_files != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Selected Files:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    for (final file in _files!)
                      Text(file.name),
                  ],
                ),
              const SizedBox(height: 20),
           Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    ElevatedButton(
      onPressed: () {
        // Add functionality to submit the complaint
      },
      child: const Text('Submit'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[900],
         foregroundColor: Colors.white,
      ),
    ),
    TextButton(
      onPressed: () {
        _formKey.currentState!.reset();
        _contactNumberController.clear();
        setState(() {
          _files!.clear();
        });
      },
      child: const Text('Cancel'),
      style: TextButton.styleFrom(
        foregroundColor: Colors.amber[900], // Set your desired color here
      ),
    ),
  ],
),

            ],
          ),
        ),
      ),
    );
  }
}
