import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Theme.dart';
import 'dart:ui' as ui;

class NutritionInfo extends StatefulWidget {
  @override
  _NutritionInfoState createState() => _NutritionInfoState();
}

class _NutritionInfoState extends State<NutritionInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: LightTheme.darkGray.withOpacity(0.8),
          ),
        ),
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
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 60,
                width: 300,
                padding: const EdgeInsets.symmetric(horizontal: 10) ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(
                    color: LightTheme.caribbeanGreen
                  ),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    Center(
                      child: Container(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                            ),
                          ),
                      ),
                    ),
                    Spacer(flex: 2,),
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
                        Icons.search,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
