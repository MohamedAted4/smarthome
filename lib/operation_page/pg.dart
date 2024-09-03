import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthome/setting/theme_provider.dart';
import 'operation.dart';

class Pg extends StatefulWidget {
  final IconData icon_page;
  final String name_page;
  final void Function(bool) onLightSwitchChanged;
  final void Function(bool) onDoorSwitchChanged;

  const Pg({
    Key? key,
    required this.icon_page,
    required this.name_page,
    required this.onLightSwitchChanged,
    required this.onDoorSwitchChanged,
  }) : super(key: key);

  @override
  State<Pg> createState() => _PgState();
}

class _PgState extends State<Pg> {
  static const double horizontalPadding = 20.0;
  static const double verticalPadding = 15.0;

  List<dynamic> operation = [
    ["Lights", Icons.light, false],
    ["Door", Icons.door_sliding_sharp, false],
  ];

  void switchChanged(bool value, int index) {
    setState(() {
      operation[index][2] = value;
    });

    if (index == 0) {
      widget.onLightSwitchChanged(value);
    } else if (index == 1) {
      widget.onDoorSwitchChanged(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDarkMode = themeProvider.isDarkMode;

        // Colors based on the theme
        final backgroundColor = isDarkMode ? Colors.black : Colors.white;
        final appBarColor = isDarkMode ? Colors.grey[900] : Colors.white;
        final iconColor = isDarkMode ? Colors.white : Colors.grey[800];
        final textColor = isDarkMode ? Colors.white : Colors.grey[800];
        final dividerColor = isDarkMode ? Colors.grey[700] : Colors.grey[400];
        final gridTextColor = isDarkMode ? Colors.white : Colors.black;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: appBarColor,
            elevation: 10,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: iconColor),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.person,
                        size: 45,
                        color: iconColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Smart system",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.name_page,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          SizedBox(width: 15),
                          Icon(
                            widget.icon_page,
                            color: textColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Divider(
                    color: dividerColor,
                    thickness: 1,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Text(
                    "Operation",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: operation.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(15),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1 / 1.3,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return Opertaion_box(
                        device: operation[index][0],
                        icon: operation[index][1],
                        power: operation[index][2],
                        onChanged: (value) => switchChanged(value, index),
                        textColor: gridTextColor, // Assuming Opertaion_box accepts this
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
