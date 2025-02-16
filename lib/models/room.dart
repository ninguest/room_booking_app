// lib/models/room.dart
class Room {
  final String name;
  final int capacity;
  final String level;
  final Map<String, String> availability;

  Room({
    required this.name,
    required this.capacity,
    required this.level,
    required this.availability,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['name'] as String,
      capacity: int.parse(json['capacity']),
      level: json['level'] as String,
      availability: Map<String, String>.from(json['availability'] as Map),
    );
  }

  bool isAvailableAt(String time) {
    return availability[time] == "1";
  }

  int get availableSlots {
    return availability.values.where((value) => value == "1").length;
  }
}