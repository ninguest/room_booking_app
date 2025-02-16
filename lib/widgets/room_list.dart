// lib/widgets/room_list.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/room_provider.dart';
import 'room_card.dart';

class RoomList extends StatelessWidget {
  const RoomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomProvider>(
      builder: (context, provider, _) {
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

        if (provider.rooms.isEmpty) {
          return const Center(
            child: Text('No rooms available'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.rooms.length,
          itemBuilder: (context, index) {
            final room = provider.rooms[index];
            return RoomCard(
              room: room,
              selectedTime: provider.selectedTime,
            );
          },
        );
      },
    );
  }
}