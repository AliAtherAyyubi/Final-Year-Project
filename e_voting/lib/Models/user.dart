class UserModel {
  String? userId;
  String? userName;
  String? cnic;
  String? email;
  String? password;
  String? phone;
  String? imageUrl;
  String? role;
  bool? isVerified;

  // Constructor //

  UserModel(
      {this.userId,
      this.userName,
      this.cnic,
      this.email,
      this.password,
      this.phone,
      this.isVerified = false,
      this.imageUrl,
      this.role});
}
