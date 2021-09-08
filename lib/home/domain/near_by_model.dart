class NearByModel {
  String? businessName;
  String? category;
  String? countryCode;
  double? distance = 0.0;
  String? openingHours;
  String? address;
  String? city;
  String? country;
  String? latitude;
  String? longitude;
  String? logoUrl;
  String? phoneNumber;

  String? discountPercenatage;
  BusinessCashbackConfig? businessCashbackConfig;

  NearByModel(
      {this.businessName,
      this.category,
      this.countryCode,
      this.distance,
      this.openingHours,
      this.address,
      this.city,
      this.country,
      this.latitude,
      this.longitude,
      this.logoUrl,
      this.discountPercenatage,
      this.phoneNumber,
      this.businessCashbackConfig});

  NearByModel.fromJson(Map<String, dynamic> json) {
    businessName = json['businessName'];
    category = json['category'];
    countryCode = json['countryCode'];
    distance = json['distance'] == null ? 0.0 : json['distance'].toDouble();
    openingHours = json['openingHours'];
    address = json['address'];
    city = json['city'];
    phoneNumber = json['phoneNumber'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    logoUrl = json['logoUrl'];
    discountPercenatage = json['discountPercenatage'];
    businessCashbackConfig = json['businessCashbackConfig'] != null
        ? new BusinessCashbackConfig.fromJson(json['businessCashbackConfig'])
        : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['businessName'] = this.businessName;
    data['category'] = this.category;
    data['countryCode'] = this.countryCode;
    data['distance'] = this.distance;
    data['openingHours'] = this.openingHours;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['logoUrl'] = this.logoUrl;
    data['discountPercenatage'] = this.discountPercenatage;
    if (this.businessCashbackConfig != null) {
      data['businessCashbackConfig'] = this.businessCashbackConfig!.toJson();
    }
    return data;
  }
}

class BusinessCashbackConfig {
  int? id;
  String? cashbackType;
  int? firstCashbackValue;
  int? subsequentCashbackValue;
  int? minimumQualifyingAmount;
  int? maximumQualifyingAmount;
  bool? vatExcluded;
  String? redeemCondition;
  String? extraCashbackType;
  int? extraCashbackValue;
  String? extraCashbackStart;
  String? extraCashbackEnd;
  String? payTackUserId;
  PayTackUser? payTackUser;

  BusinessCashbackConfig(
      {this.id,
      this.cashbackType,
      this.firstCashbackValue,
      this.subsequentCashbackValue,
      this.minimumQualifyingAmount,
      this.maximumQualifyingAmount,
      this.vatExcluded,
      this.redeemCondition,
      this.extraCashbackType,
      this.extraCashbackValue,
      this.extraCashbackStart,
      this.extraCashbackEnd,
      this.payTackUserId,
      this.payTackUser});

  BusinessCashbackConfig.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    cashbackType = json['cashbackType'];
    firstCashbackValue = json['firstCashbackValue'];
    subsequentCashbackValue = json['subsequentCashbackValue'];
    minimumQualifyingAmount = json['minimumQualifyingAmount'];
    maximumQualifyingAmount = json['maximumQualifyingAmount'];
    vatExcluded = json['vatExcluded'];
    redeemCondition = json['redeemCondition'];
    extraCashbackType = json['extraCashbackType'];
    extraCashbackValue = json['extraCashbackValue'];
    extraCashbackStart = json['extraCashbackStart'];
    extraCashbackEnd = json['extraCashbackEnd'];
    payTackUserId = json['payTackUserId'];
    payTackUser = json['payTackUser'] != null
        ? new PayTackUser.fromJson(json['payTackUser'])
        : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['cashbackType'] = this.cashbackType;
    data['firstCashbackValue'] = this.firstCashbackValue;
    data['subsequentCashbackValue'] = this.subsequentCashbackValue;
    data['minimumQualifyingAmount'] = this.minimumQualifyingAmount;
    data['maximumQualifyingAmount'] = this.maximumQualifyingAmount;
    data['vatExcluded'] = this.vatExcluded;
    data['redeemCondition'] = this.redeemCondition;
    data['extraCashbackType'] = this.extraCashbackType;
    data['extraCashbackValue'] = this.extraCashbackValue;
    data['extraCashbackStart'] = this.extraCashbackStart;
    data['extraCashbackEnd'] = this.extraCashbackEnd;
    data['payTackUserId'] = this.payTackUserId;
    if (this.payTackUser != null) {
      data['payTackUser'] = this.payTackUser!.toJson();
    }
    return data;
  }
}

