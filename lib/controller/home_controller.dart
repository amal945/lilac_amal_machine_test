import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_machine_test/model/users_response_model.dart';
import 'package:lilac_machine_test/services/get_user_profiles_service.dart';
import 'package:lilac_machine_test/view/custom_widgets/custom_snacbar.dart';

import '../model/user_model.dart';

class HomeController extends GetxController {
  UserModel userData;

  HomeController({required this.userData});

  RxList<UsersResponseModel> users = <UsersResponseModel>[].obs;
  RxList<UsersResponseModel> filteredUsers = <UsersResponseModel>[].obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await getChatProfiles();
    ever(searchQuery, (_) => filterUsers());
  }

  Future<void> getChatProfiles() async {
    try {
      final response = await GetUserProfileService.getUserProfile(id: "55");
      if (response.isNotEmpty) {
        users.assignAll(response);
        filteredUsers.assignAll(response);
      } else {
        showCustomSnackBar(
          title: "Error",
          message: "Error fetching user profiles",
          color: Colors.red,
        );
      }
    } catch (e) {
      showCustomSnackBar(
        title: "Exception",
        message: "$e",
        color: Colors.red,
      );
    }
  }

  void filterUsers() {
    if (searchQuery.value.trim().isEmpty) {
      filteredUsers.assignAll(users);
    } else {
      final query = searchQuery.value.toLowerCase();
      filteredUsers.assignAll(
        users.where((user) => user.name.toLowerCase().contains(query)),
      );
    }
  }

  String formatTimeAgo(String isoTime) {
    final dateTime = DateTime.tryParse(isoTime)?.toLocal();
    if (dateTime == null) return "OFFLINE";

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) return "just now";
    if (difference.inMinutes < 60) return "${difference.inMinutes} min ago";
    if (difference.inHours < 24) return "${difference.inHours} hr ago";
    if (difference.inDays < 7) return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
}

