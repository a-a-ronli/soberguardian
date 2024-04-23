// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Username/Email',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text('Password',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white)),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text('Confirm Password',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  TextField(
                    controller: confirmController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.white)),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      onPressed: (passwordController.text ==
                              confirmController.text)
                          ? () async {
                              Auth()
                                  .register(usernameController.text,
                                      passwordController.text)
                                  .then((result) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AuthChecker()));
                              });
                            }
                          : null,
                      child: const Text('Create Account'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
