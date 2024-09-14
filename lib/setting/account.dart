import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:smarthome/setting/language.dart';
import 'package:url_launcher/url_launcher.dart';
import 'item.dart';
import 'switch_dark.dart'; 
import 'theme_provider.dart';


class AccountScreen extends StatefulWidget {

  final String userId1;
  final String email1;

  const AccountScreen({
    super.key, 
    required this.userId1, 
    required this.email1,
  });

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
        backgroundColor: isDarkMode ? const Color.fromARGB(255, 55, 54, 54) : Colors.grey[200],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height:5),
              Text(
                "Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Image.asset(
                      "images/person.png",
                      width: 70,
                      height: 70,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Baseline(
                                baseline: 20, 
                                baselineType: TextBaseline.alphabetic,
                                child: Text(
                                  "Gmail: ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  widget.email1,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic, // Align children at the start of the vertical axis
                            children: [
                              Text(
                                "Id: ",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDarkMode ? Colors.grey[200] : Colors.grey,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  widget.userId1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isDarkMode ? Colors.grey[200] : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Lang(
                title: "Language",
                icon: Ionicons.earth,
                color: Colors.blue.shade600,
                iconColor: Colors.white,
                value: "English",
              ),
              const SizedBox(height: 20),
              Item(
                title: "Notifications",
                icon: Ionicons.notifications,
                color: isDarkMode ? Colors.grey[850]! : Colors.black,
                iconColor: Colors.amber.shade600,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              Item(
                title: "Admin Website",
                icon: Ionicons.shield_sharp,
                color: Colors.blue,
                iconColor: Colors.white,
                onTap: () => _launchAdminWebsite(),
              ),
              const SizedBox(height: 10),
              Switch_butt(
                title: "Dark Mode",
                icon: Ionicons.moon_sharp,
                // color: isDarkMode ? Colors.white : Colors.black,
                // iconcolor: isDarkMode ? Colors.black : Colors.white,
                value: isDarkMode,
                ontap: () {
                  themeProvider.toggleTheme(); // Call the toggleTheme method
                },
              ),
              const SizedBox(height: 20),
              Item(
                title: "Logout",
                icon: Ionicons.log_out_sharp,
                color: Colors.green.shade700,
                iconColor: Colors.white,
                onTap: () => _showLogoutDialog_logout(context),
              ),
              const SizedBox(height: 10),
              Item(
                title: "Delete Account",
                icon: Ionicons.trash_sharp,
                color: Colors.red.shade700,
                iconColor: Colors.white,
                onTap: () => _showLogoutDialog_deleteaccount(context),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}


void _showLogoutDialog_logout(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Logout'),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((_) {
                // Navigate to the login page after signing out
                Navigator.of(context).pushReplacementNamed('/First_page');
              }).catchError((error) {
                // Handle errors here if sign-out fails
                print("Error signing out: $error");
              });
            },
          ),
        ],
      );
    },
  );
}


void _showLogoutDialog_deleteaccount(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Account'),
        content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Delete Account'),
            onPressed: () async {
              try {
                // Get the current user
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  // Delete the user account
                  await user.delete();
                  // Navigate to the login page after account deletion
                  Navigator.of(context).pushReplacementNamed('/First_page');
                }
              } catch (error) {
                // Handle errors here if account deletion fails
                print("Error deleting account: $error");
                // Show an AlertDialog with the error message
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text('Failed to delete account. Please try again.'),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      );
    },
  );
}



void _launchAdminWebsite() async {
    final Uri _url = Uri.parse('http://192.168.112.197:8080/demo/admin/web.php'); 
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url, mode: LaunchMode.externalApplication);
    } else {
      // Handle the case where the URL could not be launched
      throw 'Could not launch $_url';
    }
  }