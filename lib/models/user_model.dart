enum UserType { PARTICULAR, PROFESSIONAL }

class User {
  String name;
  String email;
  String password;
  String phone;
  UserType userType = UserType.PARTICULAR;

  User({this.name, this.email, this.password, this.phone});
}
