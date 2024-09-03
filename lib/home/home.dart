import 'package:flutter/material.dart';
import 'package:smarthome/operation_page/icon_page.dart';
import 'package:smarthome/setting/account.dart';
import 'package:smarthome/user/user.dart';



class Home extends StatefulWidget {
  // const Home({super.key});
  


  final String userId;
  final String email;

  Home({super.key, required this.userId, required this.email});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0; // Track the selected index

  PageController pageController = PageController();

  
  List<Widget> get pages => [
    HomePage(),
    Admin(userId1: widget.userId, email1: widget.email), // Pass parameters here
    AccountScreen(userId1: widget.userId, email1: widget.email),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
    selectedIndex = index;
    pageController.jumpToPage(index); // to flip and swao between pages
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // remove debug banner from screen
      home: Scaffold(
        backgroundColor:Colors.black,
        body: PageView(
          controller: pageController,
          children: pages,
          onPageChanged:(int index){
            setState(() {
              selectedIndex = index;
            });
          },
        ), 
        bottomNavigationBar: NavigationBar(
          
          indicatorColor: Colors.amber[600],
          backgroundColor: const Color.fromARGB(255, 209, 209, 208),
          selectedIndex: selectedIndex,
          onDestinationSelected: _onDestinationSelected,
          destinations: <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'User',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

