import 'dart:convert';
import 'package:japx/japx.dart';
import 'package:lilac_machine_test/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/users_response_model.dart';

class GetUserProfileService {
  static Future<List<UsersResponseModel>> getUserProfile(
      {required String id}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      final tokenType = prefs.getString("token_type") ?? "Bearer";

      final url =
          Uri.parse("${Urls.baseUrl}/chat/chat-messages/queries/contact-users");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$tokenType $token",
        },
      );

      if (response.statusCode == 200) {
        final decoded = Japx.decode(jsonDecode(response.body));
        final List<dynamic> customersJson = decoded['data'];
        final List<UsersResponseModel> customers = customersJson
            .map((json) => UsersResponseModel.fromJson(json))
            .toList();

        return customers;
      } else {
        final json = jsonDecode(response.body);

        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}
