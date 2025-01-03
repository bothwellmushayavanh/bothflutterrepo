import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'database_helper.dart';

class FeesPayment extends StatefulWidget {
  const FeesPayment({Key? key}) : super(key: key);

  @override
  _FeesPaymentState createState() => _FeesPaymentState();
}

class _FeesPaymentState extends State<FeesPayment> {
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  int? _selectedGrade;
  String? _selectedTerm;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [Color(0xffb81736), Color(0xff281537)],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 22),
                child: Text(
                  'Fees Payment',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 40),
                        TextField(
                          controller: _studentNameController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.check, color: Colors.grey),
                            label: Text(
                              'Student Number',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB81736),
                              ),
                            ),
                          ),
                        
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _amountController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.check, color: Colors.grey),
                            label: Text(
                              'Amount',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB81736),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 40),
                        DropdownButtonFormField<int>(
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.check, color: Colors.grey),
                            label: Text(
                              'Grade',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB81736),
                              ),
                            ),
                          ),
                          items: List.generate(7, (index) => index + 1)
                              .map((grade) => DropdownMenuItem<int>(
                                    value: grade,
                                    child: Text('Grade $grade'),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedGrade = value;
                            });
                          },
                        ),
                        SizedBox(height: 40),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.check, color: Colors.grey),
                            label: Text(
                              'Term',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB81736),
                              ),
                            ),
                          ),
                          items: List.generate(3, (index) => 'Term ${index + 1}')
                              .map((term) => DropdownMenuItem<String>(
                                    value: term,
                                    child: Text(term),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedTerm = value;
                            });
                          },
                        ),
                        SizedBox(height: 40),
                        SizedBox(height: 50),
                        GestureDetector(
                          onTap: _submitData,
                          child: Container(
                            height: 55,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                colors: const [Color(0xffb81736), Color(0xff281537)],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
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

  Future<void> _submitData() async {
    String studentName = _studentNameController.text;
    double? amount = double.tryParse(_amountController.text);
    int? grade = _selectedGrade;
    String? term = _selectedTerm;

    if (studentName.isNotEmpty && amount != null && grade != null && term != null) {
      Map<String, dynamic> data = {
        'student_name': studentName,
        'amount': amount,
        'grade': grade,
        'term': term,
      };

      await _databaseHelper.insertPayment(data);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment recorded successfully!')),
      );

      _clearInputs();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  void _clearInputs() {
    _studentNameController.clear();
    _amountController.clear();
    setState(() {
      _selectedGrade = null;
      _selectedTerm = null;
    });
  }
}
