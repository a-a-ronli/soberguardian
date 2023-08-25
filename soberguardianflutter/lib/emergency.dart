import 'package:flutter/material.dart';


//import 'notify_model.dart';
//export 'notify_model.dart';

class NotifyWidget extends StatefulWidget {
  const NotifyWidget({Key? key}) : super(key: key);

  @override
  _NotifyWidgetState createState() => _NotifyWidgetState();
}

class _NotifyWidgetState extends State<NotifyWidget> {
  //late NotifyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    //_model = createModel(context, () => NotifyModel());
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          title: const Text(
            'Contact Page',
            style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 22,
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2,
          leading: BackButton(),
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            print('button pressed');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff5c4033)),
                            padding: MaterialStateProperty.all(EdgeInsetsDirectional.fromSTEB(12,12,12,12)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                            ),
                          ),
                          child: Container(
                            height: 43,
                            alignment: Alignment(0,0),
                            width: 43,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 25),
                            child:
                              Text(
                                'Family',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                          ),  
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            print('button pressed');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff614051)),
                            padding: MaterialStateProperty.all(EdgeInsetsDirectional.fromSTEB(12,12,12,12)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                            ),
                          ),
                          child: Container(
                            height: 43,
                            alignment: Alignment(0,0),
                            width: 53,
                            margin: EdgeInsets.fromLTRB(15, 20, 15, 25),
                            child:
                              Text(
                                'Friends',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                          ),  
                        ),
                      ),
                       ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            print('button pressed');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xffc4a484)),
                            padding: MaterialStateProperty.all(EdgeInsetsDirectional.fromSTEB(12,12,12,12)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                            ),
                          ),
                          child: Container(
                            height: 43,
                            alignment: Alignment(0,0),
                            width: 73,
                            margin: EdgeInsets.fromLTRB(5, 20, 5, 25),
                            child:
                              Text(
                                'Caretaker',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
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
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            print('button pressed');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff3991d2)),
                            padding: MaterialStateProperty.all(EdgeInsetsDirectional.fromSTEB(12,12,12,12)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                            ),
                          ),
                          child: Container(
                            height: 43,
                            alignment: Alignment(0,0),
                            width: 43,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 25),
                            child:
                              Text(
                                'Police',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                          ),  
                        ),
                      ),
                  ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            print('button pressed');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xffd2042d)),
                            padding: MaterialStateProperty.all(EdgeInsetsDirectional.fromSTEB(12,12,12,12)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                            ),
                          ),
                          child: Container(
                            height: 43,
                            alignment: Alignment(0,0),
                            width: 43,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 25),
                            child:
                              Text(
                                'Fire Fighter',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                          ),  
                        ),
                      ),
                 ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            print('button pressed');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff60cd41)),
                            padding: MaterialStateProperty.all(EdgeInsetsDirectional.fromSTEB(12,12,12,12)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                            ),
                          ),
                          child: Container(
                            height: 43,
                            alignment: Alignment(0,0),
                            width: 43,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 25),
                            child:
                              Text(
                                'Hospital',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                          ),  
                        ),
                      ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            print('button pressed');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff000000)),
                            padding: MaterialStateProperty.all(EdgeInsetsDirectional.fromSTEB(12,12,12,12)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                            ),
                          ),
                          child: Container(
                            height: 43,
                            alignment: Alignment(0,0),
                            width: 43,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 25),
                            child:
                              Text(
                                'Uber',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                          ),  
                        ),
                      ),
                  ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            print('button pressed');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 226, 51, 206)),
                            padding: MaterialStateProperty.all(EdgeInsetsDirectional.fromSTEB(12,12,12,12)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                            ),
                          ),
                          child: Container(
                            height: 43,
                            alignment: Alignment(0,0),
                            width: 43,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 25),
                            child:
                              Text(
                                'Lift',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                          ),  
                        ),
                      ),
                 ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            print('button pressed');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 234, 255, 0)),
                            padding: MaterialStateProperty.all(EdgeInsetsDirectional.fromSTEB(12,12,12,12)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                            ),
                          ),
                          child: Container(
                            height: 43,
                            alignment: Alignment(0,0),
                            width: 43,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 25),
                            child:
                              Text(
                                'Driver',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                          ),  
                        ),
                      ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            print('button pressed');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff1b4494)),
                            padding: MaterialStateProperty.all(EdgeInsetsDirectional.fromSTEB(12,12,12,12)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                            ),
                          ),
                          child: Container(
                            height: 43,
                            alignment: Alignment(0,0),
                            width: 43,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 25),
                            child:
                              Text(
                                'Restaurants',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                          ),  
                        ),
                      ),
                  ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            print('button pressed');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff616161)),
                            padding: MaterialStateProperty.all(EdgeInsetsDirectional.fromSTEB(12,12,12,12)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                            ),
                          ),
                          child: Container(
                            height: 43,
                            alignment: Alignment(0,0),
                            width: 43,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 25),
                            child:
                              Text(
                                'Hotels',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                          ),  
                        ),
                      ),
                 ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            print('button pressed');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xffd4af36)),
                            padding: MaterialStateProperty.all(EdgeInsetsDirectional.fromSTEB(12,12,12,12)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                            ),
                          ),
                          child: Container(
                            height: 43,
                            alignment: Alignment(0,0),
                            width: 43,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 25),
                            child:
                              Text(
                                'Taxi',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                          ),  
                        ),
                      ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            print('button pressed');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff38d2c0)),
                            padding: MaterialStateProperty.all(EdgeInsetsDirectional.fromSTEB(12,12,12,12)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                            ),
                          ),
                          child: Container(
                            height: 43,
                            alignment: Alignment(0,0),
                            width: 43,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 25),
                            child:
                              Text(
                                'Bus',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                          ),  
                        ),
                      ),
                 ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            print('button pressed');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff60cd41)),
                            padding: MaterialStateProperty.all(EdgeInsetsDirectional.fromSTEB(12,12,12,12)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                            ),
                          ),
                          child: Container(
                            height: 43,
                            alignment: Alignment(0,0),
                            width: 43,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 25),
                            child:
                              Text(
                                'Train',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                          ),  
                        ),
                      ),
                  ButtonTheme(
                        minWidth: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            print('button pressed');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff4b39ef)),
                            padding: MaterialStateProperty.all(EdgeInsetsDirectional.fromSTEB(12,12,12,12)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                            ),
                          ),
                          child: Container(
                            height: 43,
                            alignment: Alignment(0,0),
                            width: 43,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 25),
                            child:
                              Text(
                                'Other',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
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
      ),
    );
  }
}
