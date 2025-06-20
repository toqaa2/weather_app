class City {
  final String name;
  final String temperature;
  final String humidity;
  final String cloudiness;

  City({
    required this.name,
    required this.temperature,
    required this.humidity,
    required this.cloudiness,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['location']['name'],
      temperature: json['current']['temp_c'].toString(),
      humidity: json['current']['humidity'].toString(),
      cloudiness: json['current']['condition']['text'],
    );
  }
}