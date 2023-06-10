class Message {
  String text;
  String date;
  bool isUser;

  Message({
    required this.text,
    required this.date,
    required this.isUser,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'date': date,
      'isUser': isUser,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'] ?? '',
      date: map['date'] ?? '',
      isUser: map['isUser'] ?? false,
    );
  }
}
