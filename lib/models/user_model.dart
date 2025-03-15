class UserModel {
  final String userID;
  final String userName;
  final String email;
  final String password;

  UserModel({
    required this.userID,
    required this.userName,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userID: json['userID'],
    userName: json['userName'],
    email: json['email'],
    password: json['password'],
  );

  Map<String, dynamic> toJson() => {
    'userID': userID,
    'userName': userName,
    'email': email,
    'password': password,
  };
}
