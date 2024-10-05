class CategoryListModel {
  int? id;
  String? sId;
  String? categoryArabic;
  String? categoryEnglish;
  String? categoryTurkish;
  String? categoryUrdu;
  String? categoryBangla;
  String? categoryHindi;
  String? categoryFrench;
  String? timestamp;
  String? createdAt;
  String? updatedAt;

  CategoryListModel(
      {this.id,
        this.sId,
        this.categoryArabic,
        this.categoryEnglish,
        this.categoryTurkish,
        this.categoryUrdu,
        this.categoryBangla,
        this.categoryHindi,
        this.categoryFrench,
        this.timestamp,
        this.createdAt,
        this.updatedAt});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sId = json['_id'];
    categoryArabic = json['categoryArabic'];
    categoryEnglish = json['categoryEnglish'];
    categoryTurkish = json['categoryTurkish'];
    categoryUrdu = json['categoryUrdu'];
    categoryBangla = json['categoryBangla'];
    categoryHindi = json['categoryHindi'];
    categoryFrench = json['categoryFrench'];
    timestamp = json['timestamp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['_id'] = this.sId;
    data['categoryArabic'] = this.categoryArabic;
    data['categoryEnglish'] = this.categoryEnglish;
    data['categoryTurkish'] = this.categoryTurkish;
    data['categoryUrdu'] = this.categoryUrdu;
    data['categoryBangla'] = this.categoryBangla;
    data['categoryHindi'] = this.categoryHindi;
    data['categoryFrench'] = this.categoryFrench;
    data['timestamp'] = this.timestamp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
