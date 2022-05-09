// // @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pamoja/screens/add_new_hospital.dart';
import 'package:pamoja/screens/covid_statistics.dart';
import 'package:pamoja/screens/dashboard.dart';
import 'package:pamoja/screens/developer_identity.dart';
import 'package:pamoja/screens/splash_screen.dart';
import 'package:pamoja/screens/vaccine_center_list.dart';
import 'package:pamoja/screens/vaccine_center_list_map.dart';
import 'package:pamoja/screens/vaccine_importance.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pamoja/submit_hospital_name.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [SystemUiOverlay.bottom],
  );
  await Firebase.initializeApp();
  runApp(const MyApp());
}

DatabaseReference userReferenceOne =
    FirebaseDatabase.instance.reference().child("Hospitals");
DatabaseReference userReferenceTwo =
    FirebaseDatabase.instance.reference().child("New Hospitals");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static const String idScreen = "MyApp";

  const MyApp({key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pamoja',
      routes: {
        MyApp.idScreen: (context) => const MyApp(),
        SplasScreen.idScreen: (context) => const SplasScreen(),
        DashBoardScreen.idScreen: (context) => DashBoardScreen(),
        CovidStatistics.idScreen: (context) => const CovidStatistics(),
        VaccineCenterList.idScreen: (context) => const VaccineCenterList(),
        VaccineCenterListMap.idScreen: (context) =>
            const VaccineCenterListMap(),
        VaccineImportance.idScreen: (context) => const VaccineImportance(),
        AppDeveloperIdentity.idScreen: (context) =>
            const AppDeveloperIdentity(),
        AddNewHospital.idScreen: (context) => const AddNewHospital(),
        SubmitHospitalName.idScreen: (context) => const SubmitHospitalName(),
      },
      initialRoute: SplasScreen.idScreen,
      // home: const DashBoardScreen(),
    );
  }
}
