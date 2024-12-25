import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  final String startPoint;
  final String endPoint;

  const MapPage({required this.startPoint, required this.endPoint, Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> _polylineCoordinates = [];
  double? estimatedFare;
  int _selectedVehicleIndex = 0;

  final List<Map<String, String>> vehicles = [
    {'type': 'Mini', 'desc': 'Compact mini', 'price': '₹500.94', 'time': '13 min away'},
    {'type': 'Sedan', 'desc': 'Affordable sedan', 'price': '₹500.94', 'time': '13 min away'},
    {'type': 'SUV', 'desc': 'Comfortable SUV', 'price': '₹500.94', 'time': '13 min away'},
    {'type': 'XUV', 'desc': 'Spacious XUV', 'price': '₹500.94', 'time': '13 min away'},
    {'type': 'Go Rental', 'desc': 'Sedan, Mini, SUV', 'price': '₹500.94', 'time': '13 min away'},
  ];

  @override
  void initState() {
    super.initState();
    _getDirections();
  }

  Future<void> _getDirections() async {
    try {
      LatLng startLatLng = await _getLatLngFromAddress(widget.startPoint);
      LatLng endLatLng = await _getLatLngFromAddress(widget.endPoint);

      setState(() {
        _markers.add(Marker(markerId: const MarkerId('start'), position: startLatLng));
        _markers.add(Marker(markerId: const MarkerId('end'), position: endLatLng));
      });

      await _fetchRoute(startLatLng, endLatLng);

      double distanceInKm = Geolocator.distanceBetween(
        startLatLng.latitude,
        startLatLng.longitude,
        endLatLng.latitude,
        endLatLng.longitude,
      ) / 1000;
      setState(() {
        estimatedFare = (50 + 20 + distanceInKm * 10) * 1.2;
      });
    } catch (e) {
      print('Error getting directions: $e');
    }
  }
  Future<LatLng> _getLatLngFromAddress(String address) async {
    if (address.toLowerCase().contains('indira gandhi')) {
      return LatLng(28.5562, 77.1000);
    } else if (address.toLowerCase().contains('rohini')) {
      return LatLng(28.7362, 77.1234);
    }
    else if (address.toLowerCase().contains('huda city')) {
      return LatLng(28.4592, 77.0725);
    } else if (address.toLowerCase().contains('punjabi bagh')) {
      return LatLng(28.6620, 77.1242);
    }

    return LatLng(28.7041, 77.1025); // Default for Delhi
  }

  Future<void> _fetchRoute(LatLng start, LatLng end) async {
    // Fetch the route using Directions API or Polyline Points package
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyB8ktFpX6ItlkEAIXk_EPEAiLD_bS0OjFs',
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(end.latitude, end.longitude),
    );

    if (result.status == 'OK') {
    print('Route Points: ${result.points}');
    setState(() {
      _polylineCoordinates =
          result.points.map((point) => LatLng(point.latitude, point.longitude)).toList();
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          color: Colors.blue,
          width: 5,
          points: _polylineCoordinates,
        ),
      );
    });
  } else {
    print('Error fetching route: ${result.errorMessage}');
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(28.7041, 77.1025),
              zoom: 12,
            ),
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
          ),
          Positioned(
            top: 40,
            left: 16,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text('You', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Choose your vehicle',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          _buildFilterChip('Recommended', true),
                          const SizedBox(width: 8),
                          _buildFilterChip('Price', false),
                          const SizedBox(width: 8),
                          _buildFilterChip('Time', false),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: vehicles.length,
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemBuilder: (context, index) {
                          final vehicle = vehicles[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: Icon(Icons.directions_car),
                            ),
                            title: Text(vehicle['type']!),
                            subtitle: Text(vehicle['desc']!),
                            trailing: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(vehicle['price']!,
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text(vehicle['time']!,
                                    style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.play_circle_outline, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Save 10% by watching ads',
                              style: TextStyle(color: Colors.white)),
                          SizedBox(width: 8),
                          Icon(Icons.info_outline, color: Colors.white, size: 16),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPaymentOption(Icons.payments_outlined, 'Cash'),
                          _buildPaymentOption(Icons.account_balance_wallet_outlined, 'UPI'),
                          _buildPaymentOption(Icons.confirmation_number_outlined, 'Coupon'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Book Your Ride'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }

  Widget _buildPaymentOption(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  // Keep your existing _getLatLngFromAddress and _fetchRoute methods
}