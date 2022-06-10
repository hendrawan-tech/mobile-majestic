class AuthModel {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? phoneNumber;
  String? currentTeamId;
  String? profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  String? twoFactorConfirmedAt;
  String? profile;
  String? token;

  AuthModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phoneNumber,
    this.currentTeamId,
    this.profilePhotoPath,
    this.createdAt,
    this.updatedAt,
    this.twoFactorConfirmedAt,
    this.profile,
    this.token,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phoneNumber = json['phone_number'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    token = json['token'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['phone_number'] = phoneNumber;
    data['current_team_id'] = currentTeamId;
    data['profile_photo_path'] = profilePhotoPath;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['two_factor_confirmed_at'] = twoFactorConfirmedAt;
    data['token'] = token;
    data['profile'] = profile;
    return data;
  }
}
