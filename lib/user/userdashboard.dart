import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/feespayment.dart';
import 'package:intl/intl.dart';
import 'package:myapp/summary.dart';
import 'package:myapp/search.dart';

class UserDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Cashier Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle home tap
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Payments'),
              onTap: () {
                // Handle payments tap
              },
            ),
            ListTile(
              leading: Icon(Icons.air),
              title: Text('Buy Airtime'),
              onTap: () {
                // Handle buy airtime tap
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt),
              title: Text('Pay Bills'),
              onTap: () {
                // Handle pay bills tap
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle settings tap
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome to your Dashboard\n${DateFormat.yMMMMd().add_jm().format(DateTime.now())}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: <Widget>[
                    _buildDashboardButton(
                      context,
                      icon: Icons.payment,
                      label: 'Fees Payments',
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeesPayment()));
                      },
                    ),
                    _buildDashboardButton(
                      context,
                      icon: Icons.air,
                      label: 'Buy Airtime',
                      color: Colors.green,
                      onPressed: () {
                        _showAirtimeDialog(context);
                      },
                    ),
                    _buildDashboardButton(
                      context,
                      icon: Icons.money_off_rounded,
                      label: ' Summary',
                      color: Colors.orange,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DailySummary()));
                      },
                    ),
                    _buildDashboardButton(
                      context,
                      icon: Icons.receipt,
                      label: 'Pay Bills',
                      color: Colors.orange,
                      onPressed: () {
                        // Handle Pay Bills button tap
                      },
                    ),
                    _buildDashboardButton(context,
                        icon: Icons.search,
                        label: 'Search',
                        color: Colors.orange, onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()));
                    }),
                    _buildDashboardButton(
                      context,
                      icon: Icons.receipt,
                      label: 'Pay Bills',
                      color: Colors.orange,
                      onPressed: () {
                        // Handle Pay Bills button tap
                      },
                    ),
                    _buildDashboardButton(
                      context,
                      icon: Icons.receipt,
                      label: 'Pay Bills',
                      color: Colors.orange,
                      onPressed: () {
                        // Handle Pay Bills button tap
                      },
                    ),
                    _buildDashboardButton(
                      context,
                      icon: Icons.settings,
                      label: 'Settings',
                      color: Colors.red,
                      onPressed: () {
                        // Handle Settings button tap
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardButton(BuildContext context,
      {required IconData icon,
      required String label,
      required Color color,
      required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 50,
              color: color,
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to show an AlertDialog with two input fields
  void _showAirtimeDialog(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Buy Airtime'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter phone number',
                ),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  hintText: 'Enter amount',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            ElevatedButton(
              child: Text('Buy Airtime'),
              onPressed: () {
                // Handle the airtime purchase with the input data
                String phoneNumber = phoneController.text;
                String amount = amountController.text;

                // You can now handle the input values
                print('Phone Number: $phoneNumber');
                print('Amount: $amount');

                // Close the dialog after processing
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
