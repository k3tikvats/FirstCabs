# FirstCabs - Ride-Hailing App

A Flutter-based ride-hailing application that provides real-time location tracking, route optimization, and fare estimation.

## Features

- Real-time location tracking and navigation
- Multiple vehicle categories (Mini, Sedan, SUV, XUV)
- Dynamic fare calculation based on distance
- Route visualization using Google Maps
- Recent location history
- Multiple payment options (Cash, UPI, Coupons)

## Tech Stack

- Flutter 3.x
- Google Maps API
- Firebase (Authentication & Realtime Database)
- Flutter Polyline Points
- Geolocator

## Prerequisites

- Flutter SDK
- Android Studio / VS Code
- Google Maps API key
- Firebase project setup

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/firstcabs.git
```

2. Add Google Maps API key:
   - Create `android/app/src/main/res/values/strings.xml`:
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="google_maps_key">YOUR_API_KEY</string>
</resources>
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── models/
│   ├── user.dart
│   └── ride.dart
├── screens/
│   ├── map_page.dart
│   └── vehicle_selection.dart
├── services/
│   ├── location_service.dart
│   └── payment_service.dart
└── main.dart
```

## Environment Variables

Create a `.env` file in the project root:

```
GOOGLE_MAPS_API_KEY=your_api_key
FIREBASE_API_KEY=your_firebase_key
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

Project Link: [https://github.com/k3tikvats/firstcabs](https://github.com/yourusername/firstcabs)