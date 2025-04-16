// //import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// class LocationScreen extends StatefulWidget {
//   const LocationScreen({
//     super.key,
//   });

//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   getCurrentLocation() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       print("Location Denied");
//      // LocationPermission get = await Geolocator.requestPermission();
//     } else {
//       Position currentPosition = await Geolocator.getCurrentPosition(
//            desiredAccuracy: LocationAccuracy.high);

//       print("Lattitude=${currentPosition.latitude.toString()}");
//       print("Longitude=${currentPosition.longitude.toString()}");
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("GeoLocator"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//             onPressed: getCurrentLocation, child: const Text("GetLocation")),
//       ),
//     );
//   }
// }
