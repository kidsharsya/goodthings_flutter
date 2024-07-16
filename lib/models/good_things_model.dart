class GoodThing {
  int? id;
  String userId;
  String description;
  String status;
  DateTime createdAt; // Tambahkan field createdAt

  GoodThing({
    this.id,
    required this.userId,
    required this.description,
    this.status = 'Terlewat',
    DateTime? createdAt, // Tambahkan parameter opsional
  }) : createdAt = createdAt ??
            DateTime.now(); // Inisialisasi dengan waktu sekarang jika tidak ada

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'description': description,
      'status': status,
      'createdAt': createdAt.toIso8601String(), // Tambahkan createdAt ke map
    };
  }

  static GoodThing fromMap(Map<String, dynamic> map) {
    return GoodThing(
      id: map['id'],
      userId: map['userId'],
      description: map['description'],
      status: map['status'],
      createdAt: DateTime.parse(map['createdAt']), // Parse createdAt dari map
    );
  }
}
