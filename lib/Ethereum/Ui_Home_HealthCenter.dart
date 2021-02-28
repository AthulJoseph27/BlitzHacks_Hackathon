import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/Ethereum/HeathRecords.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

import '../Theme.dart';
import 'dart:ui' as ui;

class HomeHealthCare extends StatefulWidget {
  @override
  _HomeHealthCareState createState() => _HomeHealthCareState();
}

class _HomeHealthCareState extends State<HomeHealthCare> {
  Client httpClient;
  Web3Client ethClient;
  HealthInfo healthInfo;
  List<HealthRecord> _list = [];
  String myAddressS, patientAddressS,privateKeyS;
  TextEditingController myAddress = TextEditingController();
  TextEditingController patientAddress = TextEditingController();
  TextEditingController privateKey = TextEditingController();

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client('HTTP://10.0.2.2:9545/', httpClient);
    healthInfo = HealthInfo(
        name: 'Doctor',
        gender: 'M',
        age: 30,
        records: [],
        address: '',
        bloodGroup: 'B+');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 40,
          title: Text(
            'Health App',
            style: TextStyle(
                color: LightTheme.darkGray.withOpacity(0.8),
                fontSize: 25,
                fontFamily: "Montserrat"),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 10,
                colors: <Color>[
                  LightTheme.caribbeanGreen,
                  LightTheme.deepIndigoAccent
                ],
              ),
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
//            SliverToBoxAdapter(
//              child: SizedBox(
//                height: 20,
//              ),
//            ),
//            SliverToBoxAdapter(
//              child: Center(
//                child: Container(
//                  height: 60,
//                  width: 350,
//                  padding: const EdgeInsets.symmetric(horizontal: 10),
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.all(Radius.circular(20)),
//                    border: Border.all(color: LightTheme.caribbeanGreen),
//                  ),
//                  child: Row(
//                    children: [
//                      Spacer(),
//                      Center(
//                        child: Container(
//                          width: 250,
//                          child: TextField(
//                            onChanged: (value){
//                              setState(() {
//                                myAddressS = value;
//                              });
//                            },
//                            controller: myAddress,
//                            decoration: InputDecoration(
//                              border: InputBorder.none,
//                              hintText: 'My Address',
//                            ),
//                          ),
//                        ),
//                      ),
//                      Spacer(
//                        flex: 2,
//                      ),
//                      ShaderMask(
//                        blendMode: BlendMode.srcIn,
//                        shaderCallback: (Rect bounds) {
//                          return ui.Gradient.linear(
//                            Offset(4.0, 24.0),
//                            Offset(24.0, 4.0),
//                            [
//                              LightTheme.greenAccent,
//                              LightTheme.deepIndigoAccent,
//                            ],
//                          );
//                        },
//                        child: Icon(
//                          Icons.home,
//                        ),
//                      ),
//                      Spacer(),
//                    ],
//                  ),
//                ),
//              ),
//            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  height: 60,
                  width: 350,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: LightTheme.caribbeanGreen),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      Center(
                        child: Container(
                          width: 250,
                          child: TextField(
                            onChanged: (value){
                              setState(() {
                                patientAddressS = value;
                              });
                            },
                            controller: patientAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Patient Address',
                            ),
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) {
                          return ui.Gradient.linear(
                            Offset(4.0, 24.0),
                            Offset(24.0, 4.0),
                            [
                              LightTheme.greenAccent,
                              LightTheme.deepIndigoAccent,
                            ],
                          );
                        },
                        child: Icon(
                          Icons.subject,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  height: 60,
                  width: 350,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: LightTheme.caribbeanGreen),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      Center(
                        child: Container(
                          width: 250,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                privateKeyS = value;
                              });
                            },
                            controller: privateKey,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Your Private Key',
                            ),
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) {
                          return ui.Gradient.linear(
                            Offset(4.0, 24.0),
                            Offset(24.0, 4.0),
                            [
                              LightTheme.greenAccent,
                              LightTheme.deepIndigoAccent,
                            ],
                          );
                        },
                        child: Icon(
                          Icons.vpn_key,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: SizedBox(
              height: 20,
            )),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: ()async{
                    await healthInfo.setPatientId(ethClient, patientAddressS, privateKeyS);
                    print("Done_____");
                    List<String> result = await healthInfo.viewAllowedRecord(ethClient);
                    print("******Done");
                    setState(() {
                      for(var i in result)
                        _list.add(HealthRecord(disease: i));
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Container(
                        width: 200,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              LightTheme.caribbeanGreen,
                              LightTheme.deepIndigoAccent
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Get Patient Data',
                            style: TextStyle(
                                color: LightTheme.darkGray.withOpacity(0.8),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat"),
                          ),
                        )),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  width: 200,
                  child: Center(
                      child: Text(
                    _list[index].disease,
                    style: TextStyle(
                        color: LightTheme.darkGray.withOpacity(0.8),
                        fontSize: 16,
                        fontFamily: "Montserrat"),
                  )),
                );
              },
              childCount: _list.length),
            ),
          ],
        ),
      ),
    );
  }
}
