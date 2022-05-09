// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:colour/colour.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

class CovidStatistics extends StatefulWidget {
  const CovidStatistics({key}) : super(key: key);
  static const String idScreen = "CovidStatistics";

  @override
  _CovidStatisticsState createState() => _CovidStatisticsState();
}

class _CovidStatisticsState extends State<CovidStatistics> {
  TextEditingController hospitalCountyEditingController =
      TextEditingController();

  final Connectivity _connectivity = Connectivity();

  String enteredCountryName = "Kenya";
  String countryName = "";

  late String formattedDate;
  late BannerAd inlineBannerAd;
  bool adLoaded = false;
  static const AdRequest request = AdRequest(nonPersonalizedAds: false);
  var now;
  var date;

  var worldWideConfirmedCases = 0;
  var worldWideConfirmedDeaths = 0;
  var worldWideNewCases = 0;
  var worldWideNewDeaths = 0;
  dynamic formattedworldWideConfirmedCases = 0;
  dynamic formattedworldWideConfirmedDeaths = 0;
  dynamic formattedworldWideNewCases = 0;
  dynamic formattedworldWideNewDeaths = 0;

  var deaths = 0;
  dynamic newDeaths = 0;
  var confirmedCases = 0;
  dynamic confirmedNewCases = 0;
  String placeHolderVariable = "-";
  dynamic formatteddeaths = 0;
  dynamic formattednewDeaths = 0;
  dynamic formattedconfirmedCases = 0;
  dynamic formattedconfirmedNewCases = 0;

  String country = "Kenya";

  List covidDataList = [];
  List confirmedcase = [];

  var responseData;
  var myCountryNameData;

  var formatter = NumberFormat('###,###,###,000');

  // getTodaysDate() {
  //   setState(
  //     () {
  //       now = DateTime.now().toString();
  //       date = DateTime.parse(now);
  //       // formattedDate = "${date.year}-${date.month}-${date.day - 1}";
  //       formattedDate = formatDate(
  //           DateTime(date.year, date.month, date.day - 1),
  //           [yyyy, "-", mm, "-", dd]);
  //     },
  //   );
  // }

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

