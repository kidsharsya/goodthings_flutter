class UserModel {
  final String uid;
  final String email;

  UserModel({required this.uid, required this.email});

  // Factory method untuk membuat UserModel dari Firebase User
  factory UserModel.fromFirebaseUser(user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
    );
  }

  get username => null;
}
