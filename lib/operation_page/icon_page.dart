import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthome/operation_page/button.dart';
import 'package:smarthome/setting/theme_provider.dart';
import 'pg.dart';
import 'loadingscreen.dart';

class HomePage extends StatelessWidget {
  static Pg p1 = Pg(
    name_page: "kitchen",
    icon_page: Icons.kitchen,
    onLightSwitchChanged: (value) {
      print("Light switch changed to: $value");
    },
    onDoorSwitchChanged: (value) {
      print("Door switch changed to: $value");
    },
  );

  static Pg p2 = Pg(
    name_page: "Garage",
    icon_page: Icons.garage_sharp,
    onLightSwitchChanged: (value) {
      print("Light switch changed to: $value");
    },
    onDoorSwitchChanged: (value) {
      print("Door switch changed to: $value");
    },
  );

  static Pg p3 = Pg(
    name_page: "Living Room",
    icon_page: Icons.chair_rounded,
    onLightSwitchChanged: (value) {
      print("Light switch changed to: $value");
    },
    onDoorSwitchChanged: (value) {
      print("Door switch changed to: $value");
    },
  );

  static Pg p4 = Pg(
    name_page: "House Roof",
    icon_page: Icons.roofing,
    onLightSwitchChanged: (value) {
      print("Light switch changed to: $value");
    },
    onDoorSwitchChanged: (value) {
      print("Door switch changed to: $value");
    },
  );

  static Pg p5 = Pg(
    name_page: "Water Pump",
    icon_page: Icons.grass_rounded,
    onLightSwitchChanged: (value) {
      print("Light switch changed to: $value");
    },
    onDoorSwitchChanged: (value) {
      print("Door switch changed to: $value");
    },
  );

  static Pg p6 = Pg(
    name_page: "TV",
    icon_page: Icons.tv_rounded,
    onLightSwitchChanged: (value) {
      print("Light switch changed to: $value");
    },
    onDoorSwitchChanged: (value) {
      print("Door switch changed to: $value");
    },
  );

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDarkMode = themeProvider.isDarkMode;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  "Smart Home",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              backgroundColor: isDarkMode
                  ? const Color.fromARGB(255, 55, 54, 54)
                  : Colors.grey[300],
            ),
            body: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      SizedBox(height:30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: BUTT(
                              icon: Icons.kitchen_sharp,
                              name: "Kitchen",
                              page: LoadingScreen(
                                Room_name: "Kitchen",
                                icon: Icons.kitchen,
                                page: p1,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: BUTT(
                              icon: Icons.garage_sharp,
                              name: "Garage",
                              page: LoadingScreen(
                                Room_name: "Garage",
                                icon: Icons.garage,
                                page: p2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: BUTT(
                              icon: Icons.chair_rounded,
                              name: "Living room",
                              page: LoadingScreen(
                                Room_name: "Living room",
                                icon: Icons.chair_rounded,
                                page: p3,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: BUTT(
                              icon: Icons.roofing,
                              name: "Roof",
                              page: LoadingScreen(
                                Room_name: "Roof",
                                icon: Icons.roofing,
                                page: p4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: BUTT(
                              icon: Icons.grass,
                              name: "Water Pump",
                              page: LoadingScreen(
                                Room_name: "Water Pump",
                                icon: Icons.grass,
                                page: p5,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: BUTT(
                              icon: Icons.tv_sharp,
                              name: "TV",
                              page: LoadingScreen(
                                Room_name: "TV",
                                icon: Icons.tv_sharp,
                                page: p6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
