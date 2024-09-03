import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smarthome/setting/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timezone/standalone.dart' as tz;


class Admin extends StatefulWidget {
  final String userId1;
  final String email1;
  String? lastSignInTime;


  Admin({super.key, 
    required this.userId1, 
    required this.email1,
  }){
    _getUserLastSignInTime();
  }


  Future<void> _getUserLastSignInTime() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DateTime? lastSignIn = user.metadata.lastSignInTime;
      if (lastSignIn != null) {
        // Get Egypt timezone
        final egyptTimeZone = tz.getLocation('Africa/Cairo');
        final egyptTime = tz.TZDateTime.from(lastSignIn, egyptTimeZone);

        // Format the time for Egypt's local time
        lastSignInTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(egyptTime);
      }
    }
  }

  @override
  State<Admin> createState() => _AdminState();
}


class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDarkMode = themeProvider.isDarkMode;

        return Scaffold(
          backgroundColor: isDarkMode ? const Color.fromARGB(255, 18, 18, 18) :Colors.grey[300],
          appBar: AppBar(
            title: Center(
              child: Text(
                "User Information",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            backgroundColor: isDarkMode ? const Color.fromARGB(255, 36, 36, 36) :Colors.grey[400],
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 75.0,
                      backgroundImage: const AssetImage('images/castro1.jpg'),
                      backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: isDarkMode ? Colors.grey[700] : Colors.black,
                          child: Icon(Icons.person, color: Colors.amber[700], size: 30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Divider(
                      color: isDarkMode ? Colors.grey[700] : Colors.grey[400],
                      thickness: 1.5,
                    ),
                    const SizedBox(height: 10),
                    _buildDetailCard(
                      title: 'User ID',
                      icon: Icons.person_sharp,
                      content: widget.userId1,
                      isDarkMode: isDarkMode,
                    ),
                    const SizedBox(height: 20),
                    _buildDetailCard(
                      title: 'Your Email',
                      icon: Icons.email_sharp,
                      content: widget.email1,
                      isDarkMode: isDarkMode,
                    ),
                    const SizedBox(height: 20),
                    _buildDetailCard(
                      title: 'Last Sign-In Time',
                      icon: Icons.access_time,
                      content: widget.lastSignInTime ?? 'N/A',
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailCard({
    required String title,
    required IconData icon,
    required String content,
    required bool isDarkMode,
  }) {
    return Card(
      elevation: 10,
      color: isDarkMode ? Colors.grey[850] : Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: Icon(
                icon,
                color: isDarkMode ? Colors.blue[200] : Colors.blue,
              ),
              title: Text(
                content,
                style: TextStyle(
                  fontSize: 16.0,
                  color: isDarkMode ? Colors.grey[300] : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



