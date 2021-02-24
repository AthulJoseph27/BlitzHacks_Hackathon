import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Theme.dart';
import 'dart:ui' as ui;

class HomeItem extends StatelessWidget {
  final IconData icon;
  HomeItem({this.icon});
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        elevation: 10,
        child: ShaderMask(
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
//            blendMode: BlendMode.colorBurn,
          child: Icon(
           icon,
            size: 50,
          ),
        ),
      ),
    );
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
            SliverToBoxAdapter(
              child: Container(
                height: 200,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)) ,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          "Your limitation—it's only your imagination.",
                          style: TextStyle(
                              color: LightTheme.darkGray.withOpacity(0.8),
                              fontSize: 25,
                              fontFamily: "Montserrat"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              sliver: SliverGrid.count(
                  crossAxisCount: 4,
                children: [
                  HomeItem(
                    icon: Icons.account_box,
                  ),
                  HomeItem(
                    icon: Icons.info,
                  ),
                  HomeItem(
                    icon: Icons.alarm,
                  ),
                  HomeItem(
                    icon: Icons.calculate,
                  ),
                  HomeItem(
                    icon: Icons.report,
                  ),
                  HomeItem(
                    icon: Icons.device_hub,
                  ),
                  HomeItem(
                    icon: Icons.details,
                  ),
                  HomeItem(
                    icon: Icons.headset,
                  ),
                  HomeItem(
                    icon: Icons.subject,
                  ),
                  HomeItem(
                    icon: Icons.book,
                  ),
                  HomeItem(
                    icon: Icons.self_improvement_rounded,
                  ),
                  HomeItem(
                    icon: Icons.logout,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
