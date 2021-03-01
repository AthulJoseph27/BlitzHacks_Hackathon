import 'dart:convert';

import 'package:http/http.dart' as http;

class NutritionContent{
  int nutrientId;
  String nutrientName;
  String nutrientNumber;
  String unitName;
  double value;

  NutritionContent({this.nutrientId,this.nutrientName,this.nutrientNumber,this.unitName,this.value});

  factory NutritionContent.fromJson(Map<String,dynamic> json){
    return NutritionContent(
        nutrientId : json['nutrientId'],
        nutrientName : json['nutrientName'],
        nutrientNumber : json['nutrientNumber'],
        unitName : json['unitName'].toLowerCase(),
        value : double.parse(json['value'].toString()),
    );
  }

}

class NutritionInfo{
  int fdcId;
  String description;
  String lowercaseDescription;
  String commonNames;
  String additionalDescriptions;
  String dataType;
  String foodCode;
  String publishedDate;
  String allHighlightFields;
  List foodNutrients;

  NutritionInfo({this.fdcId,this.description,this.lowercaseDescription,this.commonNames,this.additionalDescriptions,this.dataType,this.foodCode,this.publishedDate,this.allHighlightFields,this.foodNutrients});

  factory NutritionInfo.fromJson(Map<String,dynamic> json){
    return NutritionInfo(
        fdcId : json['fdcId'],
        description : json['description'],
        lowercaseDescription : json['lowercaseDescription'],
        commonNames : json['commonNames'],
        additionalDescriptions : json['additionalDescriptions'],
        dataType : json['dataType'],
        foodCode : json['foodCode'],
        publishedDate : json['publishedDate'],
        allHighlightFields : json['allHighlightFields'],
        foodNutrients : json['foodNutrients']
    );
  }

}

class FoodQuery{

  static final String _apiKey = '5uXWfqMnE2be2BBHPjpz8iZyqEKzK3aspo8uHOfd';

  String url;
  String query;
  List<String> dataType;
  int pageSize;

  FoodQuery(String query,int pageSize,List<String> dataType){
    this.query = query;

    if(dataType.isEmpty)
      this.dataType = ['Survey (FNDDS)'];
    else
      this.dataType = dataType;

    this.pageSize = pageSize;
    this.url = 'https://api.nal.usda.gov/fdc/v1/foods/search?api_key=$_apiKey&query=${this.query}&dataType=${this.dataType[0]}&pageSize=${this.pageSize}';
  }

  Future<List<NutritionInfo>> fetchData()async{
    var data = await http.get(url);

    Map json = jsonDecode(data.body);

    List<NutritionInfo> result = [];

    for(var i in json['foods'])
      result.add(NutritionInfo.fromJson(i));

    return result;
  }




}

//cook trap escape point blossom immune first among galaxy build mirror casino