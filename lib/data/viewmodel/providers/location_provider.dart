import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/notification_service.dart';

class LocationProvider extends ChangeNotifier{
  //Getting suffix of date
  String getDaySuffix(int day) {
    // Helper function to get the day suffix
    switch (day) {
      case 1:
      case 21:
      case 31:
        return 'st';
      case 2:
      case 22:
        return 'nd';
      case 3:
      case 23:
        return 'rd';
      default:
        return 'th';
    }
  }

  //Getting location (lat & long)
  Position? _position;
  Position? get initPosition => _position;
  NotificationServices notificationServices = NotificationServices();
  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

        _position = position;
        notifyListeners();

      // Call this wherever you need to update prayer times and set notifications
      await updatePrayerTimesAndSetNotification();
      await getLocationName();
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  //Get location name based on lat lon
  String _locationName = '';
  String get locationName => _locationName;

  Future<void> getLocationName() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(_position!.latitude, _position!.longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
          _locationName = "${placemark.name}, ${placemark.locality}, ${placemark.country}";
          notifyListeners();
      } else {
          _locationName = 'Location not found';
          notifyListeners();
      }
    } catch (e) {
      print("Error: $e");
        _locationName = 'Error fetching location';
      notifyListeners();
    }
  }




  Coordinates? _coordinates;
  CalculationParameters? _calculationMethod;

  final List<PrayerTimes> _prayerTimes = [];
  List<PrayerTimes>? get prayerTimes => _prayerTimes;

  Future<void> updatePrayerTimes() async {
    _calculationMethod ??= CalculationMethod.muslim_world_league.getParameters();

    _coordinates = Coordinates(_position!.latitude, _position!.longitude);
    _prayerTimes.clear();


    for (var i = 0; i <= 5; i++){
      final date = DateComponents.from(DateTime.now().add(Duration(days: i)));
      final prayerTimes = PrayerTimes(_coordinates!, date, _calculationMethod!);
      _prayerTimes.add(prayerTimes);
      notifyListeners();
    }
  }

  Future<void> setPrayerNotification() async{
    await getBool();

    //Notification Fajr
    if(fajrNotification == true){
      if(DateTime.now().isBefore(prayerTimes![0].fajr)){
        await notificationServices.zonedScheduleNotificationFajr(
            title: "It's time for your Fajr Salah",
            body: DateFormat('h:mm a').format(_prayerTimes[0].fajr),
            scheduledNotificationDateTime: _prayerTimes[0].fajr
        );
      }else{
        await notificationServices.zonedScheduleNotificationFajr(
            title: "It's time for your Fajr Salah",
            body: DateFormat('h:mm a').format(_prayerTimes[1].fajr),
            scheduledNotificationDateTime: _prayerTimes[1].fajr
        );
      }
    }

    //Notification Dhuhr
    if(dhuharNotification == true){
      if(DateTime.now().isBefore(prayerTimes![0].dhuhr)){
        await notificationServices.zonedScheduleNotificationDhuhr(
            title: "It's time for your Dhuhr Salah",
            body: DateFormat('h:mm a').format(_prayerTimes[0].dhuhr),
            scheduledNotificationDateTime: _prayerTimes[0].dhuhr
        );
      }else{
        await notificationServices.zonedScheduleNotificationDhuhr(
            title: "It's time for your Dhuhr Salah",
            body: DateFormat('h:mm a').format(_prayerTimes[1].dhuhr),
            scheduledNotificationDateTime: _prayerTimes[1].dhuhr
        );
      }
    }

    //Notification Asr
    if(asrNotification == true){
      if(DateTime.now().isBefore(prayerTimes![0].asr)){
        await notificationServices.zonedScheduleNotificationAsr(
            title: "It's time for your Asr Salah",
            body: DateFormat('h:mm a').format(_prayerTimes[0].asr),
            scheduledNotificationDateTime: _prayerTimes[0].asr
        );
      }else{
        await notificationServices.zonedScheduleNotificationAsr(
            title: "It's time for your Asr Salah",
            body: DateFormat('h:mm a').format(_prayerTimes[1].asr),
            scheduledNotificationDateTime: _prayerTimes[1].asr
        );
      }
    }

    //Notification Maghrib
    if(maghribNotification == true){
      if(DateTime.now().isBefore(prayerTimes![0].maghrib)){
        await notificationServices.zonedScheduleNotificationMaghrib(
            title: "It's time for your Maghrib Salah",
            body: DateFormat('h:mm a').format(_prayerTimes[0].maghrib),
            scheduledNotificationDateTime: _prayerTimes[0].maghrib
        );
      }else{
        await notificationServices.zonedScheduleNotificationMaghrib(
            title: "It's time for your Maghrib Salah",
            body: DateFormat('h:mm a').format(_prayerTimes[1].maghrib),
            scheduledNotificationDateTime: _prayerTimes[1].maghrib
        );
      }
    }

    //Notification Isha
    if(ishaNotification == true){
      if(DateTime.now().isBefore(prayerTimes![0].isha)){
        await notificationServices.zonedScheduleNotificationMaghrib(
            title: "It's time for your Isha Salah",
            body: DateFormat('h:mm a').format(_prayerTimes[0].isha),
            scheduledNotificationDateTime: _prayerTimes[0].isha
        );
      }else{
        await notificationServices.zonedScheduleNotificationMaghrib(
            title: "It's time for your Isha Salah",
            body: DateFormat('h:mm a').format(_prayerTimes[1].isha),
            scheduledNotificationDateTime: _prayerTimes[1].isha
        );
      }
    }
  }


  Future<void> updatePrayerTimesAndSetNotification() async {
    await updatePrayerTimes(); // Call the first method and wait for it to complete
    await setPrayerNotification(); // Call the second method
  }


  String formatPrayerTime(DateTime time) {
    return DateFormat.jm().format(time);
  }


  //Notification setting
  bool? fajrNotification;
  bool? dhuharNotification;
  bool? asrNotification;
  bool? maghribNotification;
  bool? ishaNotification;
  bool isArabic = false;
  bool isEnglish = false;
  bool isTurkish = false;
  bool isUrdu = false;



  Future<void> setBool() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('fajrNotification', true);
    await prefs.setBool('dhuharNotification', true);
    await prefs.setBool('asrNotification', true);
    await prefs.setBool('maghribNotification', true);
    await prefs.setBool('ishaNotification', true);
  }

  Future<void> getBool() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fajrNotification = prefs.getBool('fajrNotification') ?? true;
    dhuharNotification = prefs.getBool('dhuharNotification') ?? true;
    asrNotification = prefs.getBool('asrNotification') ?? true;
    maghribNotification = prefs.getBool('maghribNotification') ?? true;
    ishaNotification = prefs.getBool('ishaNotification') ?? true;
    String? language = prefs.getString('language') ?? 'en';
    if(language == 'ar'){
      isArabic = true;
      isEnglish = false;
      isTurkish = false;
      isUrdu = false;
    } else if(language == 'tr'){
      isArabic = false;
      isEnglish = false;
      isTurkish = true;
      isUrdu = false;
    } else if(language == 'ur'){
      isArabic = false;
      isEnglish = false;
      isTurkish = false;
      isUrdu = true;
    } else if(language == 'en'){
      isArabic = false;
      isEnglish = true;
      isTurkish = false;
      isUrdu = false;
    }
  }


  Future<void> settingNotification(String salah) async{
    NotificationServices notificationServices = NotificationServices();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(salah == 'fajr'){
      fajrNotification = !fajrNotification!;
      notifyListeners();
      if(fajrNotification == true){
        await prefs.setBool('fajrNotification', true);
        await setPrayerNotification();
      }else{
        await prefs.setBool('fajrNotification', false);
        notificationServices.stopNotifications(1);
      }
      notifyListeners();
    }else if(salah == 'dhuhr'){
      dhuharNotification = !dhuharNotification!;
      notifyListeners();
      if(dhuharNotification == true){
        await prefs.setBool('dhuharNotification', true);
        await setPrayerNotification();
      }else{
        await prefs.setBool('dhuharNotification', false);
        notificationServices.stopNotifications(2);
      }
      notifyListeners();
    }else if(salah == 'asr'){
      asrNotification = !asrNotification!;
      notifyListeners();
      if(asrNotification == true){
        await prefs.setBool('asrNotification', true);
        await setPrayerNotification();
      }else{
        await prefs.setBool('asrNotification', false);
        notificationServices.stopNotifications(3);
      }
      notifyListeners();
    }else if(salah == 'maghrib'){
      maghribNotification = !maghribNotification!;
      notifyListeners();
      if(maghribNotification == true){
        await prefs.setBool('maghribNotification', true);
        await setPrayerNotification();
      }else{
        await prefs.setBool('maghribNotification', false);
        notificationServices.stopNotifications(4);
      }
      notifyListeners();
    }else if(salah == 'isha'){
      ishaNotification = !ishaNotification!;
      notifyListeners();
      if(ishaNotification == true){
        await prefs.setBool('ishaNotification', true);
        await setPrayerNotification();
      }else{
        await prefs.setBool('ishaNotification', false);
        notificationServices.stopNotifications(5);
      }
      notifyListeners();
    }
  }

}