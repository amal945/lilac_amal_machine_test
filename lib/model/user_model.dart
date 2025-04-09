class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String? phone;
  final String? gender;
  final String? currentLocation;
  final int? heightInCm;
  final int? age;
  final String? customerCode;
  final String? profilePhotoUrl;

  // Auth Token
  final String accessToken;
  final String tokenType;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.phone,
    this.gender,
    this.currentLocation,
    this.heightInCm,
    this.age,
    this.customerCode,
    this.profilePhotoUrl,
    required this.accessToken,
    required this.tokenType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.parse(json['id']),
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      currentLocation: json['current_location'],
      heightInCm: json['height_in_cm'],
      age: json['age'],
      customerCode: json['customer_code'],
      profilePhotoUrl: json['profile_photo_url'],
      accessToken: json['auth_status']['access_token'],
      tokenType: json['auth_status']['token_type'],
    );
  }
}
