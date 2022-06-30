
class Weather {
  final String cityName;
  final double temperatureCelsius;

  Weather({
    required this.cityName,
    required this.temperatureCelsius,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Weather &&
        other.cityName == cityName &&
        other.temperatureCelsius == temperatureCelsius;
  }

  @override
  int get hashCode => cityName.hashCode ^ temperatureCelsius.hashCode;
}
