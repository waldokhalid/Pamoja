// // ignore_for_file: prefer_typing_uninitialized_variables, unused_field

// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class VaccineCenterListMap extends StatefulWidget {
//   const VaccineCenterListMap({key}) : super(key: key);
//   static const String idScreen = "VaccineCenterListMap";

//   @override
//   _VaccineCenterListMapState createState() => _VaccineCenterListMapState();
// }

// class _VaccineCenterListMapState extends State<VaccineCenterListMap> {
//   // StreamSubscription _locationSubscription;
//   // GoogleMapController newGoogleMapController;
//   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//   final firestoreInstance = FirebaseFirestore.instance;
//   final Location _locationTracker = Location();
//   List currentCoordinates = [];
//   Location location = Location();
//   var currentLatitude;
//   var currentLongitude;
//   var currentLatForAdress;
//   var currentLongForAdress;

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static const CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//   static const CameraPosition _nairobi = CameraPosition(
//     // bearing: 192.8334901395799,
//     bearing: 100,
//     // Future.delayed(Duration(seconds: 1),),
//     target: LatLng(1.2921, 36.8219),
//     tilt: 59.440717697143555,
//     zoom: 50,
//   );

//   // void getCurrentLocation() async {
//   //   // This method grabs user location and streams updates of location to the database
//   //   try {
//   //     // Uint8List imageData = await getMarker();
//   //     var position = await _locationTracker.getLocation();
//   //     currentCoordinates.add(position.latitude);
//   //     currentCoordinates.add(position.longitude);
//   //     // goTOCurrentUserLocation();
//   //     // final randomUserUid = await getParentUID();
//   //     // if (_locationSubscription != null) {
//   //     //   _locationSubscription.cancel();
//   //     // }
//   //     // _locationSubscription = _locationTracker.onLocationChanged.listen(
//   //     //   (newLocalData) {
//   //     //     if (_controller != null) {
//   //     //       setState(() {
//   //     //         currentLatForAdress = newLocalData.latitude;
//   //     //         currentLongForAdress = newLocalData.longitude;
//   //     //       });
//   //     //     }
//   //     //   },
//   //     // );
//   //   } on PlatformException catch (e) {
//   //     if (e.code == 'PERMISSION_DENIED') {
//   //       debugPrint("Permission Denied");
//   //     }
//   //   }
//   // }

//   void initMarker(specify, specifyId) {
//     var markerIdVal = specifyId;
//     final MarkerId markerId = MarkerId(markerIdVal);
//     var lat = double.parse(specify["Latitude"]);
//     var long = double.parse(specify["Longitude"]);
//     final Marker marker = Marker(
//       markerId: markerId,
//       position: LatLng(lat, long),
//       infoWindow: InfoWindow(title: specify["HospitalName"]),
//     );
//     setState(() {
//       markers[markerId] = marker;
//     });
//   }

//   getMarkers() async {
//     firestoreInstance.collection("Hospitals").get().then((docs) {
//       if (docs.docs.isNotEmpty) {
//         for (int i = 0; i < docs.docs.length; ++i) {
//           initMarker(docs.docs[i].data(), docs.docs[i].id);
//         }
//       }
//     });
//   }

//   checkLocationPermissions() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//     // ignore: unused_local_variable
//     LocationData _locationData;

//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//   }

//   Future<void> _onMapCreated(GoogleMapController controller) async {
//     var position = await _locationTracker.getLocation();
//     currentLatitude = position.latitude;
//     currentLongitude = position.longitude;
//     setState(
//       () {
//         controller.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(currentLatitude, currentLongitude),
//               zoom: 12.0,
//               tilt: 0,
//             ),
//           ),
//         );
//       },
//     );
//     Future.delayed(const Duration(seconds: 1));
//     getMarkers();
//   }

//   // @override
//   // void dispose() {
//   //   if (_locationSubscription != null) {
//   //     _locationSubscription.cancel();
//   //   }
//   //   super.dispose();
//   // }

