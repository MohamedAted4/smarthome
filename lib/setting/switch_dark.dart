import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class Switch_butt extends StatelessWidget {
  final String title;
  // final Color color;
  // final Color iconcolor;
  final IconData icon;
  final bool value;
  final VoidCallback ontap; // Change to VoidCallback

  const Switch_butt({
    super.key,
    required this.title,
    // required this.color,
    // required this.iconcolor,
    required this.icon,
    required this.value,
    required this.ontap, // Adjust this line
  });

  @override
  Widget build(BuildContext context) {
    
    
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            child: Icon(
              icon,
              color: isDarkMode ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style:TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const Spacer(),
          Text(
            value ? "ON" : "OFF",
            style:TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.white : Colors.grey,
            ),
          ),
          // const SizedBox(),
          const SizedBox(width: 20),
          CupertinoSwitch(
            value: value,
            onChanged: (bool newValue) {
              ontap(); // Call the callback without parameters
            },
            activeColor: isDarkMode ? Colors.white : Colors.amber,
            trackColor: isDarkMode ? Colors.black : Colors.grey,
            thumbColor:Colors.grey.shade700
          ),
        ],
      ),
    );
  }
}
