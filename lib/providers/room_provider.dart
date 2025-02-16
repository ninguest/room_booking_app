// lib/providers/room_provider.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/room.dart';

class RoomProvider with ChangeNotifier {
  List<Room> _rooms = [];
  DateTime _selectedDate = DateTime.now();
  String _selectedTime = "08:00";
  bool _isLoading = false;
  String? _error;
  String _sortBy = "level"; // Options: level, capacity, availability

  // Getters
  List<Room> get rooms => _sortRooms();
  DateTime get selectedDate => _selectedDate;
  String get selectedTime => _selectedTime;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch rooms from API
  Future<void> fetchRooms() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://gist.githubusercontent.com/yuhong90/7ff8d4ebad6f759fcc10cc6abdda85cf/raw/463627e7d2c7ac31070ef409d29ed3439f7406f6/room-availability.json'));

      if (response.statusCode == 200) {
        final List<dynamic> roomsJson = json.decode(response.body);
        _rooms = roomsJson.map((json) => Room.fromJson(json)).toList();
        _error = null;
      } else {
        _error = 'Failed to load rooms';
      }
    } catch (e) {
      _error = 'Network error: Please check your connection';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Update selected date
  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  // Update selected time
  void setTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  // Update sort criteria
  void setSortBy(String criteria) {
    _sortBy = criteria;
    notifyListeners();
  }

  // Sort rooms based on current criteria
  List<Room> _sortRooms() {
    final sortedRooms = [..._rooms];
    switch (_sortBy) {
      case "level":
        sortedRooms.sort((a, b) => a.level.compareTo(b.level));
        break;
      case "capacity":
        sortedRooms.sort((a, b) => b.capacity.compareTo(a.capacity));
        break;
      case "availability":
        sortedRooms.sort((a, b) => b.availableSlots.compareTo(a.availableSlots));
        break;
    }
    return sortedRooms;
  }
}