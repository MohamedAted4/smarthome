import 'package:flutter/material.dart';
import 'theme_provider.dart'; // Ensure this is imported
import 'package:provider/provider.dart';

class Lang extends StatelessWidget {
  final String title;
  final Color color;
  final Color iconColor;
  final IconData icon;
  final String? value;

  const Lang({
    super.key,
    required this.title,
    required this.color,
    required this.iconColor,
    required this.icon,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final bool isDarkMode = theme.brightness == Brightness.dark;


    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDarkMode = themeProvider.isDarkMode;

        return GestureDetector(
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const Spacer(),
                value != null
                    ? Text(
                        value!,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode ? (Colors.grey[200] ?? Colors.grey) : Colors.grey,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
