// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDatabase.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class PostModelData extends DataClass implements Insertable<PostModelData> {
  final String? postId;
  final String? description;
  final String? district;
  final String? state;
  final String? country;
  final int? maleSeen;
  final int? femaleSeen;
  final int? likes0Count;
  final int? likes1Count;
  final int? likes2Count;
  final int? commentsCount;
  final String? price;
  final String? purchaseUrl;
  final String? productName;
  final String? buttonName;
  final String? typeOf;
  final String? createdAt;
  final String? updatedAt;
  final String? userId;
  final String? userName;
  final String? name;
  final String? userBio;
  final String? userType;
  final String? userProfileImage;
  final bool? followStatus;
  final bool? isUpdate;
  final int? likeStatus;
  PostModelData(
      {required this.postId,
        required this.description,
        required this.district,
        required this.state,
        required this.country,
        required this.maleSeen,
        required this.femaleSeen,
        required this.likes0Count,
        required this.likes1Count,
        required this.likes2Count,
        required this.commentsCount,
        required this.price,
        required this.purchaseUrl,
        required this.productName,
        required this.buttonName,
        required this.typeOf,
        required this.createdAt,
        required this.updatedAt,
        required this.userId,
        required this.userName,
        required this.name,
        required this.userBio,
        required this.userType,
        required this.userProfileImage,
        required this.followStatus,
        required this.isUpdate,
        required this.likeStatus});
  factory PostModelData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PostModelData(
      // postId: const StringType()
      //     .mapFromDatabaseResponse(data['${effectivePrefix}post_id'])!,
      postId: data['${effectivePrefix}post_id']!,
      description: data['${effectivePrefix}description']!,
      district: data['${effectivePrefix}district']!,
      state: data['${effectivePrefix}state']!,
      country: data['${effectivePrefix}country']!,
      maleSeen: data['${effectivePrefix}male_seen']!,
      femaleSeen: data['${effectivePrefix}female_seen']!,
      likes0Count: data['${effectivePrefix}likes0_count']!,
      likes1Count: data['${effectivePrefix}likes1_count']!,
      likes2Count: data['${effectivePrefix}likes2_count']!,
      commentsCount: data['${effectivePrefix}comments_count']!,
      price: data['${effectivePrefix}price']!,
      purchaseUrl: data['${effectivePrefix}purchase_url']!,
      productName: data['${effectivePrefix}product_name']!,
      buttonName: data['${effectivePrefix}button_name']!,
      typeOf: data['${effectivePrefix}type_of']!,
      createdAt: data['${effectivePrefix}created_at']!,
      updatedAt: data['${effectivePrefix}updated_at']!,
      userId: data['${effectivePrefix}user_id']!,
      userName: data['${effectivePrefix}user_name']!,
      name: data['${effectivePrefix}name']!,
      userBio: data['${effectivePrefix}user_bio']!,
      userType: data['${effectivePrefix}user_type']!,
      userProfileImage: data['${effectivePrefix}user_profile_image']!,
      followStatus: data['${effectivePrefix}follow_status']!,
      isUpdate: data['${effectivePrefix}is_update']!,
      likeStatus: data['${effectivePrefix}like_status']!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || postId != null) {
      map['post_id'] = Variable<String>(postId);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || district != null) {
      map['district'] = Variable<String>(district);
    }
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<String>(state);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || maleSeen != null) {
      map['male_seen'] = Variable<int>(maleSeen);
    }
    if (!nullToAbsent || femaleSeen != null) {
      map['female_seen'] = Variable<int>(femaleSeen);
    }
    if (!nullToAbsent || likes0Count != null) {
      map['likes0_count'] = Variable<int>(likes0Count);
    }
    if (!nullToAbsent || likes1Count != null) {
      map['likes1_count'] = Variable<int>(likes1Count);
    }
    if (!nullToAbsent || likes2Count != null) {
      map['likes2_count'] = Variable<int>(likes2Count);
    }
    if (!nullToAbsent || commentsCount != null) {
      map['comments_count'] = Variable<int>(commentsCount);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<String>(price);
    }
    if (!nullToAbsent || purchaseUrl != null) {
      map['purchase_url'] = Variable<String>(purchaseUrl) as Expression<Object>;
    }
    if (!nullToAbsent || productName != null) {
      map['product_name'] = Variable<String>(productName);
    }
    if (!nullToAbsent || buttonName != null) {
      map['button_name'] = Variable<String>(buttonName);
    }
    if (!nullToAbsent || typeOf != null) {
      map['type_of'] = Variable<String>(typeOf);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || userName != null) {
      map['user_name'] = Variable<String>(userName);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || userBio != null) {
      map['user_bio'] = Variable<String>(userBio);
    }
    if (!nullToAbsent || userType != null) {
      map['user_type'] = Variable<String>(userType);
    }
    if (!nullToAbsent || userProfileImage != null) {
      map['user_profile_image'] = Variable<String>(userProfileImage);
    }
    if (!nullToAbsent || followStatus != null) {
      map['follow_status'] = Variable<bool>(followStatus);
    }
    if (!nullToAbsent || isUpdate != null) {
      map['is_update'] = Variable<bool>(isUpdate);
    }
    if (!nullToAbsent || likeStatus != null) {
      map['like_status'] = Variable<int>(likeStatus);
    }
    return map;
  }

  PostModelCompanion toCompanion(bool nullToAbsent) {
    return PostModelCompanion(
      postId:
      postId == null && nullToAbsent ? const Value.absent() : Value(postId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
      state:
      state == null && nullToAbsent ? const Value.absent() : Value(state),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      maleSeen: maleSeen == null && nullToAbsent
          ? const Value.absent()
          : Value(maleSeen),
      femaleSeen: femaleSeen == null && nullToAbsent
          ? const Value.absent()
          : Value(femaleSeen),
      likes0Count: likes0Count == null && nullToAbsent
          ? const Value.absent()
          : Value(likes0Count),
      likes1Count: likes1Count == null && nullToAbsent
          ? const Value.absent()
          : Value(likes1Count),
      likes2Count: likes2Count == null && nullToAbsent
          ? const Value.absent()
          : Value(likes2Count),
      commentsCount: commentsCount == null && nullToAbsent
          ? const Value.absent()
          : Value(commentsCount),
      price:
      price == null && nullToAbsent ? const Value.absent() : Value(price),
      purchaseUrl: purchaseUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseUrl),
      productName: productName == null && nullToAbsent
          ? const Value.absent()
          : Value(productName),
      buttonName: buttonName == null && nullToAbsent
          ? const Value.absent()
          : Value(buttonName),
      typeOf:
      typeOf == null && nullToAbsent ? const Value.absent() : Value(typeOf),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      userId:
      userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      userName: userName == null && nullToAbsent
          ? const Value.absent()
          : Value(userName),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      userBio: userBio == null && nullToAbsent
          ? const Value.absent()
          : Value(userBio),
      userType: userType == null && nullToAbsent
          ? const Value.absent()
          : Value(userType),
      userProfileImage: userProfileImage == null && nullToAbsent
          ? const Value.absent()
          : Value(userProfileImage),
      followStatus: followStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(followStatus),
      isUpdate: isUpdate == null && nullToAbsent
          ? const Value.absent()
          : Value(isUpdate),
      likeStatus: likeStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(likeStatus),
    );
  }

  factory PostModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PostModelData(
      postId: serializer.fromJson<String>(json['postId']),
      description: serializer.fromJson<String>(json['description']),
      district: serializer.fromJson<String>(json['district']),
      state: serializer.fromJson<String>(json['state']),
      country: serializer.fromJson<String>(json['country']),
      maleSeen: serializer.fromJson<int>(json['maleSeen']),
      femaleSeen: serializer.fromJson<int>(json['femaleSeen']),
      likes0Count: serializer.fromJson<int>(json['likes0Count']),
      likes1Count: serializer.fromJson<int>(json['likes1Count']),
      likes2Count: serializer.fromJson<int>(json['likes2Count']),
      commentsCount: serializer.fromJson<int>(json['commentsCount']),
      price: serializer.fromJson<String>(json['price']),
      purchaseUrl: serializer.fromJson<String>(json['purchaseUrl']),
      productName: serializer.fromJson<String>(json['productName']),
      buttonName: serializer.fromJson<String>(json['buttonName']),
      typeOf: serializer.fromJson<String>(json['typeOf']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      userId: serializer.fromJson<String>(json['userId']),
      userName: serializer.fromJson<String>(json['userName']),
      name: serializer.fromJson<String>(json['name']),
      userBio: serializer.fromJson<String>(json['userBio']),
      userType: serializer.fromJson<String>(json['userType']),
      userProfileImage: serializer.fromJson<String>(json['userProfileImage']),
      followStatus: serializer.fromJson<bool>(json['followStatus']),
      isUpdate: serializer.fromJson<bool>(json['isUpdate']),
      likeStatus: serializer.fromJson<int>(json['likeStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'postId': serializer.toJson<String?>(postId),
      'description': serializer.toJson<String?>(description),
      'district': serializer.toJson<String?>(district),
      'state': serializer.toJson<String?>(state),
      'country': serializer.toJson<String?>(country),
      'maleSeen': serializer.toJson<int?>(maleSeen),
      'femaleSeen': serializer.toJson<int?>(femaleSeen),
      'likes0Count': serializer.toJson<int?>(likes0Count),
      'likes1Count': serializer.toJson<int?>(likes1Count),
      'likes2Count': serializer.toJson<int?>(likes2Count),
      'commentsCount': serializer.toJson<int?>(commentsCount),
      'price': serializer.toJson<String?>(price),
      'purchaseUrl': serializer.toJson<String?>(purchaseUrl),
      'productName': serializer.toJson<String?>(productName),
      'buttonName': serializer.toJson<String?>(buttonName),
      'typeOf': serializer.toJson<String?>(typeOf),
      'createdAt': serializer.toJson<String?>(createdAt),
      'updatedAt': serializer.toJson<String?>(updatedAt),
      'userId': serializer.toJson<String?>(userId),
      'userName': serializer.toJson<String?>(userName),
      'name': serializer.toJson<String?>(name),
      'userBio': serializer.toJson<String?>(userBio),
      'userType': serializer.toJson<String?>(userType),
      'userProfileImage': serializer.toJson<String?>(userProfileImage),
      'followStatus': serializer.toJson<bool?>(followStatus),
      'isUpdate': serializer.toJson<bool?>(isUpdate),
      'likeStatus': serializer.toJson<int?>(likeStatus),
    };
  }

  PostModelData copyWith(
      {final String? postId,
        final String? description,
        final String? district,
        final String? state,
        final String? country,
        final int? maleSeen,
        final int? femaleSeen,
        final int? likes0Count,
        final int? likes1Count,
        final int? likes2Count,
        final int? commentsCount,
        final String? price,
        final String? purchaseUrl,
        final String? productName,
        final String? buttonName,
        final String? typeOf,
        final String? createdAt,
        final String? updatedAt,
        final String? userId,
        final String? userName,
        final String? name,
        final String? userBio,
        final String? userType,
        final String? userProfileImage,
        final bool? followStatus,
        final bool? isUpdate,
        final int? likeStatus}) =>
      PostModelData(
        postId: postId ?? this.postId,
        description: description ?? this.description,
        district: district ?? this.district,
        state: state ?? this.state,
        country: country ?? this.country,
        maleSeen: maleSeen ?? this.maleSeen,
        femaleSeen: femaleSeen ?? this.femaleSeen,
        likes0Count: likes0Count ?? this.likes0Count,
        likes1Count: likes1Count ?? this.likes1Count,
        likes2Count: likes2Count ?? this.likes2Count,
        commentsCount: commentsCount ?? this.commentsCount,
        price: price ?? this.price,
        purchaseUrl: purchaseUrl ?? this.purchaseUrl,
        productName: productName ?? this.productName,
        buttonName: buttonName ?? this.buttonName,
        typeOf: typeOf ?? this.typeOf,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        name: name ?? this.name,
        userBio: userBio ?? this.userBio,
        userType: userType ?? this.userType,
        userProfileImage: userProfileImage ?? this.userProfileImage,
        followStatus: followStatus ?? this.followStatus,
        isUpdate: isUpdate ?? this.isUpdate,
        likeStatus: likeStatus ?? this.likeStatus,
      );
  @override
  String toString() {
    return (StringBuffer('PostModelData(')
      ..write('postId: $postId, ')
      ..write('description: $description, ')
      ..write('district: $district, ')
      ..write('state: $state, ')
      ..write('country: $country, ')
      ..write('maleSeen: $maleSeen, ')
      ..write('femaleSeen: $femaleSeen, ')
      ..write('likes0Count: $likes0Count, ')
      ..write('likes1Count: $likes1Count, ')
      ..write('likes2Count: $likes2Count, ')
      ..write('commentsCount: $commentsCount, ')
      ..write('price: $price, ')
      ..write('purchaseUrl: $purchaseUrl, ')
      ..write('productName: $productName, ')
      ..write('buttonName: $buttonName, ')
      ..write('typeOf: $typeOf, ')
      ..write('createdAt: $createdAt, ')
      ..write('updatedAt: $updatedAt, ')
      ..write('userId: $userId, ')
      ..write('userName: $userName, ')
      ..write('name: $name, ')
      ..write('userBio: $userBio, ')
      ..write('userType: $userType, ')
      ..write('userProfileImage: $userProfileImage, ')
      ..write('followStatus: $followStatus, ')
      ..write('isUpdate: $isUpdate, ')
      ..write('likeStatus: $likeStatus')
      ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    postId,
    description,
    district,
    state,
    country,
    maleSeen,
    femaleSeen,
    likes0Count,
    likes1Count,
    likes2Count,
    commentsCount,
    price,
    purchaseUrl,
    productName,
    buttonName,
    typeOf,
    createdAt,
    updatedAt,
    userId,
    userName,
    name,
    userBio,
    userType,
    userProfileImage,
    followStatus,
    isUpdate,
    likeStatus
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is PostModelData &&
              other.postId == this.postId &&
              other.description == this.description &&
              other.district == this.district &&
              other.state == this.state &&
              other.country == this.country &&
              other.maleSeen == this.maleSeen &&
              other.femaleSeen == this.femaleSeen &&
              other.likes0Count == this.likes0Count &&
              other.likes1Count == this.likes1Count &&
              other.likes2Count == this.likes2Count &&
              other.commentsCount == this.commentsCount &&
              other.price == this.price &&
              other.purchaseUrl == this.purchaseUrl &&
              other.productName == this.productName &&
              other.buttonName == this.buttonName &&
              other.typeOf == this.typeOf &&
              other.createdAt == this.createdAt &&
              other.updatedAt == this.updatedAt &&
              other.userId == this.userId &&
              other.userName == this.userName &&
              other.name == this.name &&
              other.userBio == this.userBio &&
              other.userType == this.userType &&
              other.userProfileImage == this.userProfileImage &&
              other.followStatus == this.followStatus &&
              other.isUpdate == this.isUpdate &&
              other.likeStatus == this.likeStatus);
}

class PostModelCompanion extends UpdateCompanion<PostModelData> {
  final Value<String?> postId;
  final Value<String?> description;
  final Value<String?> district;
  final Value<String?> state;
  final Value<String?> country;
  final Value<int?> maleSeen;
  final Value<int?> femaleSeen;
  final Value<int?> likes0Count;
  final Value<int?> likes1Count;
  final Value<int?> likes2Count;
  final Value<int?> commentsCount;
  final Value<String?> price;
  final Value<String?> purchaseUrl;
  final Value<String?> productName;
  final Value<String?> buttonName;
  final Value<String?> typeOf;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  final Value<String?> userId;
  final Value<String?> userName;
  final Value<String?> name;
  final Value<String?> userBio;
  final Value<String?> userType;
  final Value<String?> userProfileImage;
  final Value<bool?> followStatus;
  final Value<bool?> isUpdate;
  final Value<int?> likeStatus;
  const PostModelCompanion({
    this.postId = const Value.absent(),
    this.description = const Value.absent(),
    this.district = const Value.absent(),
    this.state = const Value.absent(),
    this.country = const Value.absent(),
    this.maleSeen = const Value.absent(),
    this.femaleSeen = const Value.absent(),
    this.likes0Count = const Value.absent(),
    this.likes1Count = const Value.absent(),
    this.likes2Count = const Value.absent(),
    this.commentsCount = const Value.absent(),
    this.price = const Value.absent(),
    this.purchaseUrl = const Value.absent(),
    this.productName = const Value.absent(),
    this.buttonName = const Value.absent(),
    this.typeOf = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.userName = const Value.absent(),
    this.name = const Value.absent(),
    this.userBio = const Value.absent(),
    this.userType = const Value.absent(),
    this.userProfileImage = const Value.absent(),
    this.followStatus = const Value.absent(),
    this.isUpdate = const Value.absent(),
    this.likeStatus = const Value.absent(),
  });
  PostModelCompanion.insert({
    required String? postId,
    required String? description,
    required String? district,
    required String? state,
    required String? country,
    required int? maleSeen,
    required int? femaleSeen,
    required int? likes0Count,
    required int? likes1Count,
    required int? likes2Count,
    required int? commentsCount,
    required String? price,
    required String? purchaseUrl,
    required String? productName,
    required String? buttonName,
    required String? typeOf,
    required String? createdAt,
    required String? updatedAt,
    required String? userId,
    required String? userName,
    required String? name,
    required String? userBio,
    required String? userType,
    required String? userProfileImage,
    required bool? followStatus,
    required bool? isUpdate,
    required int? likeStatus,
  })  : postId = Value(postId),
        description = Value(description),
        district = Value(district),
        state = Value(state),
        country = Value(country),
        maleSeen = Value(maleSeen),
        femaleSeen = Value(femaleSeen),
        likes0Count = Value(likes0Count),
        likes1Count = Value(likes1Count),
        likes2Count = Value(likes2Count),
        commentsCount = Value(commentsCount),
        price = Value(price),
        purchaseUrl = Value(purchaseUrl),
        productName = Value(productName),
        buttonName = Value(buttonName),
        typeOf = Value(typeOf),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        userId = Value(userId),
        userName = Value(userName),
        name = Value(name),
        userBio = Value(userBio),
        userType = Value(userType),
        userProfileImage = Value(userProfileImage),
        followStatus = Value(followStatus),
        isUpdate = Value(isUpdate),
        likeStatus = Value(likeStatus);
  static Insertable<PostModelData> custom({
    Expression<String>? postId,
    Expression<String>? description,
    Expression<String>? district,
    Expression<String>? state,
    Expression<String>? country,
    Expression<int>? maleSeen,
    Expression<int>? femaleSeen,
    Expression<int>? likes0Count,
    Expression<int>? likes1Count,
    Expression<int>? likes2Count,
    Expression<int>? commentsCount,
    Expression<String>? price,
    Expression<String>? purchaseUrl,
    Expression<String>? productName,
    Expression<String>? buttonName,
    Expression<String>? typeOf,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? userId,
    Expression<String>? userName,
    Expression<String>? name,
    Expression<String>? userBio,
    Expression<String>? userType,
    Expression<String>? userProfileImage,
    Expression<bool>? followStatus,
    Expression<bool>? isUpdate,
    Expression<int>? likeStatus,
  }) {
    return RawValuesInsertable({
      if (postId != null) 'post_id': postId,
      if (description != null) 'description': description,
      if (district != null) 'district': district,
      if (state != null) 'state': state,
      if (country != null) 'country': country,
      if (maleSeen != null) 'male_seen': maleSeen,
      if (femaleSeen != null) 'female_seen': femaleSeen,
      if (likes0Count != null) 'likes0_count': likes0Count,
      if (likes1Count != null) 'likes1_count': likes1Count,
      if (likes2Count != null) 'likes2_count': likes2Count,
      if (commentsCount != null) 'comments_count': commentsCount,
      if (price != null) 'price': price,
      if (purchaseUrl != null) 'purchase_url': purchaseUrl,
      if (productName != null) 'product_name': productName,
      if (buttonName != null) 'button_name': buttonName,
      if (typeOf != null) 'type_of': typeOf,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userId != null) 'user_id': userId,
      if (userName != null) 'user_name': userName,
      if (name != null) 'name': name,
      if (userBio != null) 'user_bio': userBio,
      if (userType != null) 'user_type': userType,
      if (userProfileImage != null) 'user_profile_image': userProfileImage,
      if (followStatus != null) 'follow_status': followStatus,
      if (isUpdate != null) 'is_update': isUpdate,
      if (likeStatus != null) 'like_status': likeStatus,
    });
  }

  PostModelCompanion copyWith(
      {Value<String>? postId,
        Value<String>? description,
        Value<String>? district,
        Value<String>? state,
        Value<String>? country,
        Value<int>? maleSeen,
        Value<int>? femaleSeen,
        Value<int>? likes0Count,
        Value<int>? likes1Count,
        Value<int>? likes2Count,
        Value<int>? commentsCount,
        Value<String>? price,
        Value<String>? purchaseUrl,
        Value<String>? productName,
        Value<String>? buttonName,
        Value<String>? typeOf,
        Value<String>? createdAt,
        Value<String>? updatedAt,
        Value<String>? userId,
        Value<String>? userName,
        Value<String>? name,
        Value<String>? userBio,
        Value<String>? userType,
        Value<String>? userProfileImage,
        Value<bool>? followStatus,
        Value<bool>? isUpdate,
        Value<int>? likeStatus}) {
    return PostModelCompanion(
      postId: postId ?? this.postId,
      description: description ?? this.description,
      district: district ?? this.district,
      state: state ?? this.state,
      country: country ?? this.country,
      maleSeen: maleSeen ?? this.maleSeen,
      femaleSeen: femaleSeen ?? this.femaleSeen,
      likes0Count: likes0Count ?? this.likes0Count,
      likes1Count: likes1Count ?? this.likes1Count,
      likes2Count: likes2Count ?? this.likes2Count,
      commentsCount: commentsCount ?? this.commentsCount,
      price: price ?? this.price,
      purchaseUrl: purchaseUrl ?? this.purchaseUrl,
      productName: productName ?? this.productName,
      buttonName: buttonName ?? this.buttonName,
      typeOf: typeOf ?? this.typeOf,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      name: name ?? this.name,
      userBio: userBio ?? this.userBio,
      userType: userType ?? this.userType,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      followStatus: followStatus ?? this.followStatus,
      isUpdate: isUpdate ?? this.isUpdate,
      likeStatus: likeStatus ?? this.likeStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (postId.present) {
      map['post_id'] = Variable<String>(postId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (maleSeen.present) {
      map['male_seen'] = Variable<int>(maleSeen.value);
    }
    if (femaleSeen.present) {
      map['female_seen'] = Variable<int>(femaleSeen.value);
    }
    if (likes0Count.present) {
      map['likes0_count'] = Variable<int>(likes0Count.value);
    }
    if (likes1Count.present) {
      map['likes1_count'] = Variable<int>(likes1Count.value);
    }
    if (likes2Count.present) {
      map['likes2_count'] = Variable<int>(likes2Count.value);
    }
    if (commentsCount.present) {
      map['comments_count'] = Variable<int>(commentsCount.value);
    }
    if (price.present) {
      map['price'] = Variable<String>(price.value);
    }
    if (purchaseUrl.present) {
      map['purchase_url'] = Variable<String>(purchaseUrl.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (buttonName.present) {
      map['button_name'] = Variable<String>(buttonName.value);
    }
    if (typeOf.present) {
      map['type_of'] = Variable<String>(typeOf.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (userBio.present) {
      map['user_bio'] = Variable<String>(userBio.value);
    }
    if (userType.present) {
      map['user_type'] = Variable<String>(userType.value);
    }
    if (userProfileImage.present) {
      map['user_profile_image'] = Variable<String>(userProfileImage.value);
    }
    if (followStatus.present) {
      map['follow_status'] = Variable<bool>(followStatus.value);
    }
    if (isUpdate.present) {
      map['is_update'] = Variable<bool>(isUpdate.value);
    }
    if (likeStatus.present) {
      map['like_status'] = Variable<int>(likeStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostModelCompanion(')
      ..write('postId: $postId, ')
      ..write('description: $description, ')
      ..write('district: $district, ')
      ..write('state: $state, ')
      ..write('country: $country, ')
      ..write('maleSeen: $maleSeen, ')
      ..write('femaleSeen: $femaleSeen, ')
      ..write('likes0Count: $likes0Count, ')
      ..write('likes1Count: $likes1Count, ')
      ..write('likes2Count: $likes2Count, ')
      ..write('commentsCount: $commentsCount, ')
      ..write('price: $price, ')
      ..write('purchaseUrl: $purchaseUrl, ')
      ..write('productName: $productName, ')
      ..write('buttonName: $buttonName, ')
      ..write('typeOf: $typeOf, ')
      ..write('createdAt: $createdAt, ')
      ..write('updatedAt: $updatedAt, ')
      ..write('userId: $userId, ')
      ..write('userName: $userName, ')
      ..write('name: $name, ')
      ..write('userBio: $userBio, ')
      ..write('userType: $userType, ')
      ..write('userProfileImage: $userProfileImage, ')
      ..write('followStatus: $followStatus, ')
      ..write('isUpdate: $isUpdate, ')
      ..write('likeStatus: $likeStatus')
      ..write(')'))
        .toString();
  }
}

class $PostModelTable extends PostModel
    with TableInfo<$PostModelTable, PostModelData> {
  late GeneratedDatabase _db;
  late String? _alias;
  $PostModelTable(this._db, [this._alias]);
  final VerificationMeta _postIdMeta = const VerificationMeta('postId');
  late GeneratedColumn<String> _postId;
  @override
  GeneratedColumn<String> get postId =>
      GeneratedColumn<String>('post_id', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  @override
  // GeneratedColumn get postId1 => GeneratedColumn(type: ,'post_id' );
  final VerificationMeta _descriptionMeta =
  const VerificationMeta('description');
  late GeneratedColumn<String> _description;
  @override
  GeneratedColumn<String> get description =>
      GeneratedColumn<String>('description', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _districtMeta = const VerificationMeta('district');
  late GeneratedColumn<String> _district;
  @override
  GeneratedColumn<String> get district =>
      GeneratedColumn<String>('district', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _stateMeta = const VerificationMeta('state');
  late GeneratedColumn<String> _state;

  @override
  GeneratedColumn<String> get state =>
      GeneratedColumn<String>('state', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _countryMeta = const VerificationMeta('country');
  late GeneratedColumn<String> _country;
  @override
  GeneratedColumn<String> get country =>
      GeneratedColumn<String>('country', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _maleSeenMeta = const VerificationMeta('maleSeen');
  late GeneratedColumn<int> _maleSeen;
  @override
  GeneratedColumn<int> get maleSeen =>
      GeneratedColumn<int>('male_seen', aliasedName, false,
          $customConstraints: 'INTEGER',
          requiredDuringInsert: true,
          type: DriftSqlType.int);
  final VerificationMeta _femaleSeenMeta = const VerificationMeta('femaleSeen');
  late GeneratedColumn<int> _femaleSeen;
  @override
  GeneratedColumn<int> get femaleSeen =>
      GeneratedColumn<int>('female_seen', aliasedName, false,
          $customConstraints: 'INTEGER',
          requiredDuringInsert: true,
          type: DriftSqlType.int);
  final VerificationMeta _likes0CountMeta =
  const VerificationMeta('likes0Count');
  late GeneratedColumn<int> _likes0Count;
  @override
  GeneratedColumn<int> get likes0Count =>
      GeneratedColumn<int>('likes0_count', aliasedName, false,
          $customConstraints: 'INTEGER',
          requiredDuringInsert: true,
          type: DriftSqlType.int);
  final VerificationMeta _likes1CountMeta =
  const VerificationMeta('likes1Count');
  late GeneratedColumn<int> _likes1Count;
  @override
  GeneratedColumn<int> get likes1Count =>
      GeneratedColumn<int>('likes1_count', aliasedName, false,
          $customConstraints: 'INTEGER',
          requiredDuringInsert: true,
          type: DriftSqlType.int);
  final VerificationMeta _likes2CountMeta =
  const VerificationMeta('likes2Count');
  late GeneratedColumn<int> _likes2Count;
  @override
  GeneratedColumn<int> get likes2Count =>
      GeneratedColumn<int>('likes2_count', aliasedName, false,
          $customConstraints: 'INTEGER',
          requiredDuringInsert: true,
          type: DriftSqlType.int);
  final VerificationMeta _commentsCountMeta =
  const VerificationMeta('commentsCount');
  late GeneratedColumn<int> _commentsCount;
  @override
  GeneratedColumn<int> get commentsCount =>
      GeneratedColumn<int>('comments_count', aliasedName, false,
          $customConstraints: 'INTEGER',
          requiredDuringInsert: true,
          type: DriftSqlType.int);
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  late GeneratedColumn<String> _price;
  @override
  GeneratedColumn<String> get price =>
      GeneratedColumn<String>('price', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _purchaseUrlMeta =
  const VerificationMeta('purchaseUrl');
  late GeneratedColumn<String> _purchaseUrl;
  @override
  GeneratedColumn<String> get purchaseUrl =>
      GeneratedColumn<String>('purchase_url', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _productNameMeta =
  const VerificationMeta('productName');
  late GeneratedColumn<String> _productName;
  @override
  GeneratedColumn<String> get productName =>
      GeneratedColumn<String>('product_name', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _buttonNameMeta = const VerificationMeta('buttonName');
  late GeneratedColumn<String> _buttonName;
  @override
  GeneratedColumn<String> get buttonName =>
      GeneratedColumn<String>('button_name', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _typeOfMeta = const VerificationMeta('typeOf');
  late GeneratedColumn<String> _typeOf;
  @override
  GeneratedColumn<String> get typeOf =>
      GeneratedColumn<String>('type_of', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late GeneratedColumn<String> _createdAt;
  @override
  GeneratedColumn<String> get createdAt =>
      GeneratedColumn<String>('created_at', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  late GeneratedColumn<String> _updatedAt;
  @override
  GeneratedColumn<String> get updatedAt =>
      GeneratedColumn<String>('updated_at', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late GeneratedColumn<String> _userId;
  @override
  GeneratedColumn<String> get userId =>
      GeneratedColumn<String>('user_id', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _userNameMeta = const VerificationMeta('userName');
  late GeneratedColumn<String> _userName;
  @override
  GeneratedColumn<String> get userName =>
      GeneratedColumn<String>('user_name', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late GeneratedColumn<String> _name;
  @override
  GeneratedColumn<String> get name =>
      GeneratedColumn<String>('name', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _userBioMeta = const VerificationMeta('userBio');
  late GeneratedColumn<String> _userBio;
  @override
  GeneratedColumn<String> get userBio =>
      GeneratedColumn<String>('user_bio', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _userTypeMeta = const VerificationMeta('userType');
  late GeneratedColumn<String> _userType;
  @override
  GeneratedColumn<String> get userType =>
      GeneratedColumn<String>('user_type', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _userProfileImageMeta =
  const VerificationMeta('userProfileImage');
  late GeneratedColumn<String> _userProfileImage;
  @override
  GeneratedColumn<String> get userProfileImage =>
      GeneratedColumn<String>('user_profile_image', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _followStatusMeta =
  const VerificationMeta('followStatus');
  late GeneratedColumn<bool> _followStatus;
  @override
  GeneratedColumn<bool> get followStatus =>
      GeneratedColumn<bool>('follow_status', aliasedName, false,
          $customConstraints: 'INTEGER',
          requiredDuringInsert: true,
          type: DriftSqlType.bool,
          //defaultConstraints: 'CHECK (follow_status IN (0, 1))'
      );
  final VerificationMeta _isUpdateMeta = const VerificationMeta('isUpdate');
  late GeneratedColumn<bool> _isUpdate;
  @override
  GeneratedColumn<bool> get isUpdate =>
      GeneratedColumn<bool>('is_update', aliasedName, false,
          $customConstraints: 'INTEGER',
          requiredDuringInsert: true,
          type: DriftSqlType.bool,
          //defaultConstraints: 'CHECK (is_update IN (0, 1))'
      );
  final VerificationMeta _likeStatusMeta = const VerificationMeta('likeStatus');
  late GeneratedColumn<int> _likeStatus;
  @override
  GeneratedColumn<int> get likeStatus =>
      GeneratedColumn<int>('like_status', aliasedName, false,
          $customConstraints: 'INTEGER',
          requiredDuringInsert: true,
          type: DriftSqlType.int);
  @override
  List<GeneratedColumn> get $columns => [
    postId,
    description,
    district,
    state,
    country,
    maleSeen,
    femaleSeen,
    likes0Count,
    likes1Count,
    likes2Count,
    commentsCount,
    price,
    purchaseUrl,
    productName,
    buttonName,
    typeOf,
    createdAt,
    updatedAt,
    userId,
    userName,
    name,
    userBio,
    userType,
    userProfileImage,
    followStatus,
    isUpdate,
    likeStatus
  ];
  @override
  String get aliasedName => _alias ?? 'post_model';
  @override
  String get actualTableName => 'post_model';
  @override
  VerificationContext validateIntegrity(Insertable<PostModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('post_id')) {
      context.handle(_postIdMeta,
          postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta));
    } else if (isInserting) {
      context.missing(_postIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('district')) {
      context.handle(_districtMeta,
          district.isAcceptableOrUnknown(data['district']!, _districtMeta));
    } else if (isInserting) {
      context.missing(_districtMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('male_seen')) {
      context.handle(_maleSeenMeta,
          maleSeen.isAcceptableOrUnknown(data['male_seen']!, _maleSeenMeta));
    } else if (isInserting) {
      context.missing(_maleSeenMeta);
    }
    if (data.containsKey('female_seen')) {
      context.handle(
          _femaleSeenMeta,
          femaleSeen.isAcceptableOrUnknown(
              data['female_seen']!, _femaleSeenMeta));
    } else if (isInserting) {
      context.missing(_femaleSeenMeta);
    }
    if (data.containsKey('likes0_count')) {
      context.handle(
          _likes0CountMeta,
          likes0Count.isAcceptableOrUnknown(
              data['likes0_count']!, _likes0CountMeta));
    } else if (isInserting) {
      context.missing(_likes0CountMeta);
    }
    if (data.containsKey('likes1_count')) {
      context.handle(
          _likes1CountMeta,
          likes1Count.isAcceptableOrUnknown(
              data['likes1_count']!, _likes1CountMeta));
    } else if (isInserting) {
      context.missing(_likes1CountMeta);
    }
    if (data.containsKey('likes2_count')) {
      context.handle(
          _likes2CountMeta,
          likes2Count.isAcceptableOrUnknown(
              data['likes2_count']!, _likes2CountMeta));
    } else if (isInserting) {
      context.missing(_likes2CountMeta);
    }
    if (data.containsKey('comments_count')) {
      context.handle(
          _commentsCountMeta,
          commentsCount.isAcceptableOrUnknown(
              data['comments_count']!, _commentsCountMeta));
    } else if (isInserting) {
      context.missing(_commentsCountMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('purchase_url')) {
      context.handle(
          _purchaseUrlMeta,
          purchaseUrl.isAcceptableOrUnknown(
              data['purchase_url']!, _purchaseUrlMeta));
    } else if (isInserting) {
      context.missing(_purchaseUrlMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('button_name')) {
      context.handle(
          _buttonNameMeta,
          buttonName.isAcceptableOrUnknown(
              data['button_name']!, _buttonNameMeta));
    } else if (isInserting) {
      context.missing(_buttonNameMeta);
    }
    if (data.containsKey('type_of')) {
      context.handle(_typeOfMeta,
          typeOf.isAcceptableOrUnknown(data['type_of']!, _typeOfMeta));
    } else if (isInserting) {
      context.missing(_typeOfMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('user_bio')) {
      context.handle(_userBioMeta,
          userBio.isAcceptableOrUnknown(data['user_bio']!, _userBioMeta));
    } else if (isInserting) {
      context.missing(_userBioMeta);
    }
    if (data.containsKey('user_type')) {
      context.handle(_userTypeMeta,
          userType.isAcceptableOrUnknown(data['user_type']!, _userTypeMeta));
    } else if (isInserting) {
      context.missing(_userTypeMeta);
    }
    if (data.containsKey('user_profile_image')) {
      context.handle(
          _userProfileImageMeta,
          userProfileImage.isAcceptableOrUnknown(
              data['user_profile_image']!, _userProfileImageMeta));
    } else if (isInserting) {
      context.missing(_userProfileImageMeta);
    }
    if (data.containsKey('follow_status')) {
      context.handle(
          _followStatusMeta,
          followStatus.isAcceptableOrUnknown(
              data['follow_status']!, _followStatusMeta));
    } else if (isInserting) {
      context.missing(_followStatusMeta);
    }
    if (data.containsKey('is_update')) {
      context.handle(_isUpdateMeta,
          isUpdate.isAcceptableOrUnknown(data['is_update']!, _isUpdateMeta));
    } else if (isInserting) {
      context.missing(_isUpdateMeta);
    }
    if (data.containsKey('like_status')) {
      context.handle(
          _likeStatusMeta,
          likeStatus.isAcceptableOrUnknown(
              data['like_status']!, _likeStatusMeta));
    } else if (isInserting) {
      context.missing(_likeStatusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {postId};
  @override
  PostModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PostModelData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PostModelTable createAlias(String alias) {
    return $PostModelTable(_db, alias);
  }

  @override
  // TODO: implement attachedDatabase
  DatabaseConnectionUser get attachedDatabase => throw UnimplementedError();
}

class ChallengesModelData extends DataClass
    implements Insertable<ChallengesModelData> {
  final String id;
  final String challengeId;
  final String postId;
  final String challengeName;
  ChallengesModelData(
      {required this.id,
        required this.challengeId,
        required this.postId,
        required this.challengeName});
  factory ChallengesModelData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ChallengesModelData(
      id: data['${effectivePrefix}id']!,
      challengeId: data['${effectivePrefix}challenge_id']!,
      postId: data['${effectivePrefix}post_id']!,
      challengeName: data['${effectivePrefix}challenge_name']!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || challengeId != null) {
      map['challenge_id'] = Variable<String>(challengeId);
    }
    if (!nullToAbsent || postId != null) {
      map['post_id'] = Variable<String>(postId);
    }
    if (!nullToAbsent || challengeName != null) {
      map['challenge_name'] = Variable<String>(challengeName);
    }
    return map;
  }

  ChallengesModelCompanion toCompanion(bool nullToAbsent) {
    return ChallengesModelCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      challengeId: challengeId == null && nullToAbsent
          ? const Value.absent()
          : Value(challengeId),
      postId:
      postId == null && nullToAbsent ? const Value.absent() : Value(postId),
      challengeName: challengeName == null && nullToAbsent
          ? const Value.absent()
          : Value(challengeName),
    );
  }

  factory ChallengesModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChallengesModelData(
      id: serializer.fromJson<String>(json['id']),
      challengeId: serializer.fromJson<String>(json['challengeId']),
      postId: serializer.fromJson<String>(json['postId']),
      challengeName: serializer.fromJson<String>(json['challengeName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'challengeId': serializer.toJson<String>(challengeId),
      'postId': serializer.toJson<String>(postId),
      'challengeName': serializer.toJson<String>(challengeName),
    };
  }

  ChallengesModelData copyWith(
      {String? id,
        String? challengeId,
        String? postId,
        String? challengeName}) =>
      ChallengesModelData(
        id: id ?? this.id,
        challengeId: challengeId ?? this.challengeId,
        postId: postId ?? this.postId,
        challengeName: challengeName ?? this.challengeName,
      );
  @override
  String toString() {
    return (StringBuffer('ChallengesModelData(')
      ..write('id: $id, ')
      ..write('challengeId: $challengeId, ')
      ..write('postId: $postId, ')
      ..write('challengeName: $challengeName')
      ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, challengeId, postId, challengeName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is ChallengesModelData &&
              other.id == this.id &&
              other.challengeId == this.challengeId &&
              other.postId == this.postId &&
              other.challengeName == this.challengeName);
}

class ChallengesModelCompanion extends UpdateCompanion<ChallengesModelData> {
  final Value<String> id;
  final Value<String> challengeId;
  final Value<String> postId;
  final Value<String> challengeName;
  const ChallengesModelCompanion({
    this.id = const Value.absent(),
    this.challengeId = const Value.absent(),
    this.postId = const Value.absent(),
    this.challengeName = const Value.absent(),
  });
  ChallengesModelCompanion.insert({
    required String id,
    required String challengeId,
    required String postId,
    required String challengeName,
  })  : id = Value(id),
        challengeId = Value(challengeId),
        postId = Value(postId),
        challengeName = Value(challengeName);
  static Insertable<ChallengesModelData> custom({
    Expression<String>? id,
    Expression<String>? challengeId,
    Expression<String>? postId,
    Expression<String>? challengeName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (challengeId != null) 'challenge_id': challengeId,
      if (postId != null) 'post_id': postId,
      if (challengeName != null) 'challenge_name': challengeName,
    });
  }

  ChallengesModelCompanion copyWith(
      {Value<String>? id,
        Value<String>? challengeId,
        Value<String>? postId,
        Value<String>? challengeName}) {
    return ChallengesModelCompanion(
      id: id ?? this.id,
      challengeId: challengeId ?? this.challengeId,
      postId: postId ?? this.postId,
      challengeName: challengeName ?? this.challengeName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (challengeId.present) {
      map['challenge_id'] = Variable<String>(challengeId.value);
    }
    if (postId.present) {
      map['post_id'] = Variable<String>(postId.value);
    }
    if (challengeName.present) {
      map['challenge_name'] = Variable<String>(challengeName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChallengesModelCompanion(')
      ..write('id: $id, ')
      ..write('challengeId: $challengeId, ')
      ..write('postId: $postId, ')
      ..write('challengeName: $challengeName')
      ..write(')'))
        .toString();
  }
}

class $ChallengesModelTable extends ChallengesModel
    with TableInfo<$ChallengesModelTable, ChallengesModelData> {
  GeneratedDatabase? _db;
  String? _alias;
  $ChallengesModelTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late GeneratedColumn<String> _id;
  @override
  GeneratedColumn<String> get id =>
      GeneratedColumn<String>('id', aliasedName, false,
          // $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          $customConstraints: 'UNIQUE',
          type: DriftSqlType.string);
  final VerificationMeta _challengeIdMeta =
  const VerificationMeta('challengeId');
  late GeneratedColumn<String> _challengeId;
  @override
  GeneratedColumn<String> get challengeId =>
      GeneratedColumn<String>('challenge_id', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _postIdMeta = const VerificationMeta('postId');
  late GeneratedColumn<String> _postId;
  @override
  GeneratedColumn<String> get postId =>
      GeneratedColumn<String>('post_id', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _challengeNameMeta =
  const VerificationMeta('challengeName');
  late GeneratedColumn<String> _challengeName;
  @override
  GeneratedColumn<String> get challengeName =>
      GeneratedColumn<String>('challenge_name', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  @override
  List<GeneratedColumn> get $columns =>
      [id, challengeId, postId, challengeName];
  @override
  String get aliasedName => _alias ?? 'challenges_model';
  @override
  String get actualTableName => 'challenges_model';
  @override
  VerificationContext validateIntegrity(
      Insertable<ChallengesModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('challenge_id')) {
      context.handle(
          _challengeIdMeta,
          challengeId.isAcceptableOrUnknown(
              data['challenge_id']!, _challengeIdMeta));
    } else if (isInserting) {
      context.missing(_challengeIdMeta);
    }
    if (data.containsKey('post_id')) {
      context.handle(_postIdMeta,
          postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta));
    } else if (isInserting) {
      context.missing(_postIdMeta);
    }
    if (data.containsKey('challenge_name')) {
      context.handle(
          _challengeNameMeta,
          challengeName.isAcceptableOrUnknown(
              data['challenge_name']!, _challengeNameMeta));
    } else if (isInserting) {
      context.missing(_challengeNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChallengesModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ChallengesModelData.fromData(data, _db!,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ChallengesModelTable createAlias(String alias) {
    return $ChallengesModelTable(_db, alias);
  }

  @override
  // TODO: implement attachedDatabase
  DatabaseConnectionUser get attachedDatabase => throw UnimplementedError();
}

class MediaModelData extends DataClass implements Insertable<MediaModelData> {
  final String mediaPath;
  final String postId;
  final String mediaType;
  MediaModelData(
      {required this.mediaPath, required this.postId, required this.mediaType});
  factory MediaModelData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MediaModelData(
      mediaPath: data['${effectivePrefix}media_path']!,
      postId: data['${effectivePrefix}post_id']!,
      mediaType: data['${effectivePrefix}media_type']!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || mediaPath != null) {
      map['media_path'] = Variable<String>(mediaPath);
    }
    if (!nullToAbsent || postId != null) {
      map['post_id'] = Variable<String>(postId);
    }
    if (!nullToAbsent || mediaType != null) {
      map['media_type'] = Variable<String>(mediaType);
    }
    return map;
  }

  MediaModelCompanion toCompanion(bool nullToAbsent) {
    return MediaModelCompanion(
      mediaPath: mediaPath == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaPath),
      postId:
      postId == null && nullToAbsent ? const Value.absent() : Value(postId),
      mediaType: mediaType == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaType),
    );
  }

  factory MediaModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaModelData(
      mediaPath: serializer.fromJson<String>(json['mediaPath']),
      postId: serializer.fromJson<String>(json['postId']),
      mediaType: serializer.fromJson<String>(json['mediaType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mediaPath': serializer.toJson<String>(mediaPath),
      'postId': serializer.toJson<String>(postId),
      'mediaType': serializer.toJson<String>(mediaType),
    };
  }

  MediaModelData copyWith(
      {String? mediaPath, String? postId, String? mediaType}) =>
      MediaModelData(
        mediaPath: mediaPath ?? this.mediaPath,
        postId: postId ?? this.postId,
        mediaType: mediaType ?? this.mediaType,
      );
  @override
  String toString() {
    return (StringBuffer('MediaModelData(')
      ..write('mediaPath: $mediaPath, ')
      ..write('postId: $postId, ')
      ..write('mediaType: $mediaType')
      ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(mediaPath, postId, mediaType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is MediaModelData &&
              other.mediaPath == this.mediaPath &&
              other.postId == this.postId &&
              other.mediaType == this.mediaType);
}

class MediaModelCompanion extends UpdateCompanion<MediaModelData> {
  final Value<String> mediaPath;
  final Value<String> postId;
  final Value<String> mediaType;
  const MediaModelCompanion({
    this.mediaPath = const Value.absent(),
    this.postId = const Value.absent(),
    this.mediaType = const Value.absent(),
  });
  MediaModelCompanion.insert({
    required String mediaPath,
    required String postId,
    required String mediaType,
  })  : mediaPath = Value(mediaPath),
        postId = Value(postId),
        mediaType = Value(mediaType);
  static Insertable<MediaModelData> custom({
    Expression<String>? mediaPath,
    Expression<String>? postId,
    Expression<String>? mediaType,
  }) {
    return RawValuesInsertable({
      if (mediaPath != null) 'media_path': mediaPath,
      if (postId != null) 'post_id': postId,
      if (mediaType != null) 'media_type': mediaType,
    });
  }

  MediaModelCompanion copyWith(
      {Value<String>? mediaPath,
        Value<String>? postId,
        Value<String>? mediaType}) {
    return MediaModelCompanion(
      mediaPath: mediaPath ?? this.mediaPath,
      postId: postId ?? this.postId,
      mediaType: mediaType ?? this.mediaType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mediaPath.present) {
      map['media_path'] = Variable<String>(mediaPath.value);
    }
    if (postId.present) {
      map['post_id'] = Variable<String>(postId.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<String>(mediaType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaModelCompanion(')
      ..write('mediaPath: $mediaPath, ')
      ..write('postId: $postId, ')
      ..write('mediaType: $mediaType')
      ..write(')'))
        .toString();
  }
}

class $MediaModelTable extends MediaModel
    with TableInfo<$MediaModelTable, MediaModelData> {
  GeneratedDatabase? _db;
  String? _alias;
  $MediaModelTable([this._db, this._alias]);
  final VerificationMeta _mediaPathMeta = const VerificationMeta('mediaPath');
  late GeneratedColumn<String> _mediaPath;
  @override
  GeneratedColumn<String> get mediaPath =>
      GeneratedColumn<String>('media_path', aliasedName, false,
          requiredDuringInsert: true,
          $customConstraints: 'UNIQUE',
          type: DriftSqlType.string);
  final VerificationMeta _postIdMeta = const VerificationMeta('postId');
  late GeneratedColumn<String> _postId;
  @override
  GeneratedColumn<String> get postId =>
      GeneratedColumn<String>('post_id', aliasedName, false,
          $customConstraints: 'TEXT',
          requiredDuringInsert: true,
          type: DriftSqlType.string);
  final VerificationMeta _mediaTypeMeta = const VerificationMeta('mediaType');
  late GeneratedColumn<String> _mediaType;
  @override
  GeneratedColumn<String> get mediaType =>
      GeneratedColumn<String>('media_type', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  @override
  List<GeneratedColumn> get $columns => [mediaPath, postId, mediaType];
  @override
  String get aliasedName => _alias ?? 'media_model';
  @override
  String get actualTableName => 'media_model';
  @override
  VerificationContext validateIntegrity(Insertable<MediaModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('media_path')) {
      context.handle(_mediaPathMeta,
          mediaPath.isAcceptableOrUnknown(data['media_path']!, _mediaPathMeta));
    } else if (isInserting) {
      context.missing(_mediaPathMeta);
    }
    if (data.containsKey('post_id')) {
      context.handle(_postIdMeta,
          postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta));
    } else if (isInserting) {
      context.missing(_postIdMeta);
    }
    if (data.containsKey('media_type')) {
      context.handle(_mediaTypeMeta,
          mediaType.isAcceptableOrUnknown(data['media_type']!, _mediaTypeMeta));
    } else if (isInserting) {
      context.missing(_mediaTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mediaPath};
  @override
  MediaModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MediaModelData.fromData(data, _db!,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MediaModelTable createAlias(String alias) {
    return $MediaModelTable(_db, alias);
  }

  @override
  // TODO: implement attachedDatabase
  DatabaseConnectionUser get attachedDatabase => throw UnimplementedError();
}

class FunlinkPostModelData extends DataClass
    implements Insertable<FunlinkPostModelData> {
  final String postId;
  final String description;
  final String district;
  final String state;
  final String country;
  final int seen;
  final int likesCount;
  final int commentsCount;
  final String createdAt;
  final String updatedAt;
  final String userId;
  final String userName;
  final String name;
  final String userBio;
  final String typeOf;
  final String userProfileImage;
  final String musicName;
  final String musicId;
  final String userType;
  final String audio;
  final bool followStatus;
  final int likeStatus;
  final bool isUpdate;
  FunlinkPostModelData(
      {required this.postId,
        required this.description,
        required this.district,
        required this.state,
        required this.country,
        required this.seen,
        required this.likesCount,
        required this.commentsCount,
        required this.createdAt,
        required this.updatedAt,
        required this.userId,
        required this.userName,
        required this.name,
        required this.userBio,
        required this.typeOf,
        required this.userProfileImage,
        required this.musicName,
        required this.musicId,
        required this.userType,
        required this.audio,
        required this.followStatus,
        required this.likeStatus,
        required this.isUpdate});
  factory FunlinkPostModelData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FunlinkPostModelData(
      postId: data['${effectivePrefix}post_id']!,
      description: data['${effectivePrefix}description']!,
      district: data['${effectivePrefix}district']!,
      state: data['${effectivePrefix}state']!,
      country: data['${effectivePrefix}country']!,
      seen: data['${effectivePrefix}seen']!,
      likesCount: data['${effectivePrefix}likes_count']!,
      commentsCount: data['${effectivePrefix}comments_count']!,
      createdAt: data['${effectivePrefix}created_at']!,
      updatedAt: data['${effectivePrefix}updated_at']!,
      userId: data['${effectivePrefix}user_id']!,
      userName: data['${effectivePrefix}user_name']!,
      name: data['${effectivePrefix}name']!,
      userBio: data['${effectivePrefix}user_bio']!,
      typeOf: data['${effectivePrefix}type_of']!,
      userProfileImage: data['${effectivePrefix}user_profile_image']!,
      musicName: data['${effectivePrefix}music_name']!,
      musicId: data['${effectivePrefix}music_id']!,
      userType: data['${effectivePrefix}user_type']!,
      audio: data['${effectivePrefix}audio']!,
      followStatus: data['${effectivePrefix}follow_status']!,
      likeStatus: data['${effectivePrefix}like_status']!,
      isUpdate: data['${effectivePrefix}is_update']!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || postId != null) {
      map['post_id'] = Variable<String>(postId);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || district != null) {
      map['district'] = Variable<String>(district);
    }
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<String>(state);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || seen != null) {
      map['seen'] = Variable<int>(seen);
    }
    if (!nullToAbsent || likesCount != null) {
      map['likes_count'] = Variable<int>(likesCount);
    }
    if (!nullToAbsent || commentsCount != null) {
      map['comments_count'] = Variable<int>(commentsCount);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || userName != null) {
      map['user_name'] = Variable<String>(userName);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || userBio != null) {
      map['user_bio'] = Variable<String>(userBio);
    }
    if (!nullToAbsent || typeOf != null) {
      map['type_of'] = Variable<String>(typeOf);
    }
    if (!nullToAbsent || userProfileImage != null) {
      map['user_profile_image'] = Variable<String>(userProfileImage);
    }
    if (!nullToAbsent || musicName != null) {
      map['music_name'] = Variable<String>(musicName);
    }
    if (!nullToAbsent || musicId != null) {
      map['music_id'] = Variable<String>(musicId);
    }
    if (!nullToAbsent || userType != null) {
      map['user_type'] = Variable<String>(userType);
    }
    if (!nullToAbsent || audio != null) {
      map['audio'] = Variable<String>(audio);
    }
    if (!nullToAbsent || followStatus != null) {
      map['follow_status'] = Variable<bool>(followStatus);
    }
    if (!nullToAbsent || likeStatus != null) {
      map['like_status'] = Variable<int>(likeStatus);
    }
    if (!nullToAbsent || isUpdate != null) {
      map['is_update'] = Variable<bool>(isUpdate);
    }
    return map;
  }

  FunlinkPostModelCompanion toCompanion(bool nullToAbsent) {
    return FunlinkPostModelCompanion(
      postId:
      postId == null && nullToAbsent ? const Value.absent() : Value(postId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
      state:
      state == null && nullToAbsent ? const Value.absent() : Value(state),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      seen: seen == null && nullToAbsent ? const Value.absent() : Value(seen),
      likesCount: likesCount == null && nullToAbsent
          ? const Value.absent()
          : Value(likesCount),
      commentsCount: commentsCount == null && nullToAbsent
          ? const Value.absent()
          : Value(commentsCount),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      userId:
      userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      userName: userName == null && nullToAbsent
          ? const Value.absent()
          : Value(userName),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      userBio: userBio == null && nullToAbsent
          ? const Value.absent()
          : Value(userBio),
      typeOf:
      typeOf == null && nullToAbsent ? const Value.absent() : Value(typeOf),
      userProfileImage: userProfileImage == null && nullToAbsent
          ? const Value.absent()
          : Value(userProfileImage),
      musicName: musicName == null && nullToAbsent
          ? const Value.absent()
          : Value(musicName),
      musicId: musicId == null && nullToAbsent
          ? const Value.absent()
          : Value(musicId),
      userType: userType == null && nullToAbsent
          ? const Value.absent()
          : Value(userType),
      audio:
      audio == null && nullToAbsent ? const Value.absent() : Value(audio),
      followStatus: followStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(followStatus),
      likeStatus: likeStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(likeStatus),
      isUpdate: isUpdate == null && nullToAbsent
          ? const Value.absent()
          : Value(isUpdate),
    );
  }

  factory FunlinkPostModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FunlinkPostModelData(
      postId: serializer.fromJson<String>(json['postId']),
      description: serializer.fromJson<String>(json['description']),
      district: serializer.fromJson<String>(json['district']),
      state: serializer.fromJson<String>(json['state']),
      country: serializer.fromJson<String>(json['country']),
      seen: serializer.fromJson<int>(json['seen']),
      likesCount: serializer.fromJson<int>(json['likesCount']),
      commentsCount: serializer.fromJson<int>(json['commentsCount']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      userId: serializer.fromJson<String>(json['userId']),
      userName: serializer.fromJson<String>(json['userName']),
      name: serializer.fromJson<String>(json['name']),
      userBio: serializer.fromJson<String>(json['userBio']),
      typeOf: serializer.fromJson<String>(json['typeOf']),
      userProfileImage: serializer.fromJson<String>(json['userProfileImage']),
      musicName: serializer.fromJson<String>(json['musicName']),
      musicId: serializer.fromJson<String>(json['musicId']),
      userType: serializer.fromJson<String>(json['userType']),
      audio: serializer.fromJson<String>(json['audio']),
      followStatus: serializer.fromJson<bool>(json['followStatus']),
      likeStatus: serializer.fromJson<int>(json['likeStatus']),
      isUpdate: serializer.fromJson<bool>(json['isUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'postId': serializer.toJson<String>(postId),
      'description': serializer.toJson<String>(description),
      'district': serializer.toJson<String>(district),
      'state': serializer.toJson<String>(state),
      'country': serializer.toJson<String>(country),
      'seen': serializer.toJson<int>(seen),
      'likesCount': serializer.toJson<int>(likesCount),
      'commentsCount': serializer.toJson<int>(commentsCount),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'userId': serializer.toJson<String>(userId),
      'userName': serializer.toJson<String>(userName),
      'name': serializer.toJson<String>(name),
      'userBio': serializer.toJson<String>(userBio),
      'typeOf': serializer.toJson<String>(typeOf),
      'userProfileImage': serializer.toJson<String>(userProfileImage),
      'musicName': serializer.toJson<String>(musicName),
      'musicId': serializer.toJson<String>(musicId),
      'userType': serializer.toJson<String>(userType),
      'audio': serializer.toJson<String>(audio),
      'followStatus': serializer.toJson<bool>(followStatus),
      'likeStatus': serializer.toJson<int>(likeStatus),
      'isUpdate': serializer.toJson<bool>(isUpdate),
    };
  }

  FunlinkPostModelData copyWith(
      {String? postId,
        String? description,
        String? district,
        String? state,
        String? country,
        int? seen,
        int? likesCount,
        int? commentsCount,
        String? createdAt,
        String? updatedAt,
        String? userId,
        String? userName,
        String? name,
        String? userBio,
        String? typeOf,
        String? userProfileImage,
        String? musicName,
        String? musicId,
        String? userType,
        String? audio,
        bool? followStatus,
        int? likeStatus,
        bool? isUpdate}) =>
      FunlinkPostModelData(
        postId: postId ?? this.postId,
        description: description ?? this.description,
        district: district ?? this.district,
        state: state ?? this.state,
        country: country ?? this.country,
        seen: seen ?? this.seen,
        likesCount: likesCount ?? this.likesCount,
        commentsCount: commentsCount ?? this.commentsCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        name: name ?? this.name,
        userBio: userBio ?? this.userBio,
        typeOf: typeOf ?? this.typeOf,
        userProfileImage: userProfileImage ?? this.userProfileImage,
        musicName: musicName ?? this.musicName,
        musicId: musicId ?? this.musicId,
        userType: userType ?? this.userType,
        audio: audio ?? this.audio,
        followStatus: followStatus ?? this.followStatus,
        likeStatus: likeStatus ?? this.likeStatus,
        isUpdate: isUpdate ?? this.isUpdate,
      );
  @override
  String toString() {
    return (StringBuffer('FunlinkPostModelData(')
      ..write('postId: $postId, ')
      ..write('description: $description, ')
      ..write('district: $district, ')
      ..write('state: $state, ')
      ..write('country: $country, ')
      ..write('seen: $seen, ')
      ..write('likesCount: $likesCount, ')
      ..write('commentsCount: $commentsCount, ')
      ..write('createdAt: $createdAt, ')
      ..write('updatedAt: $updatedAt, ')
      ..write('userId: $userId, ')
      ..write('userName: $userName, ')
      ..write('name: $name, ')
      ..write('userBio: $userBio, ')
      ..write('typeOf: $typeOf, ')
      ..write('userProfileImage: $userProfileImage, ')
      ..write('musicName: $musicName, ')
      ..write('musicId: $musicId, ')
      ..write('userType: $userType, ')
      ..write('audio: $audio, ')
      ..write('followStatus: $followStatus, ')
      ..write('likeStatus: $likeStatus, ')
      ..write('isUpdate: $isUpdate')
      ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    postId,
    description,
    district,
    state,
    country,
    seen,
    likesCount,
    commentsCount,
    createdAt,
    updatedAt,
    userId,
    userName,
    name,
    userBio,
    typeOf,
    userProfileImage,
    musicName,
    musicId,
    userType,
    audio,
    followStatus,
    likeStatus,
    isUpdate
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is FunlinkPostModelData &&
              other.postId == this.postId &&
              other.description == this.description &&
              other.district == this.district &&
              other.state == this.state &&
              other.country == this.country &&
              other.seen == this.seen &&
              other.likesCount == this.likesCount &&
              other.commentsCount == this.commentsCount &&
              other.createdAt == this.createdAt &&
              other.updatedAt == this.updatedAt &&
              other.userId == this.userId &&
              other.userName == this.userName &&
              other.name == this.name &&
              other.userBio == this.userBio &&
              other.typeOf == this.typeOf &&
              other.userProfileImage == this.userProfileImage &&
              other.musicName == this.musicName &&
              other.musicId == this.musicId &&
              other.userType == this.userType &&
              other.audio == this.audio &&
              other.followStatus == this.followStatus &&
              other.likeStatus == this.likeStatus &&
              other.isUpdate == this.isUpdate);
}

class FunlinkPostModelCompanion extends UpdateCompanion<FunlinkPostModelData> {
  final Value<String> postId;
  final Value<String> description;
  final Value<String> district;
  final Value<String> state;
  final Value<String> country;
  final Value<int> seen;
  final Value<int> likesCount;
  final Value<int> commentsCount;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> userId;
  final Value<String> userName;
  final Value<String> name;
  final Value<String> userBio;
  final Value<String> typeOf;
  final Value<String> userProfileImage;
  final Value<String> musicName;
  final Value<String> musicId;
  final Value<String> userType;
  final Value<String> audio;
  final Value<bool> followStatus;
  final Value<int> likeStatus;
  final Value<bool> isUpdate;
  const FunlinkPostModelCompanion({
    this.postId = const Value.absent(),
    this.description = const Value.absent(),
    this.district = const Value.absent(),
    this.state = const Value.absent(),
    this.country = const Value.absent(),
    this.seen = const Value.absent(),
    this.likesCount = const Value.absent(),
    this.commentsCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.userName = const Value.absent(),
    this.name = const Value.absent(),
    this.userBio = const Value.absent(),
    this.typeOf = const Value.absent(),
    this.userProfileImage = const Value.absent(),
    this.musicName = const Value.absent(),
    this.musicId = const Value.absent(),
    this.userType = const Value.absent(),
    this.audio = const Value.absent(),
    this.followStatus = const Value.absent(),
    this.likeStatus = const Value.absent(),
    this.isUpdate = const Value.absent(),
  });
  FunlinkPostModelCompanion.insert({
    required String postId,
    required String description,
    required String district,
    required String state,
    required String country,
    required int seen,
    required int likesCount,
    required int commentsCount,
    required String createdAt,
    required String updatedAt,
    required String userId,
    required String userName,
    required String name,
    required String userBio,
    required String typeOf,
    required String userProfileImage,
    required String musicName,
    required String musicId,
    required String userType,
    required String audio,
    required bool followStatus,
    required int likeStatus,
    required bool isUpdate,
  })  : postId = Value(postId),
        description = Value(description),
        district = Value(district),
        state = Value(state),
        country = Value(country),
        seen = Value(seen),
        likesCount = Value(likesCount),
        commentsCount = Value(commentsCount),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        userId = Value(userId),
        userName = Value(userName),
        name = Value(name),
        userBio = Value(userBio),
        typeOf = Value(typeOf),
        userProfileImage = Value(userProfileImage),
        musicName = Value(musicName),
        musicId = Value(musicId),
        userType = Value(userType),
        audio = Value(audio),
        followStatus = Value(followStatus),
        likeStatus = Value(likeStatus),
        isUpdate = Value(isUpdate);
  static Insertable<FunlinkPostModelData> custom({
    Expression<String>? postId,
    Expression<String>? description,
    Expression<String>? district,
    Expression<String>? state,
    Expression<String>? country,
    Expression<int>? seen,
    Expression<int>? likesCount,
    Expression<int>? commentsCount,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? userId,
    Expression<String>? userName,
    Expression<String>? name,
    Expression<String>? userBio,
    Expression<String>? typeOf,
    Expression<String>? userProfileImage,
    Expression<String>? musicName,
    Expression<String>? musicId,
    Expression<String>? userType,
    Expression<String>? audio,
    Expression<bool>? followStatus,
    Expression<int>? likeStatus,
    Expression<bool>? isUpdate,
  }) {
    return RawValuesInsertable({
      if (postId != null) 'post_id': postId,
      if (description != null) 'description': description,
      if (district != null) 'district': district,
      if (state != null) 'state': state,
      if (country != null) 'country': country,
      if (seen != null) 'seen': seen,
      if (likesCount != null) 'likes_count': likesCount,
      if (commentsCount != null) 'comments_count': commentsCount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userId != null) 'user_id': userId,
      if (userName != null) 'user_name': userName,
      if (name != null) 'name': name,
      if (userBio != null) 'user_bio': userBio,
      if (typeOf != null) 'type_of': typeOf,
      if (userProfileImage != null) 'user_profile_image': userProfileImage,
      if (musicName != null) 'music_name': musicName,
      if (musicId != null) 'music_id': musicId,
      if (userType != null) 'user_type': userType,
      if (audio != null) 'audio': audio,
      if (followStatus != null) 'follow_status': followStatus,
      if (likeStatus != null) 'like_status': likeStatus,
      if (isUpdate != null) 'is_update': isUpdate,
    });
  }

  FunlinkPostModelCompanion copyWith(
      {Value<String>? postId,
        Value<String>? description,
        Value<String>? district,
        Value<String>? state,
        Value<String>? country,
        Value<int>? seen,
        Value<int>? likesCount,
        Value<int>? commentsCount,
        Value<String>? createdAt,
        Value<String>? updatedAt,
        Value<String>? userId,
        Value<String>? userName,
        Value<String>? name,
        Value<String>? userBio,
        Value<String>? typeOf,
        Value<String>? userProfileImage,
        Value<String>? musicName,
        Value<String>? musicId,
        Value<String>? userType,
        Value<String>? audio,
        Value<bool>? followStatus,
        Value<int>? likeStatus,
        Value<bool>? isUpdate}) {
    return FunlinkPostModelCompanion(
      postId: postId ?? this.postId,
      description: description ?? this.description,
      district: district ?? this.district,
      state: state ?? this.state,
      country: country ?? this.country,
      seen: seen ?? this.seen,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      name: name ?? this.name,
      userBio: userBio ?? this.userBio,
      typeOf: typeOf ?? this.typeOf,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      musicName: musicName ?? this.musicName,
      musicId: musicId ?? this.musicId,
      userType: userType ?? this.userType,
      audio: audio ?? this.audio,
      followStatus: followStatus ?? this.followStatus,
      likeStatus: likeStatus ?? this.likeStatus,
      isUpdate: isUpdate ?? this.isUpdate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (postId.present) {
      map['post_id'] = Variable<String>(postId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (seen.present) {
      map['seen'] = Variable<int>(seen.value);
    }
    if (likesCount.present) {
      map['likes_count'] = Variable<int>(likesCount.value);
    }
    if (commentsCount.present) {
      map['comments_count'] = Variable<int>(commentsCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (userBio.present) {
      map['user_bio'] = Variable<String>(userBio.value);
    }
    if (typeOf.present) {
      map['type_of'] = Variable<String>(typeOf.value);
    }
    if (userProfileImage.present) {
      map['user_profile_image'] = Variable<String>(userProfileImage.value);
    }
    if (musicName.present) {
      map['music_name'] = Variable<String>(musicName.value);
    }
    if (musicId.present) {
      map['music_id'] = Variable<String>(musicId.value);
    }
    if (userType.present) {
      map['user_type'] = Variable<String>(userType.value);
    }
    if (audio.present) {
      map['audio'] = Variable<String>(audio.value);
    }
    if (followStatus.present) {
      map['follow_status'] = Variable<bool>(followStatus.value);
    }
    if (likeStatus.present) {
      map['like_status'] = Variable<int>(likeStatus.value);
    }
    if (isUpdate.present) {
      map['is_update'] = Variable<bool>(isUpdate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FunlinkPostModelCompanion(')
      ..write('postId: $postId, ')
      ..write('description: $description, ')
      ..write('district: $district, ')
      ..write('state: $state, ')
      ..write('country: $country, ')
      ..write('seen: $seen, ')
      ..write('likesCount: $likesCount, ')
      ..write('commentsCount: $commentsCount, ')
      ..write('createdAt: $createdAt, ')
      ..write('updatedAt: $updatedAt, ')
      ..write('userId: $userId, ')
      ..write('userName: $userName, ')
      ..write('name: $name, ')
      ..write('userBio: $userBio, ')
      ..write('typeOf: $typeOf, ')
      ..write('userProfileImage: $userProfileImage, ')
      ..write('musicName: $musicName, ')
      ..write('musicId: $musicId, ')
      ..write('userType: $userType, ')
      ..write('audio: $audio, ')
      ..write('followStatus: $followStatus, ')
      ..write('likeStatus: $likeStatus, ')
      ..write('isUpdate: $isUpdate')
      ..write(')'))
        .toString();
  }
}

class $FunlinkPostModelTable extends FunlinkPostModel
    with TableInfo<$FunlinkPostModelTable, FunlinkPostModelData> {
  final GeneratedDatabase _db;
  String? _alias;
  $FunlinkPostModelTable(this._db, [this._alias]);
  final VerificationMeta _postIdMeta = const VerificationMeta('postId');
  late GeneratedColumn<String> _postId;
  @override
  GeneratedColumn<String> get postId =>
      GeneratedColumn<String>('post_id', aliasedName, false,
          requiredDuringInsert: true,
          $customConstraints: 'UNIQUE',
          type: DriftSqlType.string);
  final VerificationMeta _descriptionMeta =
  const VerificationMeta('description');
  late GeneratedColumn<String> _description;
  @override
  GeneratedColumn<String> get description =>
      GeneratedColumn<String>('description', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _districtMeta = const VerificationMeta('district');
  late GeneratedColumn<String> _district;
  @override
  GeneratedColumn<String> get district =>
      GeneratedColumn<String>('district', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _stateMeta = const VerificationMeta('state');
  late GeneratedColumn<String> _state;
  @override
  GeneratedColumn<String> get state =>
      GeneratedColumn<String>('state', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _countryMeta = const VerificationMeta('country');
  late GeneratedColumn<String> _country;
  @override
  GeneratedColumn<String> get country =>
      GeneratedColumn<String>('country', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _seenMeta = const VerificationMeta('seen');
  late GeneratedColumn<int> _seen;
  @override
  GeneratedColumn<int> get seen =>
      GeneratedColumn<int>('seen', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.int);
  final VerificationMeta _likesCountMeta = const VerificationMeta('likesCount');
  late GeneratedColumn<int> _likesCount;
  @override
  GeneratedColumn<int> get likesCount =>
      GeneratedColumn<int>('likes_count', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.int);
  final VerificationMeta _commentsCountMeta =
  const VerificationMeta('commentsCount');
  late GeneratedColumn<int> _commentsCount;
  @override
  GeneratedColumn<int> get commentsCount =>
      GeneratedColumn<int>('comments_count', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.int);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late GeneratedColumn<String> _createdAt;
  @override
  GeneratedColumn<String> get createdAt =>
      GeneratedColumn<String>('created_at', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  late GeneratedColumn<String> _updatedAt;
  @override
  GeneratedColumn<String> get updatedAt =>
      GeneratedColumn<String>('updated_at', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late GeneratedColumn<String> _userId;
  @override
  GeneratedColumn<String> get userId =>
      GeneratedColumn<String>('user_id', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _userNameMeta = const VerificationMeta('userName');
  late GeneratedColumn<String> _userName;
  @override
  GeneratedColumn<String> get userName =>
      GeneratedColumn<String>('user_name', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late GeneratedColumn<String> _name;
  @override
  GeneratedColumn<String> get name =>
      GeneratedColumn<String>('name', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _userBioMeta = const VerificationMeta('userBio');
  late GeneratedColumn<String> _userBio;
  @override
  GeneratedColumn<String> get userBio =>
      GeneratedColumn<String>('user_bio', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _typeOfMeta = const VerificationMeta('typeOf');
  late GeneratedColumn<String> _typeOf;
  @override
  GeneratedColumn<String> get typeOf =>
      GeneratedColumn<String>('type_of', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _userProfileImageMeta =
  const VerificationMeta('userProfileImage');
  late GeneratedColumn<String> _userProfileImage;
  @override
  GeneratedColumn<String> get userProfileImage =>
      GeneratedColumn<String>('user_profile_image', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _musicNameMeta = const VerificationMeta('musicName');
  late GeneratedColumn<String> _musicName;
  @override
  GeneratedColumn<String> get musicName =>
      GeneratedColumn<String>('music_name', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _musicIdMeta = const VerificationMeta('musicId');
  late GeneratedColumn<String> _musicId;
  @override
  GeneratedColumn<String> get musicId =>
      GeneratedColumn<String>('music_id', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _userTypeMeta = const VerificationMeta('userType');
  late GeneratedColumn<String> _userType;
  @override
  GeneratedColumn<String> get userType =>
      GeneratedColumn<String>('user_type', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _audioMeta = const VerificationMeta('audio');
  late GeneratedColumn<String> _audio;
  @override
  GeneratedColumn<String> get audio =>
      GeneratedColumn<String>('audio', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _followStatusMeta =
  const VerificationMeta('followStatus');
  late GeneratedColumn<bool> _followStatus;
  @override
  GeneratedColumn<bool> get followStatus =>
      GeneratedColumn<bool>('follow_status', aliasedName, false,
          requiredDuringInsert: true,
          type: DriftSqlType.bool,
         // defaultConstraints: 'CHECK (follow_status IN (0, 1))'
      );
  final VerificationMeta _likeStatusMeta = const VerificationMeta('likeStatus');
  late GeneratedColumn<int> _likeStatus;
  @override
  GeneratedColumn<int> get likeStatus =>
      GeneratedColumn<int>('like_status', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.int);
  final VerificationMeta _isUpdateMeta = const VerificationMeta('isUpdate');
  late GeneratedColumn<bool> _isUpdate;
  @override
  GeneratedColumn<bool> get isUpdate =>
      GeneratedColumn<bool>('is_update', aliasedName, false,
          requiredDuringInsert: true,
          type: DriftSqlType.bool,
         // defaultConstraints: 'CHECK (is_update IN (0, 1))'
      );
  @override
  List<GeneratedColumn> get $columns => [
    postId,
    description,
    district,
    state,
    country,
    seen,
    likesCount,
    commentsCount,
    createdAt,
    updatedAt,
    userId,
    userName,
    name,
    userBio,
    typeOf,
    userProfileImage,
    musicName,
    musicId,
    userType,
    audio,
    followStatus,
    likeStatus,
    isUpdate
  ];
  @override
  String get aliasedName => _alias ?? 'funlink_post_model';
  @override
  String get actualTableName => 'funlink_post_model';
  @override
  VerificationContext validateIntegrity(
      Insertable<FunlinkPostModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('post_id')) {
      context.handle(_postIdMeta,
          postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta));
    } else if (isInserting) {
      context.missing(_postIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('district')) {
      context.handle(_districtMeta,
          district.isAcceptableOrUnknown(data['district']!, _districtMeta));
    } else if (isInserting) {
      context.missing(_districtMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('seen')) {
      context.handle(
          _seenMeta, seen.isAcceptableOrUnknown(data['seen']!, _seenMeta));
    } else if (isInserting) {
      context.missing(_seenMeta);
    }
    if (data.containsKey('likes_count')) {
      context.handle(
          _likesCountMeta,
          likesCount.isAcceptableOrUnknown(
              data['likes_count']!, _likesCountMeta));
    } else if (isInserting) {
      context.missing(_likesCountMeta);
    }
    if (data.containsKey('comments_count')) {
      context.handle(
          _commentsCountMeta,
          commentsCount.isAcceptableOrUnknown(
              data['comments_count']!, _commentsCountMeta));
    } else if (isInserting) {
      context.missing(_commentsCountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('user_bio')) {
      context.handle(_userBioMeta,
          userBio.isAcceptableOrUnknown(data['user_bio']!, _userBioMeta));
    } else if (isInserting) {
      context.missing(_userBioMeta);
    }
    if (data.containsKey('type_of')) {
      context.handle(_typeOfMeta,
          typeOf.isAcceptableOrUnknown(data['type_of']!, _typeOfMeta));
    } else if (isInserting) {
      context.missing(_typeOfMeta);
    }
    if (data.containsKey('user_profile_image')) {
      context.handle(
          _userProfileImageMeta,
          userProfileImage.isAcceptableOrUnknown(
              data['user_profile_image']!, _userProfileImageMeta));
    } else if (isInserting) {
      context.missing(_userProfileImageMeta);
    }
    if (data.containsKey('music_name')) {
      context.handle(_musicNameMeta,
          musicName.isAcceptableOrUnknown(data['music_name']!, _musicNameMeta));
    } else if (isInserting) {
      context.missing(_musicNameMeta);
    }
    if (data.containsKey('music_id')) {
      context.handle(_musicIdMeta,
          musicId.isAcceptableOrUnknown(data['music_id']!, _musicIdMeta));
    } else if (isInserting) {
      context.missing(_musicIdMeta);
    }
    if (data.containsKey('user_type')) {
      context.handle(_userTypeMeta,
          userType.isAcceptableOrUnknown(data['user_type']!, _userTypeMeta));
    } else if (isInserting) {
      context.missing(_userTypeMeta);
    }
    if (data.containsKey('audio')) {
      context.handle(
          _audioMeta, audio.isAcceptableOrUnknown(data['audio']!, _audioMeta));
    } else if (isInserting) {
      context.missing(_audioMeta);
    }
    if (data.containsKey('follow_status')) {
      context.handle(
          _followStatusMeta,
          followStatus.isAcceptableOrUnknown(
              data['follow_status']!, _followStatusMeta));
    } else if (isInserting) {
      context.missing(_followStatusMeta);
    }
    if (data.containsKey('like_status')) {
      context.handle(
          _likeStatusMeta,
          likeStatus.isAcceptableOrUnknown(
              data['like_status']!, _likeStatusMeta));
    } else if (isInserting) {
      context.missing(_likeStatusMeta);
    }
    if (data.containsKey('is_update')) {
      context.handle(_isUpdateMeta,
          isUpdate.isAcceptableOrUnknown(data['is_update']!, _isUpdateMeta));
    } else if (isInserting) {
      context.missing(_isUpdateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {postId};
  @override
  FunlinkPostModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FunlinkPostModelData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FunlinkPostModelTable createAlias(String alias) {
    return $FunlinkPostModelTable(_db, alias);
  }

  @override
  // TODO: implement attachedDatabase
  DatabaseConnectionUser get attachedDatabase => throw UnimplementedError();
}

class FollowPostModelData extends DataClass
    implements Insertable<FollowPostModelData> {
  final String postId;
  final String description;
  final String district;
  final String state;
  final String country;
  final String type;
  final String musicName;
  final String musicId;
  final int maleSeen;
  final int femaleSeen;
  final int likesCount;
  final int likes0Count;
  final int likes1Count;
  final int likes2Count;
  final int commentsCount;
  final String createdAt;
  final String updatedAt;
  final String userId;
  final String userName;
  final String userType;
  final String name;
  final String typeOf;
  final String userBio;
  final String userProfileImage;
  final bool followStatus;
  final int likeStatus;
  final bool isUpdate;
  FollowPostModelData(
      {required this.postId,
        required this.description,
        required this.district,
        required this.state,
        required this.country,
        required this.type,
        required this.musicName,
        required this.musicId,
        required this.maleSeen,
        required this.femaleSeen,
        required this.likesCount,
        required this.likes0Count,
        required this.likes1Count,
        required this.likes2Count,
        required this.commentsCount,
        required this.createdAt,
        required this.updatedAt,
        required this.userId,
        required this.userName,
        required this.userType,
        required this.name,
        required this.typeOf,
        required this.userBio,
        required this.userProfileImage,
        required this.followStatus,
        required this.likeStatus,
        required this.isUpdate});
  factory FollowPostModelData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FollowPostModelData(
      postId: data['${effectivePrefix}post_id']!,
      description: data['${effectivePrefix}description']!,
      district: data['${effectivePrefix}district']!,
      state: data['${effectivePrefix}state']!,
      country: data['${effectivePrefix}country']!,
      type: data['${effectivePrefix}type']!,
      musicName: data['${effectivePrefix}music_name']!,
      musicId: data['${effectivePrefix}music_id']!,
      maleSeen: data['${effectivePrefix}male_seen']!,
      femaleSeen: data['${effectivePrefix}female_seen']!,
      likesCount: data['${effectivePrefix}likes_count']!,
      likes0Count: data['${effectivePrefix}likes0_count']!,
      likes1Count: data['${effectivePrefix}likes1_count']!,
      likes2Count: data['${effectivePrefix}likes2_count']!,
      commentsCount: data['${effectivePrefix}comments_count']!,
      createdAt: data['${effectivePrefix}created_at']!,
      updatedAt: data['${effectivePrefix}updated_at']!,
      userId: data['${effectivePrefix}user_id']!,
      userName: data['${effectivePrefix}user_name']!,
      userType: data['${effectivePrefix}user_type']!,
      name: data['${effectivePrefix}name']!,
      typeOf: data['${effectivePrefix}type_of']!,
      userBio: data['${effectivePrefix}user_bio']!,
      userProfileImage: data['${effectivePrefix}user_profile_image']!,
      followStatus: data['${effectivePrefix}follow_status']!,
      likeStatus: data['${effectivePrefix}like_status']!,
      isUpdate: data['${effectivePrefix}is_update']!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || postId != null) {
      map['post_id'] = Variable<String>(postId);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || district != null) {
      map['district'] = Variable<String>(district);
    }
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<String>(state);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || musicName != null) {
      map['music_name'] = Variable<String>(musicName);
    }
    if (!nullToAbsent || musicId != null) {
      map['music_id'] = Variable<String>(musicId);
    }
    if (!nullToAbsent || maleSeen != null) {
      map['male_seen'] = Variable<int>(maleSeen);
    }
    if (!nullToAbsent || femaleSeen != null) {
      map['female_seen'] = Variable<int>(femaleSeen);
    }
    if (!nullToAbsent || likesCount != null) {
      map['likes_count'] = Variable<int>(likesCount);
    }
    if (!nullToAbsent || likes0Count != null) {
      map['likes0_count'] = Variable<int>(likes0Count);
    }
    if (!nullToAbsent || likes1Count != null) {
      map['likes1_count'] = Variable<int>(likes1Count);
    }
    if (!nullToAbsent || likes2Count != null) {
      map['likes2_count'] = Variable<int>(likes2Count);
    }
    if (!nullToAbsent || commentsCount != null) {
      map['comments_count'] = Variable<int>(commentsCount);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || userName != null) {
      map['user_name'] = Variable<String>(userName);
    }
    if (!nullToAbsent || userType != null) {
      map['user_type'] = Variable<String>(userType);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || typeOf != null) {
      map['type_of'] = Variable<String>(typeOf);
    }
    if (!nullToAbsent || userBio != null) {
      map['user_bio'] = Variable<String>(userBio);
    }
    if (!nullToAbsent || userProfileImage != null) {
      map['user_profile_image'] = Variable<String>(userProfileImage);
    }
    if (!nullToAbsent || followStatus != null) {
      map['follow_status'] = Variable<bool>(followStatus);
    }
    if (!nullToAbsent || likeStatus != null) {
      map['like_status'] = Variable<int>(likeStatus);
    }
    if (!nullToAbsent || isUpdate != null) {
      map['is_update'] = Variable<bool>(isUpdate);
    }
    return map;
  }

  FollowPostModelCompanion toCompanion(bool nullToAbsent) {
    return FollowPostModelCompanion(
      postId:
      postId == null && nullToAbsent ? const Value.absent() : Value(postId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
      state:
      state == null && nullToAbsent ? const Value.absent() : Value(state),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      musicName: musicName == null && nullToAbsent
          ? const Value.absent()
          : Value(musicName),
      musicId: musicId == null && nullToAbsent
          ? const Value.absent()
          : Value(musicId),
      maleSeen: maleSeen == null && nullToAbsent
          ? const Value.absent()
          : Value(maleSeen),
      femaleSeen: femaleSeen == null && nullToAbsent
          ? const Value.absent()
          : Value(femaleSeen),
      likesCount: likesCount == null && nullToAbsent
          ? const Value.absent()
          : Value(likesCount),
      likes0Count: likes0Count == null && nullToAbsent
          ? const Value.absent()
          : Value(likes0Count),
      likes1Count: likes1Count == null && nullToAbsent
          ? const Value.absent()
          : Value(likes1Count),
      likes2Count: likes2Count == null && nullToAbsent
          ? const Value.absent()
          : Value(likes2Count),
      commentsCount: commentsCount == null && nullToAbsent
          ? const Value.absent()
          : Value(commentsCount),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      userId:
      userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      userName: userName == null && nullToAbsent
          ? const Value.absent()
          : Value(userName),
      userType: userType == null && nullToAbsent
          ? const Value.absent()
          : Value(userType),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      typeOf:
      typeOf == null && nullToAbsent ? const Value.absent() : Value(typeOf),
      userBio: userBio == null && nullToAbsent
          ? const Value.absent()
          : Value(userBio),
      userProfileImage: userProfileImage == null && nullToAbsent
          ? const Value.absent()
          : Value(userProfileImage),
      followStatus: followStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(followStatus),
      likeStatus: likeStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(likeStatus),
      isUpdate: isUpdate == null && nullToAbsent
          ? const Value.absent()
          : Value(isUpdate),
    );
  }

  factory FollowPostModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FollowPostModelData(
      postId: serializer.fromJson<String>(json['postId']),
      description: serializer.fromJson<String>(json['description']),
      district: serializer.fromJson<String>(json['district']),
      state: serializer.fromJson<String>(json['state']),
      country: serializer.fromJson<String>(json['country']),
      type: serializer.fromJson<String>(json['type']),
      musicName: serializer.fromJson<String>(json['musicName']),
      musicId: serializer.fromJson<String>(json['musicId']),
      maleSeen: serializer.fromJson<int>(json['maleSeen']),
      femaleSeen: serializer.fromJson<int>(json['femaleSeen']),
      likesCount: serializer.fromJson<int>(json['likesCount']),
      likes0Count: serializer.fromJson<int>(json['likes0Count']),
      likes1Count: serializer.fromJson<int>(json['likes1Count']),
      likes2Count: serializer.fromJson<int>(json['likes2Count']),
      commentsCount: serializer.fromJson<int>(json['commentsCount']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      userId: serializer.fromJson<String>(json['userId']),
      userName: serializer.fromJson<String>(json['userName']),
      userType: serializer.fromJson<String>(json['userType']),
      name: serializer.fromJson<String>(json['name']),
      typeOf: serializer.fromJson<String>(json['typeOf']),
      userBio: serializer.fromJson<String>(json['userBio']),
      userProfileImage: serializer.fromJson<String>(json['userProfileImage']),
      followStatus: serializer.fromJson<bool>(json['followStatus']),
      likeStatus: serializer.fromJson<int>(json['likeStatus']),
      isUpdate: serializer.fromJson<bool>(json['isUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'postId': serializer.toJson<String>(postId),
      'description': serializer.toJson<String>(description),
      'district': serializer.toJson<String>(district),
      'state': serializer.toJson<String>(state),
      'country': serializer.toJson<String>(country),
      'type': serializer.toJson<String>(type),
      'musicName': serializer.toJson<String>(musicName),
      'musicId': serializer.toJson<String>(musicId),
      'maleSeen': serializer.toJson<int>(maleSeen),
      'femaleSeen': serializer.toJson<int>(femaleSeen),
      'likesCount': serializer.toJson<int>(likesCount),
      'likes0Count': serializer.toJson<int>(likes0Count),
      'likes1Count': serializer.toJson<int>(likes1Count),
      'likes2Count': serializer.toJson<int>(likes2Count),
      'commentsCount': serializer.toJson<int>(commentsCount),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'userId': serializer.toJson<String>(userId),
      'userName': serializer.toJson<String>(userName),
      'userType': serializer.toJson<String>(userType),
      'name': serializer.toJson<String>(name),
      'typeOf': serializer.toJson<String>(typeOf),
      'userBio': serializer.toJson<String>(userBio),
      'userProfileImage': serializer.toJson<String>(userProfileImage),
      'followStatus': serializer.toJson<bool>(followStatus),
      'likeStatus': serializer.toJson<int>(likeStatus),
      'isUpdate': serializer.toJson<bool>(isUpdate),
    };
  }

  FollowPostModelData copyWith(
      {String? postId,
        String? description,
        String? district,
        String? state,
        String? country,
        String? type,
        String? musicName,
        String? musicId,
        int? maleSeen,
        int? femaleSeen,
        int? likesCount,
        int? likes0Count,
        int? likes1Count,
        int? likes2Count,
        int? commentsCount,
        String? createdAt,
        String? updatedAt,
        String? userId,
        String? userName,
        String? userType,
        String? name,
        String? typeOf,
        String? userBio,
        String? userProfileImage,
        bool? followStatus,
        int? likeStatus,
        bool? isUpdate}) =>
      FollowPostModelData(
        postId: postId ?? this.postId,
        description: description ?? this.description,
        district: district ?? this.district,
        state: state ?? this.state,
        country: country ?? this.country,
        type: type ?? this.type,
        musicName: musicName ?? this.musicName,
        musicId: musicId ?? this.musicId,
        maleSeen: maleSeen ?? this.maleSeen,
        femaleSeen: femaleSeen ?? this.femaleSeen,
        likesCount: likesCount ?? this.likesCount,
        likes0Count: likes0Count ?? this.likes0Count,
        likes1Count: likes1Count ?? this.likes1Count,
        likes2Count: likes2Count ?? this.likes2Count,
        commentsCount: commentsCount ?? this.commentsCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        userType: userType ?? this.userType,
        name: name ?? this.name,
        typeOf: typeOf ?? this.typeOf,
        userBio: userBio ?? this.userBio,
        userProfileImage: userProfileImage ?? this.userProfileImage,
        followStatus: followStatus ?? this.followStatus,
        likeStatus: likeStatus ?? this.likeStatus,
        isUpdate: isUpdate ?? this.isUpdate,
      );
  @override
  String toString() {
    return (StringBuffer('FollowPostModelData(')
      ..write('postId: $postId, ')
      ..write('description: $description, ')
      ..write('district: $district, ')
      ..write('state: $state, ')
      ..write('country: $country, ')
      ..write('type: $type, ')
      ..write('musicName: $musicName, ')
      ..write('musicId: $musicId, ')
      ..write('maleSeen: $maleSeen, ')
      ..write('femaleSeen: $femaleSeen, ')
      ..write('likesCount: $likesCount, ')
      ..write('likes0Count: $likes0Count, ')
      ..write('likes1Count: $likes1Count, ')
      ..write('likes2Count: $likes2Count, ')
      ..write('commentsCount: $commentsCount, ')
      ..write('createdAt: $createdAt, ')
      ..write('updatedAt: $updatedAt, ')
      ..write('userId: $userId, ')
      ..write('userName: $userName, ')
      ..write('userType: $userType, ')
      ..write('name: $name, ')
      ..write('typeOf: $typeOf, ')
      ..write('userBio: $userBio, ')
      ..write('userProfileImage: $userProfileImage, ')
      ..write('followStatus: $followStatus, ')
      ..write('likeStatus: $likeStatus, ')
      ..write('isUpdate: $isUpdate')
      ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    postId,
    description,
    district,
    state,
    country,
    type,
    musicName,
    musicId,
    maleSeen,
    femaleSeen,
    likesCount,
    likes0Count,
    likes1Count,
    likes2Count,
    commentsCount,
    createdAt,
    updatedAt,
    userId,
    userName,
    userType,
    name,
    typeOf,
    userBio,
    userProfileImage,
    followStatus,
    likeStatus,
    isUpdate
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is FollowPostModelData &&
              other.postId == this.postId &&
              other.description == this.description &&
              other.district == this.district &&
              other.state == this.state &&
              other.country == this.country &&
              other.type == this.type &&
              other.musicName == this.musicName &&
              other.musicId == this.musicId &&
              other.maleSeen == this.maleSeen &&
              other.femaleSeen == this.femaleSeen &&
              other.likesCount == this.likesCount &&
              other.likes0Count == this.likes0Count &&
              other.likes1Count == this.likes1Count &&
              other.likes2Count == this.likes2Count &&
              other.commentsCount == this.commentsCount &&
              other.createdAt == this.createdAt &&
              other.updatedAt == this.updatedAt &&
              other.userId == this.userId &&
              other.userName == this.userName &&
              other.userType == this.userType &&
              other.name == this.name &&
              other.typeOf == this.typeOf &&
              other.userBio == this.userBio &&
              other.userProfileImage == this.userProfileImage &&
              other.followStatus == this.followStatus &&
              other.likeStatus == this.likeStatus &&
              other.isUpdate == this.isUpdate);
}

class FollowPostModelCompanion extends UpdateCompanion<FollowPostModelData> {
  final Value<String> postId;
  final Value<String> description;
  final Value<String> district;
  final Value<String> state;
  final Value<String> country;
  final Value<String> type;
  final Value<String> musicName;
  final Value<String> musicId;
  final Value<int> maleSeen;
  final Value<int> femaleSeen;
  final Value<int> likesCount;
  final Value<int> likes0Count;
  final Value<int> likes1Count;
  final Value<int> likes2Count;
  final Value<int> commentsCount;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> userId;
  final Value<String> userName;
  final Value<String> userType;
  final Value<String> name;
  final Value<String> typeOf;
  final Value<String> userBio;
  final Value<String> userProfileImage;
  final Value<bool> followStatus;
  final Value<int> likeStatus;
  final Value<bool> isUpdate;
  const FollowPostModelCompanion({
    this.postId = const Value.absent(),
    this.description = const Value.absent(),
    this.district = const Value.absent(),
    this.state = const Value.absent(),
    this.country = const Value.absent(),
    this.type = const Value.absent(),
    this.musicName = const Value.absent(),
    this.musicId = const Value.absent(),
    this.maleSeen = const Value.absent(),
    this.femaleSeen = const Value.absent(),
    this.likesCount = const Value.absent(),
    this.likes0Count = const Value.absent(),
    this.likes1Count = const Value.absent(),
    this.likes2Count = const Value.absent(),
    this.commentsCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.userName = const Value.absent(),
    this.userType = const Value.absent(),
    this.name = const Value.absent(),
    this.typeOf = const Value.absent(),
    this.userBio = const Value.absent(),
    this.userProfileImage = const Value.absent(),
    this.followStatus = const Value.absent(),
    this.likeStatus = const Value.absent(),
    this.isUpdate = const Value.absent(),
  });
  FollowPostModelCompanion.insert({
    required String postId,
    required String description,
    required String district,
    required String state,
    required String country,
    required String type,
    required String musicName,
    required String musicId,
    required int maleSeen,
    required int femaleSeen,
    required int likesCount,
    required int likes0Count,
    required int likes1Count,
    required int likes2Count,
    required int commentsCount,
    required String createdAt,
    required String updatedAt,
    required String userId,
    required String userName,
    required String userType,
    required String name,
    required String typeOf,
    required String userBio,
    required String userProfileImage,
    required bool followStatus,
    required int likeStatus,
    required bool isUpdate,
  })  : postId = Value(postId),
        description = Value(description),
        district = Value(district),
        state = Value(state),
        country = Value(country),
        type = Value(type),
        musicName = Value(musicName),
        musicId = Value(musicId),
        maleSeen = Value(maleSeen),
        femaleSeen = Value(femaleSeen),
        likesCount = Value(likesCount),
        likes0Count = Value(likes0Count),
        likes1Count = Value(likes1Count),
        likes2Count = Value(likes2Count),
        commentsCount = Value(commentsCount),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        userId = Value(userId),
        userName = Value(userName),
        userType = Value(userType),
        name = Value(name),
        typeOf = Value(typeOf),
        userBio = Value(userBio),
        userProfileImage = Value(userProfileImage),
        followStatus = Value(followStatus),
        likeStatus = Value(likeStatus),
        isUpdate = Value(isUpdate);
  static Insertable<FollowPostModelData> custom({
    Expression<String>? postId,
    Expression<String>? description,
    Expression<String>? district,
    Expression<String>? state,
    Expression<String>? country,
    Expression<String>? type,
    Expression<String>? musicName,
    Expression<String>? musicId,
    Expression<int>? maleSeen,
    Expression<int>? femaleSeen,
    Expression<int>? likesCount,
    Expression<int>? likes0Count,
    Expression<int>? likes1Count,
    Expression<int>? likes2Count,
    Expression<int>? commentsCount,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? userId,
    Expression<String>? userName,
    Expression<String>? userType,
    Expression<String>? name,
    Expression<String>? typeOf,
    Expression<String>? userBio,
    Expression<String>? userProfileImage,
    Expression<bool>? followStatus,
    Expression<int>? likeStatus,
    Expression<bool>? isUpdate,
  }) {
    return RawValuesInsertable({
      if (postId != null) 'post_id': postId,
      if (description != null) 'description': description,
      if (district != null) 'district': district,
      if (state != null) 'state': state,
      if (country != null) 'country': country,
      if (type != null) 'type': type,
      if (musicName != null) 'music_name': musicName,
      if (musicId != null) 'music_id': musicId,
      if (maleSeen != null) 'male_seen': maleSeen,
      if (femaleSeen != null) 'female_seen': femaleSeen,
      if (likesCount != null) 'likes_count': likesCount,
      if (likes0Count != null) 'likes0_count': likes0Count,
      if (likes1Count != null) 'likes1_count': likes1Count,
      if (likes2Count != null) 'likes2_count': likes2Count,
      if (commentsCount != null) 'comments_count': commentsCount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userId != null) 'user_id': userId,
      if (userName != null) 'user_name': userName,
      if (userType != null) 'user_type': userType,
      if (name != null) 'name': name,
      if (typeOf != null) 'type_of': typeOf,
      if (userBio != null) 'user_bio': userBio,
      if (userProfileImage != null) 'user_profile_image': userProfileImage,
      if (followStatus != null) 'follow_status': followStatus,
      if (likeStatus != null) 'like_status': likeStatus,
      if (isUpdate != null) 'is_update': isUpdate,
    });
  }

  FollowPostModelCompanion copyWith(
      {Value<String>? postId,
        Value<String>? description,
        Value<String>? district,
        Value<String>? state,
        Value<String>? country,
        Value<String>? type,
        Value<String>? musicName,
        Value<String>? musicId,
        Value<int>? maleSeen,
        Value<int>? femaleSeen,
        Value<int>? likesCount,
        Value<int>? likes0Count,
        Value<int>? likes1Count,
        Value<int>? likes2Count,
        Value<int>? commentsCount,
        Value<String>? createdAt,
        Value<String>? updatedAt,
        Value<String>? userId,
        Value<String>? userName,
        Value<String>? userType,
        Value<String>? name,
        Value<String>? typeOf,
        Value<String>? userBio,
        Value<String>? userProfileImage,
        Value<bool>? followStatus,
        Value<int>? likeStatus,
        Value<bool>? isUpdate}) {
    return FollowPostModelCompanion(
      postId: postId ?? this.postId,
      description: description ?? this.description,
      district: district ?? this.district,
      state: state ?? this.state,
      country: country ?? this.country,
      type: type ?? this.type,
      musicName: musicName ?? this.musicName,
      musicId: musicId ?? this.musicId,
      maleSeen: maleSeen ?? this.maleSeen,
      femaleSeen: femaleSeen ?? this.femaleSeen,
      likesCount: likesCount ?? this.likesCount,
      likes0Count: likes0Count ?? this.likes0Count,
      likes1Count: likes1Count ?? this.likes1Count,
      likes2Count: likes2Count ?? this.likes2Count,
      commentsCount: commentsCount ?? this.commentsCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userType: userType ?? this.userType,
      name: name ?? this.name,
      typeOf: typeOf ?? this.typeOf,
      userBio: userBio ?? this.userBio,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      followStatus: followStatus ?? this.followStatus,
      likeStatus: likeStatus ?? this.likeStatus,
      isUpdate: isUpdate ?? this.isUpdate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (postId.present) {
      map['post_id'] = Variable<String>(postId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (musicName.present) {
      map['music_name'] = Variable<String>(musicName.value);
    }
    if (musicId.present) {
      map['music_id'] = Variable<String>(musicId.value);
    }
    if (maleSeen.present) {
      map['male_seen'] = Variable<int>(maleSeen.value);
    }
    if (femaleSeen.present) {
      map['female_seen'] = Variable<int>(femaleSeen.value);
    }
    if (likesCount.present) {
      map['likes_count'] = Variable<int>(likesCount.value);
    }
    if (likes0Count.present) {
      map['likes0_count'] = Variable<int>(likes0Count.value);
    }
    if (likes1Count.present) {
      map['likes1_count'] = Variable<int>(likes1Count.value);
    }
    if (likes2Count.present) {
      map['likes2_count'] = Variable<int>(likes2Count.value);
    }
    if (commentsCount.present) {
      map['comments_count'] = Variable<int>(commentsCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (userType.present) {
      map['user_type'] = Variable<String>(userType.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (typeOf.present) {
      map['type_of'] = Variable<String>(typeOf.value);
    }
    if (userBio.present) {
      map['user_bio'] = Variable<String>(userBio.value);
    }
    if (userProfileImage.present) {
      map['user_profile_image'] = Variable<String>(userProfileImage.value);
    }
    if (followStatus.present) {
      map['follow_status'] = Variable<bool>(followStatus.value);
    }
    if (likeStatus.present) {
      map['like_status'] = Variable<int>(likeStatus.value);
    }
    if (isUpdate.present) {
      map['is_update'] = Variable<bool>(isUpdate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FollowPostModelCompanion(')
      ..write('postId: $postId, ')
      ..write('description: $description, ')
      ..write('district: $district, ')
      ..write('state: $state, ')
      ..write('country: $country, ')
      ..write('type: $type, ')
      ..write('musicName: $musicName, ')
      ..write('musicId: $musicId, ')
      ..write('maleSeen: $maleSeen, ')
      ..write('femaleSeen: $femaleSeen, ')
      ..write('likesCount: $likesCount, ')
      ..write('likes0Count: $likes0Count, ')
      ..write('likes1Count: $likes1Count, ')
      ..write('likes2Count: $likes2Count, ')
      ..write('commentsCount: $commentsCount, ')
      ..write('createdAt: $createdAt, ')
      ..write('updatedAt: $updatedAt, ')
      ..write('userId: $userId, ')
      ..write('userName: $userName, ')
      ..write('userType: $userType, ')
      ..write('name: $name, ')
      ..write('typeOf: $typeOf, ')
      ..write('userBio: $userBio, ')
      ..write('userProfileImage: $userProfileImage, ')
      ..write('followStatus: $followStatus, ')
      ..write('likeStatus: $likeStatus, ')
      ..write('isUpdate: $isUpdate')
      ..write(')'))
        .toString();
  }
}

class $FollowPostModelTable extends FollowPostModel
    with TableInfo<$FollowPostModelTable, FollowPostModelData> {
  final GeneratedDatabase _db;
  String? _alias;
  $FollowPostModelTable(this._db, [this._alias]);
  final VerificationMeta _postIdMeta = const VerificationMeta('postId');
  late GeneratedColumn<String> _postId;
  @override
  GeneratedColumn<String> get postId =>
      GeneratedColumn<String>('post_id', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          $customConstraints: 'UNIQUE');
  final VerificationMeta _descriptionMeta =
  const VerificationMeta('description');
  late GeneratedColumn<String> _description;
  @override
  GeneratedColumn<String> get description =>
      GeneratedColumn<String>('description', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _districtMeta = const VerificationMeta('district');
  late GeneratedColumn<String> _district;
  @override
  GeneratedColumn<String> get district =>
      GeneratedColumn<String>('district', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _stateMeta = const VerificationMeta('state');
  late GeneratedColumn<String> _state;
  @override
  GeneratedColumn<String> get state =>
      GeneratedColumn<String>('state', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _countryMeta = const VerificationMeta('country');
  late GeneratedColumn<String> _country;
  @override
  GeneratedColumn<String> get country =>
      GeneratedColumn<String>('country', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  late GeneratedColumn<String> _type;
  @override
  GeneratedColumn<String> get type =>
      GeneratedColumn<String>('type', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _musicNameMeta = const VerificationMeta('musicName');
//  GeneratedColumn<String> _musicName;
  @override
  GeneratedColumn<String> get musicName =>
      GeneratedColumn<String>('music_name', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _musicIdMeta = const VerificationMeta('musicId');
  // GeneratedColumn<String> _musicId;
  @override
  GeneratedColumn<String> get musicId =>
      GeneratedColumn<String>('music_id', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _maleSeenMeta = const VerificationMeta('maleSeen');
  // GeneratedColumn<int> _maleSeen;
  @override
  GeneratedColumn<int> get maleSeen =>
      GeneratedColumn<int>('male_seen', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.int);
  final VerificationMeta _femaleSeenMeta = const VerificationMeta('femaleSeen');
  // GeneratedColumn<int> _femaleSeen;
  @override
  GeneratedColumn<int> get femaleSeen =>
      GeneratedColumn<int>('female_seen', aliasedName, false,
          type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _likesCountMeta = const VerificationMeta('likesCount');
  // GeneratedColumn<int> _likesCount;
  @override
  GeneratedColumn<int> get likesCount =>
      GeneratedColumn<int>('likes_count', aliasedName, false,
          type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _likes0CountMeta =
  const VerificationMeta('likes0Count');
  //GeneratedColumn<int> _likes0Count;
  @override
  GeneratedColumn<int> get likes0Count =>
      GeneratedColumn<int>('likes0_count', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.int);
  final VerificationMeta _likes1CountMeta =
  const VerificationMeta('likes1Count');
  // GeneratedColumn<int> _likes1Count;
  @override
  GeneratedColumn<int> get likes1Count =>
      GeneratedColumn<int>('likes1_count', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.int);
  final VerificationMeta _likes2CountMeta =
  const VerificationMeta('likes2Count');
  //GeneratedColumn<int> _likes2Count;
  @override
  GeneratedColumn<int> get likes2Count =>
      GeneratedColumn<int>('likes2_count', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.int);
  final VerificationMeta _commentsCountMeta =
  const VerificationMeta('commentsCount');
  //GeneratedColumn<int> _commentsCount;
  @override
  GeneratedColumn<int> get commentsCount =>
      GeneratedColumn<int>('comments_count', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.int);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  // GeneratedColumn<String> _createdAt;
  @override
  GeneratedColumn<String> get createdAt =>
      GeneratedColumn<String>('created_at', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  // GeneratedColumn<String> _updatedAt;
  @override
  GeneratedColumn<String> get updatedAt =>
      GeneratedColumn<String>('updated_at', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late GeneratedColumn<String> _userId;
  @override
  GeneratedColumn<String> get userId =>
      GeneratedColumn<String>('user_id', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _userNameMeta = const VerificationMeta('userName');
  late GeneratedColumn<String> _userName;
  @override
  GeneratedColumn<String> get userName =>
      GeneratedColumn<String>('user_name', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  VerificationMeta _userTypeMeta = const VerificationMeta('userType');
  late GeneratedColumn<String> _userType;
  @override
  GeneratedColumn<String> get userType =>
      GeneratedColumn<String>('user_type', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  // GeneratedColumn<String> _name;
  @override
  GeneratedColumn<String> get name =>
      GeneratedColumn<String>('name', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _typeOfMeta = const VerificationMeta('typeOf');
  // GeneratedColumn<String> _typeOf;
  @override
  GeneratedColumn<String> get typeOf =>
      GeneratedColumn<String>('type_of', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _userBioMeta = const VerificationMeta('userBio');
  // GeneratedColumn<String> _userBio;
  @override
  GeneratedColumn<String> get userBio =>
      GeneratedColumn<String>('user_bio', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _userProfileImageMeta =
  const VerificationMeta('userProfileImage');
  // GeneratedColumn<String> _userProfileImage;
  @override
  GeneratedColumn<String> get userProfileImage =>
      GeneratedColumn<String>('user_profile_image', aliasedName, false,
          requiredDuringInsert: true, type: DriftSqlType.string);
  final VerificationMeta _followStatusMeta =
  const VerificationMeta('followStatus');
  // GeneratedColumn<bool> _followStatus;
  @override
  GeneratedColumn<bool> get followStatus =>
      GeneratedColumn<bool>('follow_status', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          ///defaultConstraints: 'CHECK (follow_status IN (0, 1))'
      );
  final VerificationMeta _likeStatusMeta = const VerificationMeta('likeStatus');
  // GeneratedColumn<int> _likeStatus;
  @override
  GeneratedColumn<int> get likeStatus =>
      GeneratedColumn<int>('like_status', aliasedName, false,
          type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _isUpdateMeta = const VerificationMeta('isUpdate');
  // GeneratedColumn<bool> _isUpdate;
  @override
  GeneratedColumn<bool> get isUpdate =>
      GeneratedColumn<bool>('is_update', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          //defaultConstraints: 'CHECK (is_update IN (0, 1))'
      );
  @override
  List<GeneratedColumn> get $columns => [
    postId,
    description,
    district,
    state,
    country,
    type,
    musicName,
    musicId,
    maleSeen,
    femaleSeen,
    likesCount,
    likes0Count,
    likes1Count,
    likes2Count,
    commentsCount,
    createdAt,
    updatedAt,
    userId,
    userName,
    userType,
    name,
    typeOf,
    userBio,
    userProfileImage,
    followStatus,
    likeStatus,
    isUpdate
  ];
  @override
  String get aliasedName => _alias ?? 'follow_post_model';
  @override
  String get actualTableName => 'follow_post_model';
  @override
  VerificationContext validateIntegrity(
      Insertable<FollowPostModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('post_id')) {
      context.handle(_postIdMeta,
          postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta));
    } else if (isInserting) {
      context.missing(_postIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('district')) {
      context.handle(_districtMeta,
          district.isAcceptableOrUnknown(data['district']!, _districtMeta));
    } else if (isInserting) {
      context.missing(_districtMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('music_name')) {
      context.handle(_musicNameMeta,
          musicName.isAcceptableOrUnknown(data['music_name']!, _musicNameMeta));
    } else if (isInserting) {
      context.missing(_musicNameMeta);
    }
    if (data.containsKey('music_id')) {
      context.handle(_musicIdMeta,
          musicId.isAcceptableOrUnknown(data['music_id']!, _musicIdMeta));
    } else if (isInserting) {
      context.missing(_musicIdMeta);
    }
    if (data.containsKey('male_seen')) {
      context.handle(_maleSeenMeta,
          maleSeen.isAcceptableOrUnknown(data['male_seen']!, _maleSeenMeta));
    } else if (isInserting) {
      context.missing(_maleSeenMeta);
    }
    if (data.containsKey('female_seen')) {
      context.handle(
          _femaleSeenMeta,
          femaleSeen.isAcceptableOrUnknown(
              data['female_seen']!, _femaleSeenMeta));
    } else if (isInserting) {
      context.missing(_femaleSeenMeta);
    }
    if (data.containsKey('likes_count')) {
      context.handle(
          _likesCountMeta,
          likesCount.isAcceptableOrUnknown(
              data['likes_count']!, _likesCountMeta));
    } else if (isInserting) {
      context.missing(_likesCountMeta);
    }
    if (data.containsKey('likes0_count')) {
      context.handle(
          _likes0CountMeta,
          likes0Count.isAcceptableOrUnknown(
              data['likes0_count']!, _likes0CountMeta));
    } else if (isInserting) {
      context.missing(_likes0CountMeta);
    }
    if (data.containsKey('likes1_count')) {
      context.handle(
          _likes1CountMeta,
          likes1Count.isAcceptableOrUnknown(
              data['likes1_count']!, _likes1CountMeta));
    } else if (isInserting) {
      context.missing(_likes1CountMeta);
    }
    if (data.containsKey('likes2_count')) {
      context.handle(
          _likes2CountMeta,
          likes2Count.isAcceptableOrUnknown(
              data['likes2_count']!, _likes2CountMeta));
    } else if (isInserting) {
      context.missing(_likes2CountMeta);
    }
    if (data.containsKey('comments_count')) {
      context.handle(
          _commentsCountMeta,
          commentsCount.isAcceptableOrUnknown(
              data['comments_count']!, _commentsCountMeta));
    } else if (isInserting) {
      context.missing(_commentsCountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('user_type')) {
      context.handle(_userTypeMeta,
          userType.isAcceptableOrUnknown(data['user_type']!, _userTypeMeta));
    } else if (isInserting) {
      context.missing(_userTypeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type_of')) {
      context.handle(_typeOfMeta,
          typeOf.isAcceptableOrUnknown(data['type_of']!, _typeOfMeta));
    } else if (isInserting) {
      context.missing(_typeOfMeta);
    }
    if (data.containsKey('user_bio')) {
      context.handle(_userBioMeta,
          userBio.isAcceptableOrUnknown(data['user_bio']!, _userBioMeta));
    } else if (isInserting) {
      context.missing(_userBioMeta);
    }
    if (data.containsKey('user_profile_image')) {
      context.handle(
          _userProfileImageMeta,
          userProfileImage.isAcceptableOrUnknown(
              data['user_profile_image']!, _userProfileImageMeta));
    } else if (isInserting) {
      context.missing(_userProfileImageMeta);
    }
    if (data.containsKey('follow_status')) {
      context.handle(
          _followStatusMeta,
          followStatus.isAcceptableOrUnknown(
              data['follow_status']!, _followStatusMeta));
    } else if (isInserting) {
      context.missing(_followStatusMeta);
    }
    if (data.containsKey('like_status')) {
      context.handle(
          _likeStatusMeta,
          likeStatus.isAcceptableOrUnknown(
              data['like_status']!, _likeStatusMeta));
    } else if (isInserting) {
      context.missing(_likeStatusMeta);
    }
    if (data.containsKey('is_update')) {
      context.handle(_isUpdateMeta,
          isUpdate.isAcceptableOrUnknown(data['is_update']!, _isUpdateMeta));
    } else if (isInserting) {
      context.missing(_isUpdateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {postId};
  @override
  FollowPostModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FollowPostModelData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FollowPostModelTable createAlias(String alias) {
    return $FollowPostModelTable(_db, alias);
  }

  VerificationMeta get userTypeMeta => _userTypeMeta;

  set userTypeMeta(VerificationMeta value) {
    _userTypeMeta = value;
  }

  @override
  // TODO: implement attachedDatabase
  DatabaseConnectionUser get attachedDatabase => throw UnimplementedError();
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  //$PostModelTable _postModel;
  $PostModelTable get postModel => $PostModelTable(this);
  // $ChallengesModelTable _challengesModel;
  $ChallengesModelTable get challengesModel => $ChallengesModelTable(this);
  // $MediaModelTable _mediaModel;
  $MediaModelTable get mediaModel => $MediaModelTable(this);
  // $FunlinkPostModelTable _funlinkPostModel;
  $FunlinkPostModelTable get funlinkPostModel => $FunlinkPostModelTable(this);
  // $FollowPostModelTable _followPostModel;
  $FollowPostModelTable get followPostModel => $FollowPostModelTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    postModel,
    challengesModel,
    mediaModel,
    funlinkPostModel,
    followPostModel
  ];
}
