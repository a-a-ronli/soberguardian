import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:soberguardian/sober.dart';
import 'package:soberguardian/test_photo.dart';
// import 'package:camera/camera.dart';
import 'drunk.dart';

//import 'loading_model.dart';
//export 'loading_model.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  //late LoadingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  // late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    //_model = createModel(context, () => LoadingModel());
  }

  @override
  void dispose() {
    //_model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(_cameras);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF1E2429),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/drinks.png',
            ).image,
          ),
          gradient: const LinearGradient(
            colors: [Color(0xFF4B39EF), Color(0xFFEE8B60)],
            stops: [0, 1],
            begin: AlignmentDirectional(1, -1),
            end: AlignmentDirectional(-1, 1),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/soberguardianl.png',
              width: 140,
              height: 140,
              fit: BoxFit.fitHeight,
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
              child: Text(
                'Loading Sober Guardian...',
                style: TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            LinearPercentIndicator(
              percent: 0.5,
              width: MediaQuery.sizeOf(context).width,
              lineHeight: 24,
              animation: true,
              progressColor: const Color(0xFF186FF0),
              backgroundColor: const Color(0xFFF1F4F8),
              center: const Text(
                '50%',
                style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF5C4033),
                    ),
              ),
              padding: EdgeInsets.zero,
            ),
            // ElevatedButton(
            //   onPressed: (){
            //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => SoberWidget()));
            //   },
            //   child: Text('Sober'),
            // ),
            // ElevatedButton(
            //   onPressed: (){
            //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => DrunkWidget()));
            //   },
            //   child: Text('Drunk'),
            // ),
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhotoScreen()));
              },
              child: Text('Simulate Connection'),
            ),
          ],
        ),
      ),
    );
  }
}
