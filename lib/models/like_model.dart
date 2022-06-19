import 'package:majestic/models/auth_model.dart';

class LikeModel {
  int? id;
  String? userId;
  String? postId;
  String? createdAt;
  String? updatedAt;
  AuthModel? user;

  LikeModel({
    this.id,
    this.userId,
    this.postId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  LikeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = AuthModel.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['post_id'] = postId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user'] = user?.toJson();
    return data;
  }
}
