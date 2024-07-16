import 'dart:async'; // Import untuk Timer
import 'package:flutter/material.dart';
import 'package:goodthings_app_project/components/app_bar.dart';
import '../components/navbar_widget.dart';
import '../utils/database_helper.dart' as db_helper;
import '../models/good_things_model.dart' as model;
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ChallengePage extends StatefulWidget {
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  List<model.GoodThing> _goodThings = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _loadGoodThings();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Pastikan timer dihentikan saat widget dihapus
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  void _loadGoodThings() async {
    final userId =
        Provider.of<AuthProvider>(context, listen: false).user?.uid ?? '';
    final data = await db_helper.DatabaseHelper().getGoodThings(userId);

    final now = DateTime.now();
    _goodThings = data.where((goodThing) {
      return now.difference(goodThing.createdAt).inHours < 12;
    }).toList();

    setState(() {
      _goodThings.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });
  }

  void _updateGoodThingStatus(
      model.GoodThing goodThing, bool isCompleted) async {
    goodThing.status = isCompleted ? 'Terlaksana' : 'Terlewat';
    await db_helper.DatabaseHelper().updateGoodThingStatus(goodThing);
    _loadGoodThings(); // Refresh the list after updating status
  }

  String _getRemainingTime(model.GoodThing goodThing) {
    final now = DateTime.now();
    final duration =
        goodThing.createdAt.add(Duration(hours: 12)).difference(now);

    if (duration.isNegative) {
      return "Habis";
    } else {
      return "${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
    }
  }

  Future<void> _confirmCheckboxChange(
      model.GoodThing goodThing, bool newValue) async {
    final confirmation = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text(
              'Apakah Anda yakin ingin menandai tantangan ini sebagai ${newValue ? 'Terlaksana' : 'Terlewat'}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Tidak
              child: Text('Tidak'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Ya
              child: Text('Ya'),
            ),
          ],
        );
      },
    );

    if (confirmation == true) {
      setState(() {
        goodThing.status = newValue ? 'Terlaksana' : 'Terlewat';
      });
      _updateGoodThingStatus(goodThing, newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF4AC59E),
        child: Column(
          children: [
            AppBarWidget(),
            NavbarWidget(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
              child: Text(
                'Tantanganmu hari ini!',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 20,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
              child: Text(
                '“Check” jika tantangan sudah terlaksanakan',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  letterSpacing: 0,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _goodThings.length,
                itemBuilder: (context, index) {
                  final goodThing = _goodThings[index];
                  return Card(
                    color: Colors.blueGrey,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            goodThing.description,
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                              letterSpacing: 0,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Sisa waktu: ${_getRemainingTime(goodThing)}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 10),
                          Checkbox(
                            value: goodThing.status == 'Terlaksana',
                            onChanged: (newValue) async {
                              await _confirmCheckboxChange(
                                  goodThing, newValue!);
                            },
                            side: BorderSide(width: 2, color: Colors.white),
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
