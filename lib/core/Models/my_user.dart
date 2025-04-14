class MyUser {
  final String name;
  final String email;
  final String phone;
  final String password;

  MyUser(this.email, this.phone, this.password, {required this.name});
  
}

class UserModel {
  final String email;
  final String name;
  final String phone;

  UserModel({required this.email, required this.name, required this.phone});
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
    );
  }

}
