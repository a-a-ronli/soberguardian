import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home.dart';
//import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import 'title_model.dart';
// export 'title_model.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  SignUpWidgetState createState() => SignUpWidgetState();
}

class SignUpWidgetState extends State<SignUpWidget> {
  //late TitleModel _model;
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    //_model = createModel(context, () => TitleModel());
  }

  @override
  void dispose() {
    //_model.dispose();
    usernameController.dispose();
    passwordController.dispose();
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
                Text('Username/Email'),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email'
                  ),
                ),
                Text('Password'),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password'
                  ),
                  obscureText: true,
                ),
                ElevatedButton(
                  onPressed: () async {
                    try{
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: usernameController.text,
                        password: passwordController.text,
                      );
                      // Updating database
                      final ref =  FirebaseDatabase.instance.ref();
                      await ref.update({
                        FirebaseAuth.instance.currentUser?.uid as String: {
                          'pt' : {
                            '1' : '', 
                            '2' : '',
                            '3' : '',
                            '4' : '',
                            '5' : '',
                          },
                          'contacts' : {
                            'caretaker' : '',
                            'family' : '',
                            'friends' : '',
                            'other' : '',
                          },
                        }
                      });
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePageWidget()));
                    } on FirebaseAuthException catch(e){
                      print(e.code);
                    }
                  }, 
                  child: Text('Create Account')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
