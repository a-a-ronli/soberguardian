import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:soberguardian/auth_checker.dart';
import 'package:soberguardian/services/auth.dart';
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
  late TextEditingController confirmController;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    confirmController = TextEditingController();
    //_model = createModel(context, () => TitleModel());
  }

  @override
  void dispose() {
    //_model.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmController.dispose();
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
                SizedBox(height: 25,),
                Text('Password'),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password'
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 25,),
                Text('Confirm Password'),
                TextField(
                  controller: confirmController,
                  decoration: InputDecoration (
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password'
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 25,),
                ElevatedButton(
                  onPressed: (passwordController.text == confirmController.text) ? () async {
                    Auth().register(usernameController.text, passwordController.text).then((result) {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthChecker()));
                    });
                  } : null, 
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
