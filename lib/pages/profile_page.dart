import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ProfilePage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    _usernameController.text =
        authProvider.user?.username ?? ''; // Set initial username

    return Scaffold(
      backgroundColor: Color(0xFF4AC59E),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Back button
            Align(
              alignment: AlignmentDirectional(-1, -1),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, size: 35),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.blueGrey,
                ),
              ),
            ),
            // Title
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Akun Saya',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            // Username label
            Align(
              alignment: AlignmentDirectional(-1, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 20, 0, 0),
                child: Text(
                  'Nama Pengguna',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            // Editable Username field
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 5, 16, 0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Masukkan nama pengguna',
                ),
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Email label
            Align(
              alignment: AlignmentDirectional(-1, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 20, 0, 0),
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            // Email field
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 5, 16, 0),
              child: Container(
                width: 390,
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                    child: Text(
                      authProvider.user?.email ?? 'Email tidak tersedia',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Logout button
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
              child: ElevatedButton(
                onPressed: () async {
                  await authProvider.logout();
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text(
                  'Keluar',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  textStyle: TextStyle(
                    fontFamily: 'Readex Pro',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
