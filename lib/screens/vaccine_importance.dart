import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

class VaccineImportance extends StatefulWidget {
  static const String idScreen = "VaccineImportance";
  const VaccineImportance({key}) : super(key: key);

  static const AdRequest request = AdRequest(nonPersonalizedAds: false);

  @override
  State<VaccineImportance> createState() => _VaccineImportanceState();
}

class _VaccineImportanceState extends State<VaccineImportance> {
  late BannerAd inlineBannerAd;

  bool adLoaded = false;

  // ignore: non_constant_identifier_names
  _launchUrl_url(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  // Future openFile({required String url, String? fileName}) async {
  //   await downloadFile(url, fileNmae!);
  // }

  // Future<File?> downloadFile(String url, String name)async{
  //   final appStorage = await getApplicationDocumentsDirectory();
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
        request: VaccineImportance.request,
      );
    } catch (e) {
      print("Error: $e");
    }
    inlineBannerAd.load();
  }

  @override
  initState() {
    // super.initState();
    loadInlineBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTileCard(
                  title: Text(
                    "Common Myths and Facts About The Vacccine",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexendMega(),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "The Informatiion below in provided by the Center of Diesese Control (CDC)",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          color: Colors.redAccent,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        var infoLink =
                            "https://www.cdc.gov/coronavirus/2019-ncov/vaccines/facts.html";

                        _launchUrl_url(infoLink);
                      },
                      child: Text(
                        "CDC",
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.redAccent),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "1. Do COVID-19 vaccines contain microchips?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "No. COVID-19 vaccines do not contain microchips. Vaccines are developed to fight against disease and are not administered to track your movement. Vaccines work by stimulating your immune system to produce antibodies, exactly like it would if you were exposed to the disease. After getting vaccinated, you develop immunity to that disease, without having to get the disease first.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "2. Will the COVID-19 vaccines make me magnetic?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "No. Receiving a COVID-19 vaccine will not make you magnetic, including at the site of vaccination which is usually your arm. COVID-19 vaccines do not contain ingredients that can produce an electromagnetic field at the site of your injection. All COVID-19 vaccines are free from metals.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "3. Do any of the COVID-19 vaccines authorized for use in the United States shed or release any of their components?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "No. Vaccine shedding is the term used to describe the release or discharge of any of the vaccine components in or outside of the body. Vaccine shedding can only occur when a vaccine contains a weakened version of the virus. None of the vaccines authorized for use in the U.S. contain a live virus. mRNA and viral vector vaccines are the two types of currently authorized COVID-19 vaccines available.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "4. Is it safe for me to get a COVID-19 vaccine if I would like to have a baby one day?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "Yes. COVID-19 vaccination is recommended for everyone 12 years of age or older, including people who are trying to get pregnant now or might become pregnant in the future, as well as their partners.\nCurrently no evidence shows that any vaccines, including COVID-19 vaccines, cause fertility problems (problems trying to get pregnant) in women or men.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "5. Will a COVID-19 vaccine alter my DNA?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "No. COVID-19 vaccines do not change or interact with your DNA in any way. Both mRNA and viral vector COVID-19 vaccines deliver instructions (genetic material) to our cells to start building protection against the virus that causes COVID-19. However, the material never enters the nucleus of the cell, which is where our DNA is kept.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "6. Will getting a COVID-19 vaccine cause me to test positive for COVID-19 on a viral test?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "No. None of the authorized and recommended COVID-19 vaccines cause you to test positive on viral tests, which are used to see if you have a current infection.​\nIf your body develops an immune response to vaccination, which is the goal, you may test positive on some antibody tests. Antibody tests indicate you had a previous infection and that you may have some level of protection against the virus.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: ExpansionTileCard(
                  title: Text(
                    "5 Reasons to get Vaccinated",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexendMega(),
                  ),
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     "The Informatiion below in provided by the Center of Diesese Control (CDC)",
                    //     textAlign: TextAlign.center,
                    //     style: GoogleFonts.lexendMega(
                    //       color: Colors.redAccent,
                    //     ),
                    //   ),
                    // ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     var infoLink = "";
                    //     _launchUrl_url(infoLink);
                    //   },
                    //   child: Text(
                    //     "CDC",
                    //     style: GoogleFonts.lexendMega(
                    //       fontSize: 12,
                    //     ),
                    //   ),
                    //   style:
                    //       ElevatedButton.styleFrom(primary: Colors.redAccent),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "1. Vaccines are your only protection if you are exposed",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "Once the virus makes it into your body, it encounters protective antibodies generated by the vaccine plus an army of fighter cells that make you far less likely to develop COVID-19 disease.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "2. You are protecting yourself and others",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "Since the vaccine makes you one-third as likely than the unvaccinated to get sick in response to an exposure, you are protecting not only yourself but others, too. Millions of children under age 12 cannot be vaccinated and millions more adults have health conditions that might make their vaccinations less effective. We need as many “protectors” as we can get for our children and the immunocompromised. Every adult and teenager who gets vaccinated builds a wall of protection around the people they know and love.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "3. Vaccinations are free and easy to find",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "The supply of COVID-19 vaccines is strong and it’s available for free everywhere. Go with a parent of guradian if you are under the age of 18.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "4. COVID-19 vaccines are safe and effective",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "All COVID-19 vaccines currently available have been shown to be safe and effective at preventing COVID-19. While more COVID-19 vaccines are being developed as quickly as possible, routine processes and procedures remain in place to ensure the safety of any vaccine authorised for use. Safety is a top priority, and there are many reasons to get vaccinated. None of the COVID-19 vaccines can make you sick with COVID-19.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "5. Millions of other people your age have already done it",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "If you’ve been waiting to see how other people reacted to the vaccine, the answer is clear: So far, the vaccines have all been proven to be safe and highly effective.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 8.0,
                ),
                child: ExpansionTileCard(
                  title: Text(
                    "Common Signs And Symptoms of COVID-19",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexendMega(),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "For more information click the button below",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          color: Colors.redAccent,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // get info link from google
                        var infoLink =
                            "https://www.who.int/health-topics/coronavirus#tab=tab_3";
                        _launchUrl_url(infoLink);
                      },
                      child: Text(
                        "More Info",
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Most Common Symptoms",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text(
                        "Fever",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text(
                        "Dry Cough",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text(
                        "Tiredness",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Less Common Symptoms",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text(
                        "Aches and Pain",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text(
                        "Soar Throat",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Text(
                        "Diarrhoea",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Conjunctivitis",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Text(
                        "Headache",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Text(
                        "Loss of Taste, Smell or Sight",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Text(
                        "A rash on skin, or discolouration of fingers or toes",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Serious Symptoms",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Text(
                        "Difficulty breathing or shortness of breath",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Text(
                        "Chest Pain or pressure",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "Loss of speach or movement",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: ExpansionTileCard(
                  title: Text(
                    "How To Get The COVID-19 Vaccine",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexendMega(),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Step 1: Click on the button below.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          // color: Colors.redAccent,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        const url = "https://portal.health.go.ke/";
                        _launchUrl_url(url);
                      },
                      child: Text(
                        "Register For the Vaccine",
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Step 2: Create an Account.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          // fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text(
                        "Step 3: Fill in all the personal details in your profile.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text(
                        "Step 4: Click Submit.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      // thickness: 1,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.black87,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text(
                        "Now You should be in the system ready to get your vaccine.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "After receiving your vaccine, refresh your profile. You should be able to see your vaccine certificate.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          // fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: ExpansionTileCard(
                  title: Text(
                    "Full List of Vaccination Posts",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexendMega(),
                  ),
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        const url =
                            "https://www.health.go.ke/wp-content/uploads/2021/08/List-of-facilities-offering-COVID-19-vaccine-services-in-Kenya..pdf";
                        _launchUrl_url(url);
                      },
                      child: Text(
                        "Click for PDF",
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: ExpansionTileCard(
                  title: Text(
                    "COVID-19 Vaccination Updates",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexendMega(),
                  ),
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        const url =
                            "https://www.health.go.ke/#1621663315215-d6245403-4901";
                        _launchUrl_url(url);
                      },
                      child: Text(
                        "Click me",
                        style: GoogleFonts.lexendMega(
                          fontSize: 12,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 75,
                width: (MediaQuery.of(context).size.height) / 1.3,
                child: AdWidget(
                  ad: inlineBannerAd,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
