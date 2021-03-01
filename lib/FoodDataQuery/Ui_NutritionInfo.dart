import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/FoodDataQuery/QueryData.dart';
import 'package:healthapp/FoodDataQuery/Ui_NutritionContentsTable.dart';

import '../Data.dart';
import '../Theme.dart';
import 'dart:ui' as ui;

class NutritionInfoPage extends StatefulWidget {
  @override
  _NutritionInfoPageState createState() => _NutritionInfoPageState();
}

class _NutritionInfoPageState extends State<NutritionInfoPage> {
  TextEditingController _controller = TextEditingController();
  String _search;
  List<NutritionInfo> _searchResults = [];
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 60,
                width: 300,
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
                          controller: _controller,
                          onChanged: (value) {
                            setState(() {
                              _search = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
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
                      child: IconButton(
                        onPressed: () async {
                          FoodQuery _query = FoodQuery(_search, 5, []);
                          _searchResults = await _query.fetchData();
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GestureDetector(
                    onTap: (){
                      List<NutritionContent> _info = [];

                      for(var i in _searchResults[index].foodNutrients){
                        _info.add(NutritionContent.fromJson(i));
                      }

                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return NutritionContentTable(foodNutrition: _info);
                      }));

                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                          _searchResults[index].description,
                          style: TextStyle(
                              color: LightTheme.darkGray.withOpacity(0.8),
                              fontSize: 16,
                              fontFamily: "Montserrat"),
                        ),
                      ),
                    ),
                  );
                },
                childCount: _searchResults.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
