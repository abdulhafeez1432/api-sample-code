// we have two cases here the first is the user we register and the second the user we get from the api
// when we register a user we will not have his id and we need to provide a password to make the registration that is why we have user.register
// when we get the user from the api we will have his id but we don't have a password for that case i use the default constructor, if you want you can change to user.login or something like
// the fromJson and toJson are just helpers to handle the conversions between the app and the api json
class User {
  int? id;
  String username;
  String email;
  String? password;

  User({
    required this.id,
    required this.username,
    required this.email,
  }) : password = null;

  User.register({
    required this.username,
    required this.password,
    required this.email,
  }) : this.id = null;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
