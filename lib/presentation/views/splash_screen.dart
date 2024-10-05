import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../data/viewmodel/Providers/hadith_provider.dart';
import '../../data/viewmodel/Providers/user_provider.dart';
import '../../data/viewmodel/Providers/wallpaper_provider.dart';
import '../../constants/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late GeolocatorPlatform _geolocator;
  late LocationPermission _permission;

  _getLocationPermission() async {
    _permission = await _geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await _geolocator.requestPermission();
      if (_permission != LocationPermission.whileInUse &&
          _permission != LocationPermission.always) {
        // Handle the case where the user grants permission
        // but location services are disabled
        _permission = await _geolocator.requestPermission();
      }
    }
    if (_permission == LocationPermission.deniedForever) {
      // Handle the case where the user has previously denied
      // permission and chose to never ask again
      // You can show a dialog here explaining why the permission is needed
      // and guide the user to app settings to enable it manually.
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _geolocator = GeolocatorPlatform.instance;
    _getLocationPermission();
    //Method for getting location and update prayer time
    //Provider.of<LocationProvider>(context, listen: false).getLocation();
    Provider.of<HadithProvider>(context, listen: false).fetchAllHadithData();
    Provider.of<HadithProvider>(context, listen: false).fetchAllDuaData();
    Provider.of<UserProvider>(context, listen: false).fetchAllCurrencyData();
    Provider.of<WallPaperProvider>(context, listen: false).fetchAllWallpapers();
    Provider.of<HadithProvider>(context, listen: false).getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetsPath.splashBgSVG,
      fit: BoxFit.cover,
    );
  }
}
