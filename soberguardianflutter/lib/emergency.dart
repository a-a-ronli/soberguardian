import 'package:flutter/material.dart';
import 'package:soberguardian/shared/singleton.dart';
import 'package:soberguardian/shared/colors_reference.dart';
import 'package:soberguardian/add_category.dart';

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
  List<Map<Object?, Object?>> categories = [];
  final _singleton = Singleton();

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

    if (_singleton.userData != null) {
      // print(_singleton.userData!.child("pt").value);
      if (_singleton.userData!.child("categories").value != null) {
        categories.clear();
        for (final child in _singleton.userData!.child("categories").value! as List<dynamic>) {
          if (child != null) categories.add(child);
          // print(child);
        }
      }
    }

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
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            children: categories.map((category) => EmergencyCategory(category: category)).toList(),
          )
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCategoryScreen()));
          },
          child: const Icon(
            Icons.add
          )
        ),
      ),
    );
  }
}

class EmergencyCategory extends StatelessWidget {
  final Map<Object?, Object?> category;
  const EmergencyCategory({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    print(category);
    return ButtonTheme(
      minWidth: 100,
      height: 100,
      child: ElevatedButton(
        onPressed: () {
          print('button pressed');
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(nameToColors[category["color"]]),
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
            Column(
              children: [
                Icon(IconData(int.parse('0x${category["icon"]}'), fontFamily: 'MaterialIcons')),
                SizedBox(
                  child: Text(
                    category["name"].toString(),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
        ),  
      ),
    );
  }
}