class User {
  final int id;
  final String name;
  final String login;
  final String? email;
  final int createUid;
  final String? unitName;
  final String? phone;
  final String state;
  final String? panNumber;
  final String? aadharNumber;
  final String role;
  final String status;

  User({
    required this.id,
    required this.name,
    required this.login,
    this.email,
    required this.createUid,
    this.unitName,
    this.phone,
    required this.state,
    this.panNumber,
    this.aadharNumber,
    required this.role,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      login: json['login'],
      email: json['email'] == false ? null : json['email'],
      createUid: json['create_uid'],
      unitName: json['unit_name'] == false ? null : json['unit_name'],
      phone: json['phone'] == false ? null : json['phone'],
      state: json['state'],
      panNumber: json['pan_number'] == false ? null : json['pan_number'],
      aadharNumber: json['aadhar_number'] == false ? null : json['aadhar_number'],
      role: json['role'],
      status: json['status'],
    );
  }
}

class Users {
  final int status;
  final List<User> users;

  Users({required this.status, required this.users});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      status: json['status'],
      users: List<User>.from(json['users'].map((u) => User.fromJson(u))),
    );
  }
}
