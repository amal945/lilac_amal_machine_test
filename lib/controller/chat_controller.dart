import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_machine_test/model/users_response_model.dart';
import 'package:lilac_machine_test/services/get_chat_messages.dart';
import 'package:lilac_machine_test/view/custom_widgets/custom_snacbar.dart';

import '../model/chat_message_model.dart';

class ChatController extends GetxController {
  final String userId;
  UsersResponseModel chatUserData;

  ChatController({required this.userId, required this.chatUserData});

  RxList<ChatMessage> messages = <ChatMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    try {
      final response = await GetChatMessagesService.getChatMessages(
          userId: userId, chatUserId: chatUserData.id);

      if (response.isNotEmpty) {
        messages.assignAll(response);
      }
    } catch (e) {
      showCustomSnackBar(title: "Error", message: "$e", color: Colors.red);
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
