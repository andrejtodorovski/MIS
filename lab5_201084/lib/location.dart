class Location {
  final String name;
  final double latitude;
  final double longitude;

  Location(
      {required this.name, required this.latitude, required this.longitude});

  static List<Location> getLocations() {
    return [
      Location(name: "FINKI", latitude: 42.004486, longitude: 21.4072295),
      Location(name: "FEIT", latitude: 42.0049858, longitude: 21.4034476),
      Location(name: "TMF", latitude: 42.0048406, longitude: 21.4072156)
    ];
  }

  static Location finki = Location.getLocations()[0];
  static Location feit = Location.getLocations()[1];
  static Location tmf = Location.getLocations()[2];
}
