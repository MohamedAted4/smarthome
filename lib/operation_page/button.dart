import 'package:flutter/material.dart';



class BUTT extends StatefulWidget {
  final IconData icon;
  final String name;
  final Widget page; // New parameter for the page to navigate to

  
  BUTT({
    super.key, 
    required this.icon,
    required this.name,
    required this.page, // Initialize page parameter
  });

  @override
  _BUTTState createState() => _BUTTState();
}

class _BUTTState extends State<BUTT> {
  final bool _isColored = false;

  void _Navigatetonewpage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget.page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: _isColored
                ? Colors.amber[600] 
                :  Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), 
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.only(top: 15.0),
                onPressed: _Navigatetonewpage, 
                iconSize: 90,
                icon: Icon(
                  widget.icon,
                  color: Colors.blue[900],
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    Colors.white.withOpacity(0.2), 
                  ),
                  overlayColor: WidgetStateProperty.all<Color>(
                    Colors.blueAccent.shade700.withOpacity(0.3), 
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), 
                    ),
                  ),
                  elevation: WidgetStateProperty.all<double>(0), 
                ),
              ),
              SizedBox(height: 4,),
              Text(
                widget.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0, // Added letter spacing
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
