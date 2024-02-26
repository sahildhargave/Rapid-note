class Livestream {
  final String uid;
  final String image;
  final int viewers;
  final String channelId;
  final String username;
  final String title;
  final startedAt;

  Livestream({
    required this.title,
    required this.image,
    required this.uid,
    required this.viewers,
    required this.channelId,
    required this.username,
    required this.startedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'uid': uid,
      'username': username,
      'viewers': viewers,
      'channelId': channelId,
      'startedAt': startedAt,
    };
  }

  factory Livestream.fromMap(Map<String, dynamic> map) {
    return Livestream(
        title: map['title'] ?? '',
        image: map['image'] ?? '',
        uid: map['uid'] ?? '',
        viewers: map['viewers'] ?? '',
        channelId: map['channelId'] ?? '',
        username: map['username'] ?? '',
        startedAt: map['startedAt'] ?? '');
  }
}
