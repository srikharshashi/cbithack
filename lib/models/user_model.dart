class User {
  String name;
  String email;
  String photoURL;

  User({required this.email, required this.name, required this.photoURL});

  User.frommap(Map<dynamic, dynamic> user)
      : name = user["name"] as String,
        email = user["email"] as String,
        photoURL = user["photoURL"] as String;
}
