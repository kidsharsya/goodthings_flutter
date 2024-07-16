import 'package:flutter/material.dart';
import 'package:goodthings_app_project/components/app_bar.dart';
import 'package:goodthings_app_project/models/good_things_model.dart';
import 'package:goodthings_app_project/utils/database_helper.dart';
import '../components/navbar_widget.dart';
import '../components/image_widget.dart';
import '../utils/random_goodthings.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String randomGoodThing = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        color: Color(0xFF4AC59E),
        child: Column(
          children: [
            AppBarWidget(),
            NavbarWidget(),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: ImageWidget(
                imagePath: 'assets/images/goodthings.png',
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
              child: Text(
                'Klik tombol jika kamu siap melakukan \nkebaikan!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 16,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: ElevatedButton(
                onPressed: () async {
                  if (authProvider.user != null) {
                    // Get a random good thing
                    String goodThingDescription = await getRandomGoodThing();
                    await saveRandomGoodThing(
                        authProvider.user!.uid, goodThingDescription);

                    // Show dialog with the good thing
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Tantangan Kebaikan'),
                          content: Text(goodThingDescription),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text(
                  'Berikan aku tantangan!',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    color: Colors.white,
                    letterSpacing: 0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  padding: EdgeInsetsDirectional.fromSTEB(60, 0, 60, 0),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveRandomGoodThing(String userId, String description) async {
    final goodThing = GoodThing(
      userId: userId,
      description: description,
      status: 'Terlewat', // Default status
    );
    await DatabaseHelper().insertGoodThing(goodThing);
  }

  Future<String> getRandomGoodThing() async {
    // Generate a random good thing from the utils
    List<String> goodThings = generateRandomGoodThings();
    return goodThings.first; // Return one random good thing
  }
}
