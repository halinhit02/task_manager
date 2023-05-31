class AppUser {
  String uid;
  String username;
  String email;
  String photoURL;

  AppUser(
      {required this.uid,
      required this.username,
      required this.email,
      required this.photoURL});

  factory AppUser.fromMap(Map<dynamic, dynamic> map) => AppUser(
        uid: map['uid'] ?? '',
        username: map['username'] ?? '',
        email: map['email'] ?? '',
        photoURL: map['photoURL'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'username': username,
        'email': email,
        'photoURL': photoURL,
      };
}
