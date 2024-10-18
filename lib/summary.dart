import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'student_fees_model.dart'; // Import the model class
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class DailySummary extends StatefulWidget {
  const DailySummary({Key? key}) : super(key: key);

  @override
  _DailySummaryState createState() => _DailySummaryState();
}

class _DailySummaryState extends State<DailySummary> {
  late Future<List<FeesPayment>> _feesPayments;
  BluetoothDevice? _selectedPrinter; // Use BluetoothDevice instead of BluetoothPrinter
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];

  @override
  void initState() {
    super.initState();
    _fetchFeesPayments();
    _initBluetooth();
  }

  void _fetchFeesPayments() {
    _feesPayments = _getFeesPayments();
  }

  Future<List<FeesPayment>> _getFeesPayments() async {
    final dbHelper = DatabaseHelper();
    final List<Map<String, dynamic>> paymentMaps = await dbHelper.getPayments();

    return paymentMaps.map((map) => FeesPayment.fromMap(map)).toList();
  }

  void _initBluetooth() async {
    // Check if the Bluetooth is enabled
    bool isConnected = await bluetooth.isConnected ?? false;
    if (!isConnected) {
      // If Bluetooth is not connected, start scanning for available devices
      _devices = await bluetooth.getBondedDevices();
    }
  }

  void _printList() async {
    if (_selectedPrinter == null) {
      // If no printer is selected, show a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No printer selected')),
      );
      return;
    }

    // Connect to the selected printer
    bool connected = await bluetooth.connect(_selectedPrinter!);

    if (connected) {
      // Once connected, print the list
      _feesPayments.then((payments) {
        bluetooth.printCustom('Daily Summary', 3, 1);
        bluetooth.printNewLine();
        for (var payment in payments) {
          bluetooth.printCustom('Student: ${payment.studentName}', 1, 0);
          bluetooth.printCustom('Amount: ${payment.amount}', 1, 0);
          bluetooth.printCustom('Grade: ${payment.grade}', 1, 0);
          bluetooth.printCustom('Term: ${payment.term}', 1, 0);
          bluetooth.printNewLine();
        }
        bluetooth.printNewLine();
        bluetooth.paperCut();
      });

      // Disconnect after printing
      bluetooth.disconnect();
    } else {
      // If failed to connect, show a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not connect to the printer')),
      );
    }
  }

  void _selectPrinter(BluetoothDevice printer) {
    setState(() {
      _selectedPrinter = printer;
    });
  }

  void _deletePayment(int? id) async {
    if (id == null) return;

    final dbHelper = DatabaseHelper();
    await dbHelper.deletePayment(id);

    setState(() {
      _fetchFeesPayments();
    });
  }

  void _updatePayment(int? id, String studentName, double amount, int grade, String term) async {
    if (id == null) return;

    final dbHelper = DatabaseHelper();
    await dbHelper.updatePayment({
      'id': id,
      'student_name': studentName,
      'amount': amount,
      'grade': grade,
      'term': term,
    });

    setState(() {
      _fetchFeesPayments();
    });
  }

  void _showEditDialog(BuildContext context, FeesPayment payment) {
    final studentNameController = TextEditingController(text: payment.studentName);
    final amountController = TextEditingController(text: payment.amount.toString());
    final gradeController = TextEditingController(text: payment.grade.toString());
    final termController = TextEditingController(text: payment.term);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Payment'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: studentNameController,
                  decoration: InputDecoration(labelText: 'Student Name'),
                ),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: gradeController,
                  decoration: InputDecoration(labelText: 'Grade'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: termController,
                  decoration: InputDecoration(labelText: 'Term'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                _updatePayment(
                  payment.id,
                  studentNameController.text,
                  double.parse(amountController.text),
                  int.parse(gradeController.text),
                  termController.text,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Daily Summary'),
          actions: [
            IconButton(
              icon: Icon(Icons.print),
              onPressed: () async {
                _devices = await bluetooth.getBondedDevices();
                if (_devices.isNotEmpty) {
                  _selectPrinter(_devices[0]); // Automatically select the first printer
                  _printList();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('No paired Bluetooth printers found')),
                  );
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<FeesPayment>>(
                future: _feesPayments,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available.'));
                  } else {
                    final feesPayments = snapshot.data!;
                    return ListView.builder(
                      itemCount: feesPayments.length,
                      itemBuilder: (context, index) {
                        final payment = feesPayments[index];
                        return ListTile(
                          title: Text(payment.studentName),
                          subtitle: Text(
                            'Amount: ${payment.amount}, Grade: ${payment.grade}, Term: ${payment.term}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  _showEditDialog(context, payment);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.sync, color: Colors.green),
                                onPressed: () {
                                  print('Sync ${payment.studentName}');
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _deletePayment(payment.id);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _printList,
                child: Text('Print Summary'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
