// lib/widgets/sort_button.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/room_provider.dart';

class SortButton extends StatelessWidget {
  const SortButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.sort),
      tooltip: 'Sort rooms',
      onSelected: (value) {
        context.read<RoomProvider>().setSortBy(value);
      },
      itemBuilder: (BuildContext context) => [
        _buildPopupMenuItem(
          value: 'level',
          icon: Icons.apartment,
          text: 'Sort by Level',
        ),
        _buildPopupMenuItem(
          value: 'capacity',
          icon: Icons.people,
          text: 'Sort by Capacity',
        ),
        _buildPopupMenuItem(
          value: 'availability',
          icon: Icons.event_available,
          text: 'Sort by Availability',
        ),
      ],
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem({
    required String value,
    required IconData icon,
    required String text,
  }) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}