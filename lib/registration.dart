class Registration {
  final String username;
  final String email;
  final String password;
  //You shouldnot use '_' for String. You can use it as firstName or firstname. 
  final String first_name;
  //Same as above
  final String last_name;

  Registration({
    required this.username,
    required this.email,
    required this.password,
    required this.first_name,
    required this.last_name,
  });

  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      first_name: json['first_name'],
      last_name: json['last_name'],
    );
  }
}
