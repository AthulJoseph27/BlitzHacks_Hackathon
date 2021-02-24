import 'package:http/http.dart' as http;

class FoodQuery{

  static final String apiKey = '5uXWfqMnE2be2BBHPjpz8iZyqEKzK3aspo8uHOfd';

  String url;
  String query;
  String dataType;
  int pageSize;

  FoodQuery(String query,int pageSize,String dataType){
    this.query = query;
    this.dataType = dataType;
    this.pageSize = pageSize;
    this.url = 'https://api.nal.usda.gov/fdc/v1/foods/search?api_key=$apiKey&query=${this.query}&dataType=${this.dataType}&pageSize=${this.pageSize}';
  }

  void fetchData()async{
    var data = await http.get(url);
    print(data.runtimeType);
  }




}

//cook trap escape point blossom immune first among galaxy build mirror casino