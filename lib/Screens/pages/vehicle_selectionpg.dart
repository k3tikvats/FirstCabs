import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';

class VehicleSelectionPage extends StatefulWidget {
  final String startPoint;
  final String endPoint;

  const VehicleSelectionPage({
    required this.startPoint, 
    required this.endPoint, 
    Key? key
  }) : super(key: key);

  @override
  State<VehicleSelectionPage> createState() => _VehicleSelectionPageState();
}

class _VehicleSelectionPageState extends State<VehicleSelectionPage> {
  GoogleMapController? mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> _polylineCoordinates = [];
  int _selectedVehicleIndex = 0;

  final List<VehicleType> vehicles = [
    VehicleType(
      name: 'Mini',
      description: 'Compact mini',
      price: '₹500.94',
      timeAway: '13 min away',
      image: 'assets/mini_car.png',
    ),
    VehicleType(
      name: 'Sedan',
      description: 'Affordable sedan',
      price: '₹500.94',
      timeAway: '13 min away',
      image: 'assets/sedan_car.png',
    ),
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
        _markers.add(
          Marker(
            markerId: const MarkerId('start'),
            position: startLatLng,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
        _markers.add(
          Marker(
            markerId: const MarkerId('end'),
            position: endLatLng,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      });

      await _fetchRoute(startLatLng, endLatLng);
    } catch (e) {
      print('Error getting directions: $e');
    }
  }

  Future<LatLng> _getLatLngFromAddress(String address) async {
    // Mock coordinates for demo
    if (address.toLowerCase().contains('delhi')) {
      return const LatLng(28.7041, 77.1025);
    }
    return const LatLng(28.6139, 77.2090);
  }

  Future<void> _fetchRoute(LatLng start, LatLng end) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyB8ktFpX6ItlkEAIXk_EPEAiLD_bS0OjFs',
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(end.latitude, end.longitude),
    );

    if (result.points.isNotEmpty) {
      setState(() {
        _polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
        _polylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            color: Colors.blue,
            points: _polylineCoordinates,
            width: 4,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map
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
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          
          // Back Button and "You" tag
          Positioned(
            top: 40,
            left: 16,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'You',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // Vehicle Selection Panel
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Choose your vehicle',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Filter Options
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        _buildFilterChip(Icons.thumb_up, 'Recommended', true),
                        const SizedBox(width: 8),
                        _buildFilterChip(Icons.attach_money, 'Price', false),
                        const SizedBox(width: 8),
                        _buildFilterChip(Icons.access_time, 'Time', false),
                      ],
                    ),
                  ),
                  // Vehicle List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: vehicles.length,
                    itemBuilder: (context, index) {
                      return _buildVehicleItem(vehicles[index], index);
                    },
                  ),
                  // Save 10% Banner
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Save 10% by watching ads',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.info_outline, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                  // Payment Options
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPaymentOption(Icons.money, 'Cash'),
                        _buildPaymentOption(Icons.account_balance_wallet, 'UPI'),
                        _buildPaymentOption(Icons.confirmation_number, 'Coupon'),
                      ],
                    ),
                  ),
                  // Book Ride Button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Book Your Ride'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(IconData icon, String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: isSelected ? Colors.white : Colors.black),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleItem(VehicleType vehicle, int index) {
    return ListTile(
      leading: Image.asset(vehicle.image, width: 60),
      title: Text(
        vehicle.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(vehicle.description),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            vehicle.price,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            vehicle.timeAway,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
      onTap: () => setState(() => _selectedVehicleIndex = index),
      selected: _selectedVehicleIndex == index,
    );
  }

  Widget _buildPaymentOption(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class VehicleType {
  final String name;
  final String description;
  final String price;
  final String timeAway;
  final String image;

  VehicleType({
    required this.name,
    required this.description,
    required this.price,
    required this.timeAway,
    required this.image,
  });
}