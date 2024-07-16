import 'dart:math';
import 'package:goodthings_app_project/models/good_things_model.dart';
import '../utils/database_helper.dart';

List<String> generateRandomGoodThings() {
  List<String> goodThings = [
    'Bantu orang tua di rumah',
    'Mengajak teman untuk olahraga',
    'Donasi ke panti asuhan',
    'Menyapa tetangga dengan ramah',
    'Mengurangi penggunaan plastik',
    'Membantu orang tua',
    'Menyumbangkan pakaian lama',
    'Menjadi relawan di panti asuhan',
    'Membersihkan lingkungan sekitar',
    'Mengajari anak-anak membaca',
    'Menanam pohon',
    'Menyumbangkan buku',
    'Mengunjungi rumah sakit',
    'Menyebarkan kebahagiaan dengan senyuman',
    'Mengirim kartu ucapan terima kasih'
  ];

  // Mengacak daftar dan mengembalikan satu elemen acak
  goodThings.shuffle();
  return goodThings.take(1).toList(); // Mengambil satu tantangan
}

Future<void> saveRandomGoodThing(String userId, String goodThing) async {
  GoodThing newGoodThing = GoodThing(
    id: 0, // Auto-increment ID
    userId: userId,
    description: goodThing,
    status: 'Terlewat', // Default status
  );

  await DatabaseHelper().insertGoodThing(newGoodThing);
}
