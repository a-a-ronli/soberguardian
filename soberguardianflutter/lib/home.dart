import 'dart:convert';
import 'dart:ui';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:soberguardian/services/auth.dart';
import 'package:soberguardian/main.dart';
import 'package:soberguardian/shared/singleton.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:soberguardian/size_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'emergency.dart';
import 'loading.dart';

//import 'home_page_model.dart';
//export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  //late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<Object?, Object?>> tests = [];
  final _singleton = Singleton();
  String? city;

  void initLocation() async {
    city = await getLocation();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initLocation();
    // _model = createModel(context, () => HomePageModel());
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    //_model.dispose();

    super.dispose();
  }

  // Future<String?> getCity() async {
  //   Location location = new Location();

  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //   LocationData _locationData;

  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return null;
  //     }
  //   }

  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return null;
  //     }
  //   }

  //   _locationData = await location.getLocation();

  //   // TODO: Get the city name via API
  //   const apiKey = 'YOUR_GOOGLE_MAPS_API_KEY';  // Replace with your actual API key

  //   double lat = _locationData.latitude as double;
  //   double lon = _locationData.longitude as double;

  //   final url =
  //       'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=$apiKey';

  //   final response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> data = json.decode(response.body);
  //     if (data["results"] != null && data["results"].length > 0) {
  //       for(var result in data["results"]) {
  //         if (result["types"].contains("locality")) {
  //           for (var component in result["address_components"]) {
  //             if (component["types"].contains("locality")) {
  //               return component["long_name"];
  //             }
  //           }
  //         }
  //       }
  //     }
  //   }

  //   return null;
  // }

  Future<String?> getLocation() async {
    print("Step 1");
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }
    print("Step 2");
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    print("Step 3");
    _locationData = await location.getLocation();
    print(_locationData);
    List<geocoding.Placemark> placemarks =
        await geocoding.placemarkFromCoordinates(
            _locationData.latitude!, _locationData.longitude!);
    print(placemarks);
    geocoding.Placemark place = placemarks[0];
    print("ELEMENT: ${place.locality}");
    print(place);
    return place.locality;
  }

  @override
  Widget build(BuildContext context) {
    if (_singleton.userData != null) {
      // print(_singleton.userData!.child("pt").value);
      if (_singleton.userData!.child("pt").value != null) {
        tests.clear();
        for (final child
            in _singleton.userData!.child("pt").value! as List<dynamic>) {
          if (child != null) tests.add(child);
          // print(child);
        }
      }
    }

    var dt = DateTime.now();

    return GestureDetector(
      //onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF1F4F8),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: const AlignmentDirectional(0, 0.5),
              child: Container(
                width: double.infinity,
                height: SizeConfig.blockSizeVertical! * 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/drinks.png',
                    ).image,
                  ),
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0x59000000),
                    image: DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: Image.asset(
                        'assets/images/drinks.png',
                      ).image,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 70, 24, 44),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: AutoSizeText(
                                '',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 6,
                            sigmaY: 7,
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(0x87000000),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x33000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12, 12, 12, 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8, 0, 0, 4),
                                          child: Text(
                                            'Current Location',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(8, 0, 0, 0),
                                          child: Text(
                                            (city != null)
                                                ? city!
                                                : "Los Angeles",
                                            style: const TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Colors.white,
                                              fontSize: 34,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                        // FutureBuilder<String?>(
                                        //   future: getCity(),
                                        //   builder: (BuildContext context, AsyncSnapshot<String?> snapshot)
                                        //   {
                                        //     if (snapshot.connectionState == ConnectionState.waiting) {
                                        //       return const CircularProgressIndicator();
                                        //     } else if (snapshot.hasError) {
                                        //       return Text('Error: ${snapshot.error}');
                                        //     } else if (snapshot.data == null) {
                                        //       return const Text('???');
                                        //     } else {
                                        //       return Padding(
                                        //       padding:
                                        //           const EdgeInsetsDirectional.fromSTEB(
                                        //               8, 0, 0, 0),
                                        //       child: Text(
                                        //         "${getCity()}",
                                        //         style: const TextStyle(
                                        //               fontFamily: 'Outfit',
                                        //               color: Colors.white,
                                        //               fontSize: 34,
                                        //               fontWeight: FontWeight.w500,
                                        //             ),
                                        //         ),
                                        //       );
                                        //   }
                                        //   }
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 20, 0),
                                    child: Container(
                                      width: 2,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: const Color(0x32E0E3E7),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 24, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8, 0, 0, 4),
                                          child: Text(
                                            'Current Time',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8, 0, 0, 0),
                                          child: Text(
                                            '${(dt.hour > 12) ? dt.hour - 12 : (dt.hour != 0) ? dt.hour : 12}:${(dt.minute) < 10 ? "0${dt.minute}" : dt.minute}',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                  child: Text(
                    'Previous Times Tested',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F4F8),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children:
                          tests.map((test) => TestEntry(test: test)).toList(),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
                  child: Text(
                    'Features',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 0, 0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: [
                      ButtonTheme(
                        minWidth: 160,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoadingWidget()));
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff186ff0)),
                            padding: MaterialStateProperty.all(
                                EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                            ),
                          ),
                          child: Column(children: [
                            Icon(
                              color: Colors.white,
                              Icons.no_drinks_sharp,
                              size: 44,
                            ),
                            Container(
                              height: 12,
                              width: 135,
                            ),
                            Text(
                              'Test',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ]),
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 160,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NotifyWidget()));
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff186ff0)),
                            padding: MaterialStateProperty.all(
                                EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                            ),
                          ),
                          child: Column(children: [
                            Icon(
                              color: Colors.white,
                              Icons.contacts,
                              size: 44,
                            ),
                            Container(
                              height: 12,
                              width: 12,
                            ),
                            Text(
                              'Contact Emergency',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24, 12, 0, 0),
                      child: ButtonTheme(
                        minWidth: 160,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            Auth().logout().then((value) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TitleWidget()));
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 255, 7, 7)),
                            padding: MaterialStateProperty.all(
                                EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                            ),
                          ),
                          child: Column(children: [
                            Icon(
                              color: Colors.white,
                              Icons.logout,
                              size: 44,
                            ),
                            Container(
                              height: 12,
                              width: 135,
                            ),
                            Text(
                              'Log Out',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24, 12, 0, 0),
                      child: ButtonTheme(
                        minWidth: 160,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            // Auth().logout().then((value) {
                            //   Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (context) => TitleWidget()));
                            // });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 255, 7, 7)),
                            padding: MaterialStateProperty.all(
                                EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                            ),
                          ),
                          child: Column(children: [
                            Icon(
                              color: Colors.white,
                              Icons.logout,
                              size: 44,
                            ),
                            Container(
                              height: 12,
                              width: 135,
                            ),
                            Text(
                              'TEST NOTIFICATION',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TestEntry extends StatelessWidget {
  final Map<Object?, Object?> test;
  const TestEntry({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    // print("TEST: ${test["confidence"]}");
    DateTime parsedDateTime = DateTime.parse(test["time"].toString());
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 8, 8),
      child: Container(
        width: 160,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x33000000),
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('hh:mm a').format(parsedDateTime),
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  color: Color(0xFF14181B),
                  fontSize: 28,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                'Confidence: ${test["confidence"]}%',
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  color: Color(0xFF57636C),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                '${test["status"]}',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color:
                      (test["status"] == "Sober") ? Colors.green : Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
