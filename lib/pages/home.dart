import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'auth/log_in.dart';

import 'profile/user_profile.dart';
import 'user/bill_status_detail.dart';
import 'user/complain.dart';

import 'user/bill_payment.dart';
import 'user/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkMode = false;
  bool isLightMode = false;

  List<String> titles = ['Complain', 'Bill Status', 'Pay Bill'];
  List<String> imagePaths = ['assets/compliance.jpg', 'assets/electricitybill.png', 'assets/pay Bill.jpg'];

  Users? selectedUser; // Define selectedUser variable here

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AnimatedTheme(
        data: isDarkMode ? ThemeData.dark() : ThemeData.light(),
        duration: const Duration(milliseconds: 500),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
            titleSpacing: 20,
            toolbarHeight: 80,
            title: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 8),
                Text(
                  "Electric Billing System",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    wordSpacing: 2,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            elevation: 0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu, color: Colors.grey),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: Colors.pink[900],
                ),
                onPressed: () {
                  setState(() {
                    isDarkMode = !isDarkMode;
                  });
                },
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/Asset 4.png', height: 100),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                _buildDrawerCard(
                  icon: Icons.home,
                  title: 'Home',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                ),
                _buildDrawerCard(
                  icon: Icons.settings,
                  title: 'Setting',
                  onTap: () {
                    // Navigate to Setting Screen
                  },
                ),
                _buildDrawerCard(
                  icon: Icons.email,
                  title: 'Contact Us',
                  onTap: () {
                    // Navigate to Contact Us Screen
                  },
                ),
                _buildDrawerCard(
                  icon: Icons.info,
                  title: 'About Us',
                  onTap: () {
                    // Navigate to About Us Screen
                  },
                ),
                const Divider(),
                _buildDrawerCard(
                  icon: Icons.account_circle,
                  title: 'Log Out',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                ),
                const Divider(),
              ],
            ),
          ),
          body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 50.0,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
                  child: InkWell(
                    onTap: () {
                      switch(index) {
                        case 0:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ComplainScreen()),
                          );
                          break;
                       case 1:
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => BillStatusScreen(users: const [], billAmount: 9,),),
  );
  break;

                        case 2:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const BillScreen (name: '', referenceNumber: '', billAmount: 0.0,)), // Change `billAmount: null` to `billAmount: 0.0`
                          );
                          break;
                      }
                    },
                    child: Card(
                      shape: _buildCardShape(index),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(imagePaths[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    titles[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
            color: isLightMode ? Colors.white : Colors.blue,
            items: const [
              Icon(Icons.home, size: 30),
              Icon(Icons.person, size: 30),
            ],
            onTap: (index) {
              switch(index) {
                case 0:
                  // Navigate to Home screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                  break;
                case 1:
                  // Navigate to Profile screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                  break;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerCard({required IconData icon, required String title, required VoidCallback onTap}) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }

  RoundedRectangleBorder _buildCardShape(int index) {
    switch (index) {
      case 1:
        return RoundedRectangleBorder
(
          borderRadius: BorderRadius.circular(5.0),
          side: const BorderSide(
            color: Color.fromRGBO(255, 111, 0, 1),
            width: 1.4,
          ),
        );
      case 2:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: const BorderSide(
            color: Color.fromRGBO(13, 71, 161, 1),
            width: 1.4,
          ),
        );
      default:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: const BorderSide(
            color: Color.fromRGBO(74, 20, 140, 1),
            width: 1.4,
          ),
        );
    }
  }
}
