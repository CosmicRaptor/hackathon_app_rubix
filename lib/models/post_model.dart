class PostModel {
  final String uid;
  final String title;
  final String? body;
  final String? imgUrl;
  int likes;

  PostModel({
    required this.uid,
    required this.title,
    this.body,
    this.imgUrl,
    this.likes = 0,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      uid: json['uid'],
      title: json['title'],
      body: json['body'],
      imgUrl: json['imgUrl'],
      likes: json['likes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'title': title,
      'body': body,
      'imgUrl': imgUrl,
      'likes': likes,
    };
  }
}