import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:pamoja/screens/covid_statistics.dart';
import 'package:pamoja/screens/developer_identity.dart';
import 'package:pamoja/screens/vaccine_center_list.dart';
import 'package:pamoja/screens/vaccine_center_list_map.dart';
import 'package:pamoja/screens/vaccine_importance.dart';
import 'package:colour/colour.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

// ignore: must_be_immutable
class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({key}) : super(key: key);
  static const String idScreen = "DashBoardScreen";

  bool isLoaded = true;

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late BannerAd inlineBannerAd;
  bool adLoaded = false;
  static const AdRequest request = AdRequest(nonPersonalizedAds: false);


  void loadInlineBannerAd() {
    try {
      inlineBannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: BannerAd.testAdUnitId,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(
              () {
                adLoaded = true;
              },
            );
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            print("Ad failed to load ${error.message}");
          },
        ),
        request: request,
      );
    } catch (e) {
      print("Error: $e");
    }
    inlineBannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    loadInlineBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CovidStatistics.idScreen,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(25),
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colour("#87D68D"),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "COVID-19 Statistics",
                        style: GoogleFonts.lexendMega(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      VaccineCenterList.idScreen,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(25),
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colour("#E3655B"),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Vaccince Centers List",
                        style: GoogleFonts.lexendMega(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 75,
                  width: (MediaQuery.of(context).size.height) / 1.3,
                  child: AdWidget(
                    ad: inlineBannerAd,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      VaccineCenterListMap.idScreen,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(25),
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colour("#FDCA40"),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Vaccine Centers on MAP",
                        style: GoogleFonts.lexendMega(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      VaccineImportance.idScreen,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(25),
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colour("#5762D5"),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Importance",
                        style: GoogleFonts.lexendMega(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppDeveloperIdentity.idScreen,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(25),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colour("#0A0F0D"),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Developer Info",
                        style: GoogleFonts.lexendMega(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
