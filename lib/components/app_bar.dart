import 'package:flutter/material.dart';
import '../pages/profile_page.dart'; // Import the ProfilePage

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 60, 16, 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: AlignmentDirectional(-1, -1),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 50, 0),
              child: Text(
                'Haloo, selamat datang di \nGood Things',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 20,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(1, -1),
            child: IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                // Navigate to ProfilePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
