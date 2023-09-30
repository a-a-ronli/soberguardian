import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'notification.dart';
import 'emergency.dart';
import 'package:soberguardian/home.dart';


//import 'drunk_model.dart';
//export 'drunk_model.dart';

class DrunkWidget extends StatefulWidget {
  const DrunkWidget({Key? key}) : super(key: key);

  @override
  _DrunkWidgetState createState() => _DrunkWidgetState();
}

class _DrunkWidgetState extends State<DrunkWidget> {
  //late DrunkModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    //_model = createModel(context, () => DrunkModel());
  }

  @override
  void dispose() {
    //_model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Change the Icon as per your need
          onPressed: () {
            // Implement your custom behavior here
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePageWidget()));
          },
        ),
      ),
      key: scaffoldKey,
      backgroundColor: const Color(0xFFDE666D),
      body: Align(
        alignment: const AlignmentDirectional(0.05, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: const AlignmentDirectional(-0.6, -0.35),
                child: Container(
                  width: double.infinity,
                  height: 1000,
                  constraints: const BoxConstraints(
                    maxWidth: 900,
                    maxHeight: 1000,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/pdrinks.png',
                      ).image,
                    ),
                  ),
                  alignment: const AlignmentDirectional(-0.0, -0.0),
                  child: Align(
                    alignment: const AlignmentDirectional(0.05, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/drunk.png',
                          width: 305,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                        const Text(
                          'You are drunk!',
                          style:
                              TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, 0.05),
                          child: CircularPercentIndicator(
                            percent: 0.5,
                            radius: 80,
                            lineWidth: 24,
                            animation: true,
                            progressColor:
                                Colors.red,
                            backgroundColor: Colors.white,
                            center: const Text(
                              'Confidence',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, -0.2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0.7, -0.15),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotifyWidget()));
                                  },
                                  label: const Text('Notify'),
                                  icon: const Icon(
                                    Icons.family_restroom,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, 0.25),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationWidget()));
                            },
                            label: const Text('Send Location'),
                            icon: const Icon(
                              Icons.location_on,
                              size: 15,
                            ),
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
    );
  }
}
