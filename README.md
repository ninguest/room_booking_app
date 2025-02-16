# Room Booking App

A Flutter application for booking meeting rooms in an office space.

## Features

- View available rooms by date and time
- Sort rooms by level, capacity, or availability
- QR code scanning for quick room booking
- Responsive design for various screen sizes
- Offline support with data caching
- Error handling and retry mechanisms

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / Xcode

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/room_booking.git
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Running Tests

```bash
flutter test
```

## Project Structure

```
room_booking/
├── lib/
│   ├── main.dart                  # App entry point with theme and provider setup
│   ├── models/
│   │   └── room.dart             # Room data model
│   ├── providers/
│   │   └── room_provider.dart    # State management for rooms
│   ├── screens/
│   │   ├── room_listing_screen.dart    # Main screen with room list
│   │   ├── qr_scanner_screen.dart      # QR code scanner screen
│   │   └── booking_screen.dart         # Webview for booking confirmation
│   ├── services/
│   │   └── room_service.dart     # API handling for room data
│   └── widgets/
│       ├── date_time_picker.dart  # Date and time selection widget
│       ├── room_list.dart         # List of available rooms
│       ├── room_card.dart         # Individual room display
│       └── sort_button.dart       # Room sorting options
├── test/
│   ├── room_provider_test.dart
│   └── room_service_test.dart
├── pubspec.yaml                   # Project dependencies
└── README.md                      # Project documentation
```

## Architecture

The app follows a feature-first architecture with clean separation of concerns:

- Provider for state management
- Repository pattern for data handling
- Service layer for API communication
- Proper error handling and loading states
- Modular and reusable widgets

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
```