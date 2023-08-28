class ChatModel {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;

  ChatModel({
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
  });
}

List<ChatModel> dummyData = [
  ChatModel(
    name: "John Doe",
    message: "Hey Flutter, You are so amazing !",
    time: "15:30",
    avatarUrl:
        "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
  ),
  ChatModel(
    name: "Jane Doe",
    message: "Hey Flutter, You are so amazing !",
    time: "17:30",
    avatarUrl:
        "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
  ),
  ChatModel(
    name: "John Doe",
    message: "Hey Flutter, You are so amazing !",
    time: "5:00",
    avatarUrl:
        "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
  ),
  ChatModel(
    name: "Micheal Doe",
    message: "Hey Flutter, You are so amazing !",
    time: "10:30",
    avatarUrl:
        "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
  )
];