//   @override
//   initState() {
//     super.initState();
//     checkLocationPermissions();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         centerTitle: true,
//         elevation: 0,
//         iconTheme: const IconThemeData(
//           color: Colors.black,
//         ),
//         title: Text(
//           "Pamoja",
//           style: GoogleFonts.lexendMega(
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//             fontSize: 35,
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             padding: const EdgeInsets.only(top: 100),
//             mapType: MapType.normal,
//             rotateGesturesEnabled: true,
//             zoomControlsEnabled: false,
//             zoomGesturesEnabled: true,
//             scrollGesturesEnabled: true,
//             myLocationButtonEnabled: true,
//             myLocationEnabled: true,
//             initialCameraPosition: _nairobi,
//             onMapCreated: _onMapCreated,
//             markers: Set<Marker>.of(markers.values),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_typing_uninitialized_variables, unused_field

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VaccineCenterListMap extends StatefulWidget {
  const VaccineCenterListMap({key}) : super(key: key);
  static const String idScreen = "VaccineCenterListMap";

  @override
  _VaccineCenterListMapState createState() => _VaccineCenterListMapState();
}

class _VaccineCenterListMapState extends State<VaccineCenterListMap> {
  // StreamSubscription _locationSubscription;
  // GoogleMapController newGoogleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final firestoreInstance = FirebaseFirestore.instance;
  final Location _locationTracker = Location();
  List currentCoordinates = [];
  Location location = Location();
  var currentLatitude;
  var currentLongitude;
  var currentLatForAdress;
  var currentLongForAdress;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static const CameraPosition _nairobi = CameraPosition(
    // bearing: 192.8334901395799,
    bearing: 100,
    // Future.delayed(Duration(seconds: 1),),
    target: LatLng(1.2921, 36.8219),
    tilt: 59.440717697143555,
    zoom: 50,
  );

  // void getCurrentLocation() async {
  //   // This method grabs user location and streams updates of location to the database
  //   try {
  //     // Uint8List imageData = await getMarker();
  //     var position = await _locationTracker.getLocation();
  //     currentCoordinates.add(position.latitude);
  //     currentCoordinates.add(position.longitude);
  //     // goTOCurrentUserLocation();
  //     // final randomUserUid = await getParentUID();
  //     // if (_locationSubscription != null) {
  //     //   _locationSubscription.cancel();
  //     // }
  //     // _locationSubscription = _locationTracker.onLocationChanged.listen(
  //     //   (newLocalData) {
  //     //     if (_controller != null) {
  //     //       setState(() {
  //     //         currentLatForAdress = newLocalData.latitude;
  //     //         currentLongForAdress = newLocalData.longitude;
  //     //       });
  //     //     }
  //     //   },
  //     // );
  //   } on PlatformException catch (e) {
  //     if (e.code == 'PERMISSION_DENIED') {
  //       debugPrint("Permission Denied");
  //     }
  //   }
  // }

  void initMarker(specify, specifyId) {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    // var lat = double.parse(specify["Latitude"]);
    // var long = double.parse(specify["Longitude"]);
    var lat = specify["Latitude"];
    var long = specify["Longitude"];

    if ((lat is String) || (long is String)) {
      try {
        lat = double.parse(specify["Latitude"]);
        long = double.parse(specify["Longitude"]);
      } catch (e) {
        print("$e");
      }
    } else {
      try {
        lat = specify["Latitude"];
        long = specify["Longitude"];
      } catch (e) {
        print("$e");
      }
    }

    // dynamic hospitalPosition = LatLng(
    //   double.parse(specify["Latitude"]),
    //   double.parse(specify["Longitude"]),
    // );
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, long),
      // position: hospitalPosition,
      infoWindow: InfoWindow(
        title: specify["HospitalName"],
      ),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkers() async {
    firestoreInstance.collection("Hospitals").get().then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; ++i) {
          try {
            initMarker((docs.docs[i].data()), docs.docs[i].id);
          } catch (e) {
            // ignore: avoid_print
            print("$e");
          }
        }
      }
    });
  }

  checkLocationPermissions() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    // ignore: unused_local_variable
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    var position = await _locationTracker.getLocation();
    currentLatitude = position.latitude;
    currentLongitude = position.longitude;
    setState(
      () {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(currentLatitude, currentLongitude),
              zoom: 12.0,
              tilt: 0,
            ),
          ),
        );
      },
    );
    Future.delayed(const Duration(milliseconds: 1000));
    getMarkers();
  }

  // @override
  // void dispose() {
  //   if (_locationSubscription != null) {
  //     _locationSubscription.cancel();
  //   }
  //   super.dispose();
  // }

  @override
  initState() {
    super.initState();
    checkLocationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Pamoja",
          style: GoogleFonts.lexendMega(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 35,
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: const EdgeInsets.only(top: 100),
            mapType: MapType.normal,
            rotateGesturesEnabled: true,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            scrollGesturesEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: _nairobi,
            onMapCreated: _onMapCreated,
            markers: Set<Marker>.of(markers.values),
          ),
        ],
      ),
    );
  }
}
