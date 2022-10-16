class UserModule {
  String? name;
  String? email;
  String? pass;
  String? uid;
  Map? access;
  bool? isAdmin;

  UserModule({
    this.name,
    this.email,
    this.access,
    this.uid,
    this.isAdmin = false,
    this.pass,
  });
  UserModule.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    access = json['access'];
    uid = json['uid'];
    isAdmin = json['isAdmin'] ?? false;
    pass = json['pass'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'access': access,
      'uid': uid,
      'isAdmin': isAdmin ?? false,
      'pass': pass,
    };
  }
}
