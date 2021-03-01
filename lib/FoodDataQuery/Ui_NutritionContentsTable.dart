import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/FoodDataQuery/QueryData.dart';
import 'package:healthapp/FoodDataQuery/Ui_NutritionInfo.dart';

import '../Theme.dart';

class NutritionContentTable extends StatefulWidget {
  final List<NutritionContent> foodNutrition;
  NutritionContentTable({this.foodNutrition});
  @override
  _NutritionContentTableState createState() => _NutritionContentTableState();
}

class _NutritionContentTableState extends State<NutritionContentTable> {
  List<DataRow> dataRows = [];

  @override
  void initState() {
    for(var i in widget.foodNutrition){
      dataRows.add(
        DataRow(
          cells:[
            DataCell(Text(i.nutrientName)),
            DataCell(Text(i.value.toString())),
            DataCell(Text(i.unitName))

          ]
        )
      );
    }
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
        body:SingleChildScrollView(
          child: DataTable(
            columns: [
              DataColumn(label: Text('Nutrition')),
              DataColumn(label: Text('Value')),
              DataColumn(label: Text('Unit')),
            ],
            rows: dataRows,
          ),
        ),
      ),
    );
  }
}
