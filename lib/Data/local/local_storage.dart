import 'package:weather_pro/Data/Model/location.dart';

abstract  class LocalStorage{
  void addLocation(LocationModel locationModel) ;
  LocationModel getLocation();
  void updateLocation(LocationModel locationModel);
  void deleteLocation() ;
  void updateLocationScreenState();

}