enum ActivityType {
  running,
  cycling,
  swimming;

  const ActivityType();

  static ActivityType valueOf(String value) {
    switch (value) {
      case 'running':
        return running;
      case 'cycling':
        return cycling;
      case 'swimming':
        return swimming;
      default:
        throw ArgumentError('Invalid value for ActivityType: $value');
    }
  }
}

class Activity{
  const Activity({
    required this.name,
    required this.type,
    required this.distance,
    required this.time,
    required this.date,
  });

  final String name;
  final ActivityType type;
  final int distance;
  final int time;
  final String date;

  @override
  String toString() => 'Activity($type, $distance, $time, $date)';

  static Activity fromJson(Map<String, dynamic> json){
    return Activity(
      name: json['name'],
      type: ActivityType.valueOf(json['type'].toString().toLowerCase()),
      distance: json['distance'],
      time: json['time'],
      date: json['date'],
    );
  }
}