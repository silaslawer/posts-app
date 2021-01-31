import 'package:json_annotation/json_annotation.dart';

part 'Post.g.dart';

@JsonSerializable()
class Post {
  final int id;
  final int userId;
  final String title;
  final String body;


  const Post({
    this.id,
    this.userId,
    this.title,
    this.body,
  });



  Map<String, dynamic> toJson() => _$PostToJson(this);

  factory Post.fromJson(Map<String, dynamic> datamap) => _$PostFromJson(datamap);
}
