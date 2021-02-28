import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/Ethereum/HeathRecords.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

import '../Theme.dart';
import 'dart:ui' as ui;

class RecordUI extends StatefulWidget {
  @override
  _RecordUIState createState() => _RecordUIState();
}

class _RecordUIState extends State<RecordUI> {
//  static bool once = true;
  List<HealthRecord> _list = [];
  List<bool> _visible = [];
  Client httpClient;
  Web3Client ethClient;
  HealthInfo healthInfo;

  String myAddressS, healthCenterAddressS, privateKeyS;
  TextEditingController myAddress = TextEditingController();
  TextEditingController healthCenterAddress = TextEditingController();
  TextEditingController privateKey = TextEditingController();
  @override
  void initState() {
    for (int i = 0; i < 10; i++) {
      _list.add(HealthRecord(disease: 'Disease ' + i.toString()));
      _visible.add(false);
    }
    httpClient = Client();
    ethClient = Web3Client('http://86.98.134.242:7545', httpClient);
    healthInfo = HealthInfo(
        name: 'Barry Allen',
        gender: 'M',
        age: 30,
        records: [],
        address: '',
        bloodGroup: 'A+');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 40,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: LightTheme.darkGray.withOpacity(0.8),
            ),
          ),
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
//                            onChanged: (value) {
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
                            onChanged: (value) {
                              setState(() {
                                healthCenterAddressS = value;
                              });
                            },
                            controller: healthCenterAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Hospital Address',
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
//            if(once)
            SliverToBoxAdapter(
                child: SizedBox(
              height: 20,
            )),
//            if(once)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () async {
                    await healthInfo.addPatient(ethClient, privateKeyS);
                    for (int i = 0; i < _list.length; i++) {
                      healthInfo.records.add(_list[i].disease);
                      await healthInfo.addToRecords(ethClient, _list[i].disease, privateKeyS);
                    }
                    print("Done.....!!!!");
//                    once = false;
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
                            'Login',
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
            SliverToBoxAdapter(
                child: SizedBox(
              height: 20,
            )),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () async {
                    print(healthCenterAddressS);
                    print(privateKeyS);
                    await healthInfo.setVisiblity(
                        ethClient, healthCenterAddressS, privateKeyS);
                    print("Done----");
//                    print(_visible);
                    for (int i = 0; i < _list.length; i++) {
                      if (_visible[i]) {
//                        print("hello");
                        await healthInfo.changeVisibilityOfRecordAtIndices(
                            ethClient, i, healthCenterAddressS, privateKeyS);
                      }
                    }
                    print("Done...!!!!!!");
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
                            'Update Permission',
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
            SliverToBoxAdapter(
                child: SizedBox(
              height: 20,
            )),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () async {
                    await healthInfo.getVisiblityArray(ethClient);
                    await healthInfo.getBoolVisibleArray(ethClient);
                    setState(() {
                      for (int i = 0; i < _list.length; i++)
                        _visible[i] = false;
                    });
                    await healthInfo.resetVisiblity(ethClient, privateKeyS);
                    print("Done______");
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
                            'Reset Visibility of records',
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

            SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                )),
//            if(once)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () async {
//                    once = false;

                    _list = [];
                    dynamic result = await healthInfo.viewMyRecords(ethClient);

                    setState(() {
                      for(var i in result)
                        _list.add(HealthRecord(disease: i.toString()));
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
                            'Get All Data',
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
                return FlatButton(
                  onPressed: () {
                    setState(() {
                      _visible[index] = !_visible[index];
                    });
                  },
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    color: _visible[index] ? LightTheme.caribbeanGreen : null,
                    child: Text(
                      _list[index].disease,
                      style: TextStyle(
                          color: LightTheme.darkGray.withOpacity(0.8),
                          fontSize: 16,
                          fontFamily: "Montserrat"),
                    ),
                  ),
                );
              }, childCount: _list.length),
            ),
          ],
        ),
      ),
    );
  }
}
