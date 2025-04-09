import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_machine_test/controller/chat_controller.dart';
import 'package:lilac_machine_test/model/users_response_model.dart';

class ChatScreen extends StatelessWidget {
  final String userId;
  final UsersResponseModel chatUserData;

  const ChatScreen(
      {super.key, required this.userId, required this.chatUserData});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(ChatController(userId: userId, chatUserData: chatUserData));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back)),
                  SizedBox(width: 10),
                  CircleAvatar(
                    backgroundImage: NetworkImage(chatUserData
                            .profilePhotoUrl ??
                        "https://www.freeiconspng.com/thumbs/profile-icon-png/profile-icon-9.png"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chatUserData.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Row(
                        children: [
                          Text(
                            chatUserData.isOnline == true
                                ? "ONLINE"
                                : chatUserData.isActive == true
                                    ? "ACTIVE"
                                    : controller.formatTimeAgo(
                                        chatUserData.lastActiveAt!),
                            style: TextStyle(
                              fontSize: 12,
                              color: chatUserData.isOnline == true
                                  ? Colors.green
                                  : chatUserData.isActive == true
                                      ? Colors.blue
                                      : Colors.grey,
                            ),
                          ),
                          SizedBox(width: 4),
                          CircleAvatar(
                            radius: 4,
                            backgroundColor: chatUserData.isOnline == true
                                ? Colors.green
                                : chatUserData.isActive == true
                                    ? Colors.blue
                                    : Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Chat bubble area
            Expanded(
              child: Obx(() {
                if (controller.messages.isEmpty) {
                  return Center(
                    child: Text("No messages yet"),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final msg = controller.messages[index];
                    final isMe = msg.senderId.toString() == controller.userId;

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: isMe
                                  ? Color(0xFFEB3D6F)
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              msg.message,
                              style: TextStyle(
                                  color: isMe ? Colors.white : Colors.black),
                            ),
                          ),
                          isMe
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      TimeOfDay.fromDateTime(msg.sentAt)
                                          .format(context),
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.done_all,
                                      size: 16,
                                    )
                                  ],
                                )
                              : Text(
                                  TimeOfDay.fromDateTime(msg.sentAt)
                                      .format(context),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
            Divider(),
            // Input field
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration:
                                  BoxDecoration(color: Colors.grey[200]),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Enter your message",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Image.asset(
                              'assets/images/send.png',
                              width: 24,
                              height: 24,
                            ),
                            onPressed: () {
                              // Your send logic
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
