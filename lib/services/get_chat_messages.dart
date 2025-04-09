import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:japx/japx.dart';
import 'package:lilac_machine_test/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/chat_message_model.dart';

class GetChatMessagesService {
  static Future<List<ChatMessage>> getChatMessages(
      {required String userId, required String chatUserId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      final tokenType = prefs.getString("token_type") ?? "Bearer";

      final url = Uri.parse("${Urls.baseUrl}/chat/chat-messages/queries/chat-between-users/$userId/$chatUserId");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$tokenType $token",
        },
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final decoded = Japx.decode(json);
        final List<dynamic> data = decoded['data'];

        final messages =
            data.map((item) => ChatMessage.fromJson(item)).toList();

        return messages;
      } else {
        final json = jsonDecode(response.body);

        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}
