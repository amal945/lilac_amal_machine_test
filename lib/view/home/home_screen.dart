import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_machine_test/controller/home_controller.dart';
import 'package:lilac_machine_test/view/chat/chat_screen.dart';

import '../../model/user_model.dart';

class HomeScreen extends StatelessWidget {
  UserModel userData;

  HomeScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController(userData: userData));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Messages',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 90,
                child: Obx(
                  () => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) {
                      final data = controller.users[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(data
                                      .profilePhotoUrl ??
                                  "https://photosbulk.com/wp-content/uploads/instagram-profile-picture-black-and-white_32.webp"),
                            ),
                            SizedBox(height: 4),
                            Text(
                              data.name,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Search
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: // Inside the Search TextField
                TextField(
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        'assets/images/search-favorite.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                  ),
                ),

              ),

              SizedBox(height: 20),

              Text('Chat', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              // Chat list
              Expanded(
                  child: Obx(
                () => ListView.separated(
                  itemCount: controller.filteredUsers.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    final data = controller.filteredUsers[index];
                    return InkWell(
                      onTap: () {
                        Get.to(() => ChatScreen(
                              userId: userData.id.toString(),
                              chatUserData: data,
                            ));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(data.profilePhotoUrl ??
                              "https://photosbulk.com/wp-content/uploads/instagram-profile-picture-black-and-white_32.webp"),
                        ),
                        title: Text(
                          data.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (data.isOnline == true || data.isActive == true)
                              Container(
                                width: 8,
                                height: 8,
                                margin: EdgeInsets.only(right: 6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: data.isOnline == true
                                      ? Colors.green
                                      : Colors.blue,
                                ),
                              ),
                            Text(
                              data.isOnline == true
                                  ? "ONLINE"
                                  : data.isActive == true
                                      ? "ACTIVE"
                                      : controller
                                          .formatTimeAgo(data.lastActiveAt!),
                              style: TextStyle(
                                fontSize: 12,
                                color: data.isOnline == true
                                    ? Colors.green
                                    : data.isActive == true
                                        ? Colors.blue
                                        : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )),

            ],
          ),
        ),
      ),
    );
  }
}
