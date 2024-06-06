import 'package:flutter/material.dart';

import 'contact_list_screen.dart';

class ContactListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactListScreen(),
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(

            backgroundColor:Color(0xff455764),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5)
          )
        )
      ),
    );
  }
}