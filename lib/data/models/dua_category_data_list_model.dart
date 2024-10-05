// class DuaCategoryDataListModel {
//   String? sId;
//   String? duaArabic;
//   String? duaEnglish;
//   String? duaTurkish; // New field for Turkish translation
//   String? duaUrdu;
//   String? categoryArabic;
//   String? categoryEnglish;
//   String? categoryTurkish; // New field for Turkish translation
//   String? categoryUrdu;
//   String? titleArabic;
//   String? titleEnglish;
//   String? titleTurkish; // New field for Turkish translation
//   String? titleUrdu;
//   String? timestamp;
//
//   DuaCategoryDataListModel({
//     this.sId,
//     this.duaArabic,
//     this.duaEnglish,
//     this.duaTurkish,
//     this.duaUrdu,
//     this.categoryArabic,
//     this.categoryEnglish,
//     this.categoryTurkish,
//     this.categoryUrdu,
//     this.titleArabic,
//     this.titleEnglish,
//     this.titleTurkish,
//     this.titleUrdu,
//     this.timestamp,
//   });
//
//   DuaCategoryDataListModel.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     duaArabic = json['duaArabic'];
//     duaEnglish = json['duaEnglish'];
//     duaTurkish = json['duaTurkish'];
//     duaUrdu = json['duaUrdu'];
//     categoryArabic = json['categoryArabic'];
//     categoryEnglish = json['categoryEnglish'];
//     categoryTurkish = json['categoryTurkish'];
//     categoryUrdu = json['categoryUrdu'];
//     titleArabic = json['titleArabic'];
//     titleEnglish = json['titleEnglish'];
//     titleTurkish = json['titleTurkish'];
//     titleUrdu = json['titleUrdu'];
//     timestamp = json['timestamp'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['duaArabic'] = duaArabic;
//     data['duaEnglish'] = duaEnglish;
//     data['duaTurkish'] = duaTurkish;
//     data['duaUrdu'] = duaUrdu;
//     data['categoryArabic'] = categoryArabic;
//     data['categoryEnglish'] = categoryEnglish;
//     data['categoryTurkish'] = categoryTurkish;
//     data['categoryUrdu'] = categoryUrdu;
//     data['titleArabic'] = titleArabic;
//     data['titleEnglish'] = titleEnglish;
//     data['titleTurkish'] = titleTurkish;
//     data['titleUrdu'] = titleUrdu;
//     data['timestamp'] = timestamp;
//     return data;
//   }
// }

class DuaCategoryDataListModel {
  int? id;
  String? sId;
  String? duaArabic;
  String? duaEnglish;
  String? duaTurkish;
  String? duaUrdu;
  String? duaBangla;
  String? duaHindi;
  String? duaFrench;
  String? titleBangla;
  String? titleHindi;
  String? titleFrench;
  String? titleArabic;
  String? titleEnglish;
  String? titleTurkish;
  String? titleUrdu;
  String? categoryId;
  String? timestamp;
  String? createdAt;
  String? updatedAt;
  String? categoryArabic;
  String? categoryEnglish;
  String? categoryTurkish;
  String? categoryUrdu;

  DuaCategoryDataListModel(
      {this.id,
        this.sId,
        this.duaArabic,
        this.duaEnglish,
        this.duaTurkish,
        this.duaUrdu,
        this.duaBangla,
        this.duaHindi,
        this.duaFrench,
        this.titleBangla,
        this.titleHindi,
        this.titleFrench,
        this.titleArabic,
        this.titleEnglish,
        this.titleTurkish,
        this.titleUrdu,
        this.categoryId,
        this.timestamp,
        this.createdAt,
        this.updatedAt,
        this.categoryArabic,
        this.categoryEnglish,
        this.categoryTurkish,
        this.categoryUrdu});

  DuaCategoryDataListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sId = json['_id'];
    duaArabic = json['duaArabic'];
    duaEnglish = json['duaEnglish'];
    duaTurkish = json['duaTurkish'];
    duaUrdu = json['duaUrdu'];
    duaBangla = json['duaBangla'];
    duaHindi = json['duaHindi'];
    duaFrench = json['duaFrench'];
    titleBangla = json['titleBangla'];
    titleHindi = json['titleHindi'];
    titleFrench = json['titleFrench'];
    titleArabic = json['titleArabic'];
    titleEnglish = json['titleEnglish'];
    titleTurkish = json['titleTurkish'];
    titleUrdu = json['titleUrdu'];
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
    data['duaArabic'] = this.duaArabic;
    data['duaEnglish'] = this.duaEnglish;
    data['duaTurkish'] = this.duaTurkish;
    data['duaUrdu'] = this.duaUrdu;
    data['duaBangla'] = this.duaBangla;
    data['duaHindi'] = this.duaHindi;
    data['duaFrench'] = this.duaFrench;
    data['titleBangla'] = this.titleBangla;
    data['titleHindi'] = this.titleHindi;
    data['titleFrench'] = this.titleFrench;
    data['titleArabic'] = this.titleArabic;
    data['titleEnglish'] = this.titleEnglish;
    data['titleTurkish'] = this.titleTurkish;
    data['titleUrdu'] = this.titleUrdu;
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