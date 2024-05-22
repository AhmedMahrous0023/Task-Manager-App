class UserModel {
  final String username, email, firstName, lastName, gender, image, token;
  final int id;
  UserModel(
      {required this.firstName,
      required this.lastName,
      required this.gender,
      required this.image,
      required this.token,
      required this.id,
      required this.username,
      required this.email});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        username: json['username'],
        token: json['token'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        image: json['image'],
        gender: json['gender'],
        email: json['email']);
  }
}
