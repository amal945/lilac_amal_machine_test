class ChatMessage {
  final int id;
  final int senderId;
  final int receiverId;
  final String message;
  final DateTime sentAt;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.sentAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      message: json['message'],
      sentAt: DateTime.parse(json['sent_at']),
    );
  }
}
