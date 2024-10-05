import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../data/utility/urls.dart';

class UserProvider extends ChangeNotifier{
  UserModel? _userData;
  UserModel? get userData => _userData;

  bool _userDataLoading = false;
  bool get userDataLoading => _userDataLoading;

  Future<void> fetchLoggedInUserData(bool hasUser) async{
    if(hasUser){
      _userDataLoading = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id');
      String url = "${Urls.fetchUserData}/$userId";
      final response = await http.get(Uri.parse(url));
      print("Fetch user data with response code: ${response.statusCode}");
      if(response.statusCode == 200){
        final jsonData = json.decode(response.body);
        _userData = UserModel.fromJson(jsonData);
        _userDataLoading = false;
        notifyListeners();
      } else {
        final dummyData = UserModel(
          fullName: 'Guest User',
          thumbnailUrl: 'Null',
        );
        _userData = dummyData;
        _userDataLoading = false;
        print('Failed to load Single User data: ${response.statusCode}');
      }
    } else{
      final dummyData = UserModel(
        fullName: 'Guest User',
        thumbnailUrl: 'Null',
      );
      _userData = dummyData;
      _userDataLoading = false;
      print('Its guest log in');
    }
  }


  CurrencyData? _allCurrency;
  CurrencyData? get allCurrency => _allCurrency;

// Fetching all currency data
  Future<void> fetchAllCurrencyData() async {
    String url = Urls.getAllCurrency;
    final response = await http.get(Uri.parse(url));
    print("Fetch all Currency data with response code: ${response.statusCode}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _allCurrency = CurrencyData.fromJson(data);
      notifyListeners();
    } else {
      print('Failed to load Currency data: ${response.statusCode}');
    }
  }



  //Update donation
  Future<void> updateDonationInfo(Donation data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = await prefs.getString('user_id');
    final url = Uri.parse("${Urls.updateDonation}$userId");
    var request = http.MultipartRequest('POST', url);
    request.fields['data'] = jsonEncode(data.toJson());
    var response = await request.send();
    print("Donation data updated with ${response.statusCode}");
  }


}


class UserModel {
  String? id;
  String? fullName;
  String? email;
  String? oneSignalId;
  String? timestamp;
  String? totalDonation;
  String? created_at;
  String? updated_at;
  String? originalUrl;
  String? thumbnailUrl;

  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.oneSignalId,
    this.timestamp,
    this.totalDonation,
    this.created_at,
    this.updated_at,
    this.originalUrl,
    this.thumbnailUrl,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    fullName = json['fullName'];
    email = json['email'];
    oneSignalId = json['oneSignalId'];
    timestamp = json['timestamp'];
    totalDonation = json['totalDonation'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    originalUrl = json['originalUrl'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['fullName'] = fullName;
    data['email'] = email;
    data['oneSignalId'] = oneSignalId;
    data['timestamp'] = timestamp;
    data['totalDonation'] = totalDonation;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    data['originalUrl'] = originalUrl;
    data['thumbnailUrl'] = thumbnailUrl;
    return data;
  }
}



class CurrencyData {
  //final int id;
  final String objectId;
  final String usd;
  final String bdt;
  final String inr;
  final String pkr;
  final String idr;
  final String tryValue;
  final String myr;
  final String sar;
  final String zakatId;
  final String timestamp;
  final DateTime createdAt;
  final DateTime updatedAt;

  CurrencyData({
    //required this.id,
    required this.objectId,
    required this.usd,
    required this.bdt,
    required this.inr,
    required this.pkr,
    required this.idr,
    required this.tryValue,
    required this.myr,
    required this.sar,
    required this.zakatId,
    required this.timestamp,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    return CurrencyData(
      //id: json['id'],
      objectId: json['_id'],
      usd: json['USD'],
      bdt: json['BDT'],
      inr: json['INR'],
      pkr: json['PKR'],
      idr: json['IDR'],
      tryValue: json['TRY'],
      myr: json['MYR'],
      sar: json['SAR'],
      zakatId: json['zakatId'],
      timestamp: json['timestamp'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}





class Donation {
  final int donationAmount;

  Donation({required this.donationAmount});

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      donationAmount: json['donationAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['donationAmount'] = this.donationAmount;
    return data;
  }
}
