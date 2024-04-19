import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:soberguardian/auth_checker.dart';
import 'package:camera/camera.dart';
import 'package:soberguardian/shared/singleton.dart';
// import 'package:soberguardian/map_test.dart';
import 'package:soberguardian/firebase_options.dart';
import 'package:provider/provider.dart';
// import 'package:latlong2/latlong.dart';
// import 'home.dart';
import 'login.dart';
//import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import 'title_model.dart';
// export 'title_model.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  _cameras = await availableCameras();
  print(_cameras);

  if (_cameras.isNotEmpty) {
    // TODO: change this camera to the front side camera
    final firstCamera = _cameras.first;
    Singleton singleton = Singleton();
    singleton.selfieCamera = firstCamera;
    singleton.cameras.add(firstCamera);
  } else {
    print("No camera detected");
  }

  runApp(ChangeNotifierProvider<Singleton>(
      create: (context) => Singleton(), child: const SoberGuardianApp()));
}

class SoberGuardianApp extends StatelessWidget {
  const SoberGuardianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthChecker(),
      // home: MapScreen(center: LatLng(50.0, -0.09),)
    );
  }
}

class TitleWidget extends StatefulWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TitleWidgetState createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  //late TitleModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    //_model = createModel(context, () => TitleModel());
  }

  @override
  void dispose() {
    //_model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color.fromARGB(255, 24, 111, 240),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/soberguardianl.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Sober Guardian',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 38,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        persistentFooterButtons: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginWidget()));
            },
            child: const Icon(Icons.home),
          ),
        ],
      ),
    );
  }
}
