import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import 'theme_provider.dart';

class forwardbutton extends StatelessWidget {

  final Function() ontap;
  const forwardbutton({
    super.key,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDarkMode = themeProvider.isDarkMode;
        
        return GestureDetector(
          onTap: ontap,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color:isDarkMode ? Colors.white: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              Ionicons.chevron_forward_sharp,
              color:isDarkMode ? Colors.black:Color.fromARGB(255, 112, 109, 109),
            ),
          ),
        );
      },
    );
  }
}