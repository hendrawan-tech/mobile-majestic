import 'package:majestic/models/comment_model.dart';
import 'package:majestic/models/like_model.dart';

class ProductModel {
  int? id;
  String? title;
  String? category;
  String? address;
  String? description;
  String? image;
  String? price;
  bool? favorite;
  String? createdAt;
  String? updatedAt;
  List<LikeModel>? likes;
  List<CommentModel>? comments;

  ProductModel({
    this.id,
    this.title,
    this.category,
    this.address,
    this.description,
    this.image,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.likes,
    this.comments,
    this.favorite
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    address = json['address'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    favorite = json['favorite'];
    likes = json['likes']
        .map<LikeModel>((like) => LikeModel.fromJson(like))
        .toList();
    comments = json['comments']
        .map<CommentModel>((comment) => CommentModel.fromJson(comment))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['category'] = category;
    data['address'] = address;
    data['description'] = description;
    data['image'] = image;
    data['price'] = price;
    data['favorite'] = favorite;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['likes'] = likes?.map((like) => like.toJson()).toList();
    data['comments'] = comments?.map((comment) => comment.toJson()).toList();
    return data;
  }
}