class PayTackUser {
  String? id;
  String? userName;
  String? normalizedUserName;
  String? normalizedEmail;
  bool? emailConfirmed;
  String? passwordHash;
  String? securityStamp;
  String? concurrencyStamp;
  bool? phoneNumberConfirmed;
  bool? twoFactorEnabled;
  String? lockoutEnd;
  bool? lockoutEnabled;
  int? accessFailedCount;
  String? email;
  String? countryCode;
  String? phoneNumber;
  String? address;
  String? postalCode;
  String? city;
  String? country;
  String? passwordResetToken;
  int? passwordResetOTP;
  String? businessName;
  String? category;
  String? description;
  String? logoUrl;
  String? registrationNumber;
  String? registrationName;
  String? openingHours;
  String? latitude;
  String? longitude;
  String? website;
  String? instagramUrl;
  String? facebookUrl;
  String? twitterUrl;
  String? accountName;
  String? accountHolderName;
  String? bankName;
  String? iban;
  String? businessCashbackConfig;
  String? clientName;
  String? gender;
  String? dateOfBirth;
  String? anniversaryDate;
  String? signUpDate;
  String? referralCode;
  ClientCashbackData? clientCashbackData;
  List<Bills>? bills;

  PayTackUser(
      {this.id,
      this.userName,
      this.normalizedUserName,
      this.normalizedEmail,
      this.emailConfirmed,
      this.passwordHash,
      this.securityStamp,
      this.concurrencyStamp,
      this.phoneNumberConfirmed,
      this.twoFactorEnabled,
      this.lockoutEnd,
      this.lockoutEnabled,
      this.accessFailedCount,
      this.email,
      this.countryCode,
      this.phoneNumber,
      this.address,
      this.postalCode,
      this.city,
      this.country,
      this.passwordResetToken,
      this.passwordResetOTP,
      this.businessName,
      this.category,
      this.description,
      this.logoUrl,
      this.registrationNumber,
      this.registrationName,
      this.openingHours,
      this.latitude,
      this.longitude,
      this.website,
      this.instagramUrl,
      this.facebookUrl,
      this.twitterUrl,
      this.accountName,
      this.accountHolderName,
      this.bankName,
      this.iban,
      this.businessCashbackConfig,
      this.clientName,
      this.gender,
      this.dateOfBirth,
      this.anniversaryDate,
      this.signUpDate,
      this.referralCode,
      this.clientCashbackData,
      this.bills});

