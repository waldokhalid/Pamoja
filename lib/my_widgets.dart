// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SearchforCounty extends StatefulWidget {
//   // const SearchforCounty({key}) : super(key: key);
//   final String county;
//   SearchforCounty({this.county});

//   @override
//   _SearchforCountyState createState() => _SearchforCountyState();
// }

// class _SearchforCountyState extends State<SearchforCounty> {
//   TextEditingController hospitalCountyEditingController =
//       TextEditingController();
//   final databaseReference = FirebaseDatabase.instance.reference();
//   FirebaseAuth auth = FirebaseAuth.instance;
//   List<Hospitals> driverList = [];

//   Future<List<Hospitals>> getDriverDetails() async {
//     databaseReference.child("Hospitals").child("Nairobi").onValue.listen(
//       (event) {
//         setState(
//           () {
//             var value = event.snapshot.value;
//             driverList = Map.from(value)
//                 .values
//                 .map((e) => Hospitals.fromJson(Map.from(e)))
//                 .toList();
//           },
//         );
//       },
//     );
//     return driverList;
//   }

//   @override
//   void initState() {
//     super.initState();
//     getDriverDetails();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.grey[100],
//         centerTitle: true,
//         elevation: 0,
//         iconTheme: IconThemeData(
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
//       body: SingleChildScrollView(
//         child: driverList.isEmpty
//             ? Center(
//                 // child: CircularProgressIndicator(),
//                 child: Text("No Vaccine Center in this County"),
//               )
//             : ListView.builder(
//                 itemCount: driverList.length,
//                 itemBuilder: (context, int index) {
//                   final Hospitals hospitals = driverList[index];
//                   final String hospitalLocaiton = hospitals.location;
//                   final String hospitalName = hospitals.name;
//                   final String hospitalPhone = hospitals.phone;
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       elevation: 0,
//                       child: ExpansionTile(
//                         title: Text(
//                           hospitalName.toUpperCase(),
//                           style: GoogleFonts.lexendMega(),
//                           textAlign: TextAlign.center,
//                         ),
//                         children: [
//                           Column(
//                             children: [
//                               Text(
//                                 hospitalPhone,
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.lexendMega(fontSize: 13),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 hospitalLocaiton,
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.lexendMega(fontSize: 13),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }

// class Hospitals {
//   final String name;
//   final String phone;
//   final String location;

//   Hospitals({
//     this.name,
//     this.phone,
//     this.location,
//   });

//   static Hospitals fromJson(Map<String, dynamic> json) {
//     return Hospitals(
//       name: json['HospitalName'],
//       phone: json['HospitalPhone'],
//       location: json['HospitalAddres'],
//     );
//   }
// }
