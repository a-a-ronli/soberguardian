import 'package:flutter/material.dart';

class Pair<String, IconData> {
    String first;
    IconData last;

    Pair(this.first, this.last);
}

List<Pair<String, IconData>> supportedIcons = [
    Pair("Snowflake", const IconData(0xe037, fontFamily: 'MaterialIcons')), // ac_unit constant
    Pair("Standing Person", const IconData(0xe03c, fontFamily: 'MaterialIcons')), // accessibility constant
    Pair("Government", const IconData(0xe040, fontFamily: 'MaterialIcons')), // account_balance constant
];

// Map<String, IconData> supportedIcons1 = {
//     "Snowflake" : const IconData(0xe037, fontFamily: 'MaterialIcons'), // ac_unit constant
//     "Standing Person" : const IconData(0xe03c, fontFamily: 'MaterialIcons'), // accessibility constant
//     "Government" : const IconData(0xe040, fontFamily: 'MaterialIcons'), // account_balance constant
// }