  PayTackUser.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    normalizedUserName = json['normalizedUserName'];
    normalizedEmail = json['normalizedEmail'];
    emailConfirmed = json['emailConfirmed'];
    passwordHash = json['passwordHash'];
    securityStamp = json['securityStamp'];
    concurrencyStamp = json['concurrencyStamp'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    twoFactorEnabled = json['twoFactorEnabled'];
    lockoutEnd = json['lockoutEnd'];
    lockoutEnabled = json['lockoutEnabled'];
    accessFailedCount = json['accessFailedCount'];
    email = json['email'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    postalCode = json['postalCode'];
    city = json['city'];
    country = json['country'];
    passwordResetToken = json['passwordResetToken'];
    passwordResetOTP = json['passwordResetOTP'];
    businessName = json['businessName'];
    category = json['category'];
    description = json['description'];
    logoUrl = json['logoUrl'];
    registrationNumber = json['registrationNumber'];
    registrationName = json['registrationName'];
    openingHours = json['openingHours'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    website = json['website'];
    instagramUrl = json['instagramUrl'];
    facebookUrl = json['facebookUrl'];
    twitterUrl = json['twitterUrl'];
    accountName = json['accountName'];
    accountHolderName = json['accountHolderName'];
    bankName = json['bankName'];
    iban = json['iban'];
    businessCashbackConfig = json['businessCashbackConfig'];
    clientName = json['clientName'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    anniversaryDate = json['anniversaryDate'];
    signUpDate = json['signUpDate'];
    referralCode = json['referralCode'];
    clientCashbackData = json['clientCashbackData'] != null
        ? new ClientCashbackData.fromJson(json['clientCashbackData'])
        : null;
    if (json['bills'] != null) {
      bills = new List<Bills>.empty();
      json['bills'].forEach((v) {
        bills!.add(new Bills.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['normalizedUserName'] = this.normalizedUserName;
    data['normalizedEmail'] = this.normalizedEmail;
    data['emailConfirmed'] = this.emailConfirmed;
    data['passwordHash'] = this.passwordHash;
    data['securityStamp'] = this.securityStamp;
    data['concurrencyStamp'] = this.concurrencyStamp;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['twoFactorEnabled'] = this.twoFactorEnabled;
    data['lockoutEnd'] = this.lockoutEnd;
    data['lockoutEnabled'] = this.lockoutEnabled;
    data['accessFailedCount'] = this.accessFailedCount;
    data['email'] = this.email;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['postalCode'] = this.postalCode;
    data['city'] = this.city;
    data['country'] = this.country;
    data['passwordResetToken'] = this.passwordResetToken;
    data['passwordResetOTP'] = this.passwordResetOTP;
    data['businessName'] = this.businessName;
    data['category'] = this.category;
    data['description'] = this.description;
    data['logoUrl'] = this.logoUrl;
    data['registrationNumber'] = this.registrationNumber;
    data['registrationName'] = this.registrationName;
    data['openingHours'] = this.openingHours;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['website'] = this.website;
    data['instagramUrl'] = this.instagramUrl;
    data['facebookUrl'] = this.facebookUrl;
    data['twitterUrl'] = this.twitterUrl;
    data['accountName'] = this.accountName;
    data['accountHolderName'] = this.accountHolderName;
    data['bankName'] = this.bankName;
    data['iban'] = this.iban;
    data['businessCashbackConfig'] = this.businessCashbackConfig;
    data['clientName'] = this.clientName;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['anniversaryDate'] = this.anniversaryDate;
    data['signUpDate'] = this.signUpDate;
    data['referralCode'] = this.referralCode;
    if (this.clientCashbackData != null) {
      data['clientCashbackData'] = this.clientCashbackData!.toJson();
    }
    if (this.bills != null) {
      data['bills'] = this.bills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientCashbackData {
  int? id;
  int? availableCashback;
  int? pendingCashback;
  String? payTackUserId;
  String? payTackUser;

  ClientCashbackData(
      {this.id,
      this.availableCashback,
      this.pendingCashback,
      this.payTackUserId,
      this.payTackUser});

  ClientCashbackData.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    availableCashback = json['availableCashback'];
    pendingCashback = json['pendingCashback'];
    payTackUserId = json['payTackUserId'];
    payTackUser = json['payTackUser'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['availableCashback'] = this.availableCashback;
    data['pendingCashback'] = this.pendingCashback;
    data['payTackUserId'] = this.payTackUserId;
    data['payTackUser'] = this.payTackUser;
    return data;
  }
}

class Bills {
  int? id;
  String? businessName;
  String? imageName;
  String? uploadDateTime;
  String? status;
  int? billAmount;
  int? approvedAmount;
  String? payTackUserId;
  String? payTackUser;

  Bills(
      {this.id,
      this.businessName,
      this.imageName,
      this.uploadDateTime,
      this.status,
      this.billAmount,
      this.approvedAmount,
      this.payTackUserId,
      this.payTackUser});

  Bills.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    businessName = json['businessName'];
    imageName = json['imageName'];
    uploadDateTime = json['uploadDateTime'];
    status = json['status'];
    billAmount = json['billAmount'];
    approvedAmount = json['approvedAmount'];
    payTackUserId = json['payTackUserId'];
    payTackUser = json['payTackUser'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['businessName'] = this.businessName;
    data['imageName'] = this.imageName;
    data['uploadDateTime'] = this.uploadDateTime;
    data['status'] = this.status;
    data['billAmount'] = this.billAmount;
    data['approvedAmount'] = this.approvedAmount;
    data['payTackUserId'] = this.payTackUserId;
    data['payTackUser'] = this.payTackUser;
    return data;
  }
}
