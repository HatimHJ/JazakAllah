// class AzkarCategoryDataListModel {
//   int? id;
//   String? sId;
//   String? azkarEnglish;
//   String? azkarArabic;
//   String? azkarTurkish;
//   String? azkarUrdu;
//   String? categoryId;
//   String? timestamp;
//   String? createdAt;
//   String? updatedAt;
//   String? categoryArabic;
//   String? categoryEnglish;
//   String? categoryTurkish;
//   String? categoryUrdu;
//
//   AzkarCategoryDataListModel({
//     this.id,
//     this.sId,
//     this.azkarEnglish,
//     this.azkarArabic,
//     this.azkarTurkish,
//     this.azkarUrdu,
//     this.categoryId,
//     this.timestamp,
//     this.createdAt,
//     this.updatedAt,
//     this.categoryArabic,
//     this.categoryEnglish,
//     this.categoryTurkish,
//     this.categoryUrdu,
//   });
//
//   AzkarCategoryDataListModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     sId = json['_id'];
//     azkarEnglish = json['azkarEnglish'];
//     azkarArabic = json['azkarArabic'];
//     azkarTurkish = json['azkarTurkish'];
//     azkarUrdu = json['azkarUrdu'];
//     categoryId = json['category_id'];
//     timestamp = json['timestamp'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     categoryArabic = json['categoryArabic'];
//     categoryEnglish = json['categoryEnglish'];
//     categoryTurkish = json['categoryTurkish'];
//     categoryUrdu = json['categoryUrdu'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['_id'] = sId;
//     data['azkarEnglish'] = azkarEnglish;
//     data['azkarArabic'] = azkarArabic;
//     data['azkarTurkish'] = azkarTurkish;
//     data['azkarUrdu'] = azkarUrdu;
//     data['category_id'] = categoryId;
//     data['timestamp'] = timestamp;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['categoryArabic'] = categoryArabic;
//     data['categoryEnglish'] = categoryEnglish;
//     data['categoryTurkish'] = categoryTurkish;
//     data['categoryUrdu'] = categoryUrdu;
//     return data;
//   }
// }

class AzkarCategoryDataListModel {
  int? id;
  String? sId;
  String? azkarEnglish;
  String? azkarArabic;
  String? azkarTurkish;
  String? azkarUrdu;
  String? azkarBangla;
  String? azkarHindi;
  String? azkarFrench;
  String? categoryId;
  String? timestamp;
  String? createdAt;
  String? updatedAt;
  String? categoryArabic;
  String? categoryEnglish;
  String? categoryTurkish;
  String? categoryUrdu;

  AzkarCategoryDataListModel(
      {this.id,
        this.sId,
        this.azkarEnglish,
        this.azkarArabic,
        this.azkarTurkish,
        this.azkarUrdu,
        this.azkarBangla,
        this.azkarHindi,
        this.azkarFrench,
        this.categoryId,
        this.timestamp,
        this.createdAt,
        this.updatedAt,
        this.categoryArabic,
        this.categoryEnglish,
        this.categoryTurkish,
        this.categoryUrdu});

  AzkarCategoryDataListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sId = json['_id'];
    azkarEnglish = json['azkarEnglish'];
    azkarArabic = json['azkarArabic'];
    azkarTurkish = json['azkarTurkish'];
    azkarUrdu = json['azkarUrdu'];
    azkarBangla = json['azkarBangla'];
    azkarHindi = json['azkarHindi'];
    azkarFrench = json['azkarFrench'];
    categoryId = json['category_id'];
    timestamp = json['timestamp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryArabic = json['categoryArabic'];
    categoryEnglish = json['categoryEnglish'];
    categoryTurkish = json['categoryTurkish'];
    categoryUrdu = json['categoryUrdu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['_id'] = this.sId;
    data['azkarEnglish'] = this.azkarEnglish;
    data['azkarArabic'] = this.azkarArabic;
    data['azkarTurkish'] = this.azkarTurkish;
    data['azkarUrdu'] = this.azkarUrdu;
    data['azkarBangla'] = this.azkarBangla;
    data['azkarHindi'] = this.azkarHindi;
    data['azkarFrench'] = this.azkarFrench;
    data['category_id'] = this.categoryId;
    data['timestamp'] = this.timestamp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['categoryArabic'] = this.categoryArabic;
    data['categoryEnglish'] = this.categoryEnglish;
    data['categoryTurkish'] = this.categoryTurkish;
    data['categoryUrdu'] = this.categoryUrdu;
    return data;
  }
}