  checkIfConnectedToInternet() async {
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      print("Mobile");
      // I am connected to a mobile network.
      getCovidData();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("Wifi");
      // I am connected to a wifi network.
      getCovidData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "No Internet Connection",
            textAlign: TextAlign.center,
          ),
        ),
      );
      print("No Conectivity");
      setState(() {
        covidDataList.add("-");
        covidDataList.add("-");
        covidDataList.add("-");
        covidDataList.add("-");
        covidDataList.add("-");

        worldWideConfirmedCases = 0;
        formattedworldWideConfirmedCases =
            formatter.format(worldWideConfirmedCases);
        worldWideConfirmedDeaths = 0;
        formattedworldWideConfirmedDeaths =
            formatter.format(worldWideConfirmedDeaths);
        worldWideNewCases = 0;
        formattedworldWideNewCases = formatter.format(worldWideNewCases);
        worldWideNewDeaths = 0;
        formattedworldWideNewDeaths = formatter.format(worldWideNewDeaths);
      });
    }
  }

  getCovidData() async {
    String myCountryName =
        "https://api.covid19api.com/live/country/$enteredCountryName";
    final myResponse = await http.get(
      Uri.parse(myCountryName),
    );

    if (myResponse.body.isNotEmpty) {
      try {
        myCountryNameData = json.decode(myResponse.body);
        countryName = myCountryNameData[0]["Country"];
      } catch (e) {
        // formattedDate = formatDate(
        //     DateTime(date.year, date.month, date.day - 2),
        //     [yyyy, "-", mm, "-", dd]);
        // getCovidData();
      }
    } else {}

    String myUrl = "https://api.covid19api.com/summary";
    final response = await http.get(
      Uri.parse(myUrl),
    );

    if (response.body.isNotEmpty) {
      responseData = json.decode(response.body);

      for (var item in responseData["Countries"]) {
        if (item["Country"] == countryName) {
          setState(() {
            enteredCountryName = countryName;

            deaths = item["TotalDeaths"];
            formatteddeaths = formatter.format(deaths);
            confirmedCases = item["TotalConfirmed"];
            formattedconfirmedCases = formatter.format(confirmedCases);

            newDeaths = item["NewDeaths"];
            formattednewDeaths = formatter.format(newDeaths);
            confirmedNewCases = item["NewConfirmed"];
            formattedconfirmedNewCases = formatter.format(confirmedNewCases);

            if (newDeaths == 0) {
              setState(() {
                formattednewDeaths = placeHolderVariable;
              });
            }
            if (confirmedNewCases == 0) {
              setState(() {
                formattedconfirmedNewCases = placeHolderVariable;
              });
            }

            covidDataList.add(item["Country"]);
            covidDataList.add(item["TotalConfirmed"]);
            covidDataList.add(item["TotalDeaths"]);
            covidDataList.add(item["NewConfirmed"]);
            covidDataList.add(item["NewDeaths"]);
          });
        }
      }
    } else {}

    setState(() {
      worldWideConfirmedCases = responseData["Global"]["TotalConfirmed"];
      formattedworldWideConfirmedCases =
          formatter.format(worldWideConfirmedCases);
      worldWideConfirmedDeaths = responseData["Global"]["TotalDeaths"];
      formattedworldWideConfirmedDeaths =
          formatter.format(worldWideConfirmedDeaths);
      worldWideNewCases = responseData["Global"]["NewConfirmed"];
      formattedworldWideNewCases = formatter.format(worldWideNewCases);
      worldWideNewDeaths = responseData["Global"]["NewDeaths"];
      formattedworldWideNewDeaths = formatter.format(worldWideNewDeaths);
    });
  }

  @override
  initState() {
    super.initState();
    // getTodaysDate();
    loadInlineBannerAd();
    checkIfConnectedToInternet();
    // getCovidData();
    Future.delayed(const Duration(seconds: 1));
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: hospitalCountyEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                    ),
                    labelText: "Search Other Countries",
                    labelStyle: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.blueGrey,
                    ),
                    hintStyle: GoogleFonts.lexendMega(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  style: GoogleFonts.lexendMega(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, right: 15, left: 15, bottom: 30),
                child: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(
                      FocusNode(),
                    );
                    setState(
                      () {
                        enteredCountryName =
                            hospitalCountyEditingController.text.toLowerCase();
                        covidDataList.clear();
                        covidDataList.clear();
                        getCovidData();
                      },
                    );
                  },
                  child: Text(
                    "Search",
                    style: GoogleFonts.lexendMega(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        width: (MediaQuery.of(context).size.width) / 2.5,
                        height: (MediaQuery.of(context).size.height) / 8,
                        decoration: BoxDecoration(
                          color: Colour("#87D68D"),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Country",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lexendMega(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            covidDataList.isEmpty
                                ? const SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    countryName,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lexendMega(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            width: (MediaQuery.of(context).size.width) / 2.5,
                            height: (MediaQuery.of(context).size.height) / 8,
                            decoration: BoxDecoration(
                              color: Colour("#E3655B"),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Total Deaths",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lexendMega(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                covidDataList.isEmpty
                                    ? const SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "$formatteddeaths",
                                        style: GoogleFonts.lexendMega(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            width: (MediaQuery.of(context).size.width) / 2.5,
                            height: (MediaQuery.of(context).size.height) / 8,
                            decoration: BoxDecoration(
                              color: Colour("#FDCA40"),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Total Confirmed Cases",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lexendMega(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                covidDataList.isEmpty
                                    ? const SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "$formattedconfirmedCases",
                                        style: GoogleFonts.lexendMega(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            width: (MediaQuery.of(context).size.width) / 2.5,
                            height: (MediaQuery.of(context).size.height) / 8,
                            decoration: BoxDecoration(
                              color: Colour("#FDCA40"),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "New Confirmed Deaths",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lexendMega(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                covidDataList.isEmpty
                                    ? const SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "$formattednewDeaths",
                                        style: GoogleFonts.lexendMega(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            width: (MediaQuery.of(context).size.width) / 2.5,
                            height: (MediaQuery.of(context).size.height) / 8,
                            decoration: BoxDecoration(
                              color: Colour("#E3655B"),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "New Confirmed Cases",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lexendMega(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                covidDataList.isEmpty
                                    ? const SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "$formattedconfirmedNewCases",
                                        style: GoogleFonts.lexendMega(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 75,
                        width: (MediaQuery.of(context).size.height) / 1.3,
                        child: AdWidget(
                          ad: inlineBannerAd,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30, right: 15, left: 15, bottom: 30),
                        child: Text(
                          "WORLD WIDE COVID STATISTICS",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lexendMega(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            width: (MediaQuery.of(context).size.width) / 2.5,
                            height: (MediaQuery.of(context).size.height) / 8,
                            decoration: const BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Total Deaths",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lexendMega(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                formattedworldWideConfirmedDeaths == 0
                                    ? const SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "$formattedworldWideConfirmedDeaths",
                                        style: GoogleFonts.lexendMega(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            width: (MediaQuery.of(context).size.width) / 2.5,
                            height: (MediaQuery.of(context).size.height) / 8,
                            decoration: const BoxDecoration(
                              color: Colors.purpleAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Total Confirmed Cases",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lexendMega(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                formattedworldWideConfirmedCases == 0
                                    ? const SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "$formattedworldWideConfirmedCases",
                                        style: GoogleFonts.lexendMega(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            width: (MediaQuery.of(context).size.width) / 2.5,
                            height: (MediaQuery.of(context).size.height) / 8,
                            decoration: const BoxDecoration(
                              color: Colors.purpleAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "New Confirmed Deaths",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lexendMega(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                formattedworldWideNewDeaths == 0
                                    ? const SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "$formattedworldWideNewDeaths",
                                        style: GoogleFonts.lexendMega(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            width: (MediaQuery.of(context).size.width) / 2.5,
                            height: (MediaQuery.of(context).size.height) / 8,
                            decoration: const BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "New Confirmed Cases",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lexendMega(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                formattedworldWideNewCases == 0
                                    ? const SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "$formattedworldWideNewCases",
                                        style: GoogleFonts.lexendMega(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class Covid19Stats {
//   final String recovered;
//   final String hospitalized;
//   final String dead;
//   final Strign new case
// }
