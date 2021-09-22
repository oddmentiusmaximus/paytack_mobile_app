class CategoriesModel {
  String? businessName;
  String? category;

  CategoriesModel({
    this.businessName,
    this.category,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    businessName = json['businessName'];
    category = json['category'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();

    data['businessName'] = this.businessName;
    data['category'] = this.category;

    return data;
  }
}
