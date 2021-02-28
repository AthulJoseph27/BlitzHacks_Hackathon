import 'package:flutter/material.dart';
import 'package:healthapp/Ethereum/HeathRecords.dart';
import 'package:healthapp/FoodDataQuery/QueryData.dart';
import 'package:healthapp/Screens/HealthProfile.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

import 'Ethereum/Ui_Home.dart';
import 'Ethereum/Ui_Home_HealthCenter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> test = [];
  Client httpClient;
  Web3Client ethClient;
  HealthInfo healthInfo;
  TextEditingController controller = TextEditingController();
 @override
 void initState() {
    httpClient = Client();
    ethClient = Web3Client('http://86.98.134.242:7545', httpClient);
    healthInfo = HealthInfo(name: 'Barry Allen',gender: 'M',age: 30,records: [],address: '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body : HealthProfile(),
//        body: Home(),SingleChildScrollView(
//          child: Container(
//            height: 800,
//            child: Column(
//              children: [
//                Spacer(),
//                TextField(
//                  controller: controller,
//                  onSubmitted: (value){
//                    setState(() {
//                      test.add(value);
//                    });
//                  },
//                ),
//                Spacer(),
//                GestureDetector(
//                  onTap: ()async{
//                    for(var i in test)
//                      await healthInfo.addToRecords(ethClient, i);
//                    print('Done');
//                    setState(() {
//                      test = [];
//                    });
//                  },
//                  child: Container(
//                    height: 80,
//                    width: 200,
//                    color: Colors.blueAccent,
//                    child:Center(child: Text('Update')),
//                  ),
//                ),
//                Spacer(),
//                Container(
//                  height: 500,
//                  child: ListView.builder(
//                    itemCount: test.length,
//                    itemBuilder: (context, index) {
//                      return Text(test[index]);
//                    },
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
//        floatingActionButton: FloatingActionButton(
//          onPressed: ()async{
//            var data = await healthInfo.getRecord(ethClient);
//            setState(() {
//              for(var i in data)
//                test.add(i.toString());
//            });
//          },
//          child: Center(child: Text('Get')),
//        ),
      ),
    );
  }
}
