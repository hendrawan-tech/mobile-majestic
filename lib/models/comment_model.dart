import 'package:majestic/models/auth_model.dart';

class CommentModel {
  int? id;
  String? comment;
  String? destinationId;
  String? userId;
  String? createdAt;
  String? updatedAt;
  AuthModel? user;

  CommentModel({
    this.id,
    this.comment,
    this.destinationId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    destinationId = json['destination_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = AuthModel.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['destination_id'] = destinationId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user'] = user?.toJson();
    return data;
  }
}
