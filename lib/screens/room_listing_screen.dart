// lib/screens/room_listing_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/room_provider.dart';
import 'qr_scanner_screen.dart';

class RoomListingScreen extends StatefulWidget {
  const RoomListingScreen({super.key});

  @override
  State<RoomListingScreen> createState() => _RoomListingScreenState();
}

class _RoomListingScreenState extends State<RoomListingScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch rooms when screen loads
    Future.microtask(() =>
        context.read<RoomProvider>().fetchRooms()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Booking'),
        actions: [
          // Sort Button
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              context.read<RoomProvider>().setSortBy(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "level",
                child: Text("Sort by Level"),
              ),
              const PopupMenuItem(
                value: "capacity",
                child: Text("Sort by Capacity"),
              ),
              const PopupMenuItem(
                value: "availability",
                child: Text("Sort by Availability"),
              ),
            ],
          ),
          // QR Scanner Button
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QRScannerScreen(),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Date & Time Selector
          _buildDateTimePicker(),
          // Room List
          Expanded(
            child: Consumer<RoomProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (provider.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          provider.error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => provider.fetchRooms(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return _buildRoomList(provider);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimePicker() {
    final provider = context.watch<RoomProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextButton.icon(
              icon: const Icon(Icons.calendar_today),
              label: Text(
                "${provider.selectedDate.day}/${provider.selectedDate.month}/${provider.selectedDate.year}",
              ),
              onPressed: () => _selectDate(context),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              icon: const Icon(Icons.access_time),
              label: Text(provider.selectedTime),
              onPressed: () => _selectTime(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomList(RoomProvider provider) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: provider.rooms.length,
      itemBuilder: (context, index) {
        final room = provider.rooms[index];
        final isAvailable = room.isAvailableAt(provider.selectedTime);

        return Card(
          child: ListTile(
            title: Text(room.name),
            subtitle: Text('Level ${room.level} • Capacity: ${room.capacity}'),
            trailing: Icon(
              isAvailable ? Icons.check_circle : Icons.cancel,
              color: isAvailable ? Colors.green : Colors.red,
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final provider = context.read<RoomProvider>();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: provider.selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      provider.setDate(picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final provider = context.read<RoomProvider>();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute == 0 ? "00" : "30";
      provider.setTime("$hour:$minute");
    }
  }
}