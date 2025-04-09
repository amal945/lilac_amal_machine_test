class UsersResponseModel {
  final String id;
  final String name;
  final String username;
  final String email;
  final String? phone;
  final String? gender;
  final bool isActive;
  final String? profilePhotoUrl;
  final String? square100ProfilePhotoUrl;
  final String? square300ProfilePhotoUrl;
  final String? square500ProfilePhotoUrl;
  final String? dateOfBirth;
  final int? age;
  final String? nativeLanguageName;
  final String? countryName;
  final String? stateName;
  final String? cityName;
  final String? customCityName;
  final bool? isPremiumCustomer;
  final bool? isOnline;
  final String? lastActiveAt;

  UsersResponseModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.isActive,
    required this.profilePhotoUrl,
    required this.square100ProfilePhotoUrl,
    required this.square300ProfilePhotoUrl,
    required this.square500ProfilePhotoUrl,
    required this.phone,
    required this.gender,
    required this.dateOfBirth,
    required this.age,
    required this.nativeLanguageName,
    required this.countryName,
    required this.stateName,
    required this.cityName,
    required this.customCityName,
    required this.isPremiumCustomer,
    required this.isOnline,
    required this.lastActiveAt,
  });

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) {
    return UsersResponseModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      isActive: json['is_active'] ?? false,
      profilePhotoUrl: json['profile_photo_url'],
      square100ProfilePhotoUrl: json['square100_profile_photo_url'],
      square300ProfilePhotoUrl: json['square300_profile_photo_url'],
      square500ProfilePhotoUrl: json['square500_profile_photo_url'],
      dateOfBirth: json['date_of_birth'],
      age: json['age'],
      nativeLanguageName: json['native_language_name'],
      countryName: json['country_name'],
      stateName: json['state_name'],
      cityName: json['city_name'],
      customCityName: json['custom_city_name'],
      isPremiumCustomer: json['is_premium_customer'],
      isOnline: json['is_online'],
      lastActiveAt: json['last_active_at'],
    );
  }
}
