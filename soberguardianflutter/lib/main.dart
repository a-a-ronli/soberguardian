import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
//import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import 'title_model.dart';
// export 'title_model.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp (const SoberGuardianApp());
}

class SoberGuardianApp extends StatelessWidget {
  const SoberGuardianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TitleWidget(),
    );
  }
}

class TitleWidget extends StatefulWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
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
        backgroundColor: const Color(0xFF186FF0),
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
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginWidget()));
              } ,
              child: Icon(Icons.home),
            ),
          ],
        ),
    );
  }
}
