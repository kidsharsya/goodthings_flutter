import 'package:flutter/material.dart';
import 'package:goodthings_app_project/components/app_bar.dart';
import '../components/navbar_widget.dart';
import '../utils/database_helper.dart' as db_helper;
import '../models/good_things_model.dart' as model;
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<model.GoodThing> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() async {
    final userId =
        Provider.of<AuthProvider>(context, listen: false).user?.uid ?? '';
    final data = await db_helper.DatabaseHelper().getGoodThings(userId);

    // Filter history berdasarkan status
    _history = data
        .where((goodThing) =>
            DateTime.now().difference(goodThing.createdAt).inSeconds >= 12)
        .toList();

    setState(() {});
  }

  void _deleteGoodThing(model.GoodThing goodThing) async {
    if (goodThing.id != null) {
      await db_helper.DatabaseHelper().deleteGoodThing(goodThing.id!);
      _loadHistory(); // Reload history after deleting an item
    } else {
      print("Error: GoodThing id is null.");
    }
  }

  void _confirmDelete(BuildContext context, model.GoodThing goodThing) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteGoodThing(goodThing);
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
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
              padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 10),
              child: Text(
                'Riwayat tantanganmu.',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 20,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  final goodThing = _history[index];
                  return Card(
                    color: Colors.blueGrey,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  goodThing.description,
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.white),
                                onPressed: () =>
                                    _confirmDelete(context, goodThing),
                              ),
                            ],
                          ),
                          Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                              child: ElevatedButton(
                                onPressed: () {
                                  print(
                                      'Button pressed for ${goodThing.description}');
                                },
                                child: Text(
                                  goodThing.status,
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: goodThing.status == 'Terlaksana'
                                      ? Colors.green // Hijau untuk 'Terlaksana'
                                      : Colors.red, // Merah untuk 'Terlewat'
                                  padding: EdgeInsets.symmetric(horizontal: 24),
                                  textStyle: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
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
