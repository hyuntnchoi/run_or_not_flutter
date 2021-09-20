import 'package:flutter/material.dart';
import 'subway.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '뛸까말까',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Subway(),
    );
  }
}


// class MyHomePage extends StatelessWidget {
//   final String title;
//
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(this.title),
//       ),
//       body: Center(
//           child:
//           Text(
//             '메인 화면',
//           )
//       ),
//     );
//   }
// }