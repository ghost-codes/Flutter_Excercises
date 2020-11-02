class Location{
  String lat, lng;

  Location({this.lat, this.lng});
}

class ElevatedLocation extends Location{
  ElevatedLocation(String lat, String lng): super(lat: lat,lng: lng);
}