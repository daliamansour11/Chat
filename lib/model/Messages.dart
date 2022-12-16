


class Message {
  final String? idUser;
  final String? urlAvatar;
  final String? username;
  final String? message;
  final DateTime ?createdAt;

  const Message({
    this.idUser,
    this.urlAvatar,
    this.username,
    this.message,
    this.createdAt,
  });
}