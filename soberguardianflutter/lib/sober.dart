import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';


//import 'sober_model.dart';
//export 'sober_model.dart';

class SoberWidget extends StatefulWidget {
  const SoberWidget({Key? key}) : super(key: key);

  @override
  _SoberWidgetState createState() => _SoberWidgetState();
}

class _SoberWidgetState extends State<SoberWidget> {
  //late SoberModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    //_model = createModel(context, () => SoberModel());
  }

  @override
  void dispose() {
    //_model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF93CCA8),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Align(
                  alignment: const AlignmentDirectional(-0.6, -0.25),
                  child: Container(
                    width: double.infinity,
                    height: 900,
                    constraints: const BoxConstraints(
                      maxWidth: 700,
                    ),
                    decoration: BoxDecoration(
                      color:Colors.lightGreen,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.asset(
                          'assets/images/gdrink.png',
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
                            'assets/images/sober.png',
                            width: 305,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          const Text(
                            'You are sober!',
                            style: TextStyle(
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
                              progressColor: const Color(0xFF186FF0),
                              backgroundColor: Colors.white,
                              center: const Text(
                                'Confidence',
                                textAlign: TextAlign.center,
                                style:TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF186FF0),
                                    ),
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
        ],
      ),
    );
  }
}
