import 'dart:convert';
import 'package:firebase/data/categories_list.dart';
import 'package:firebase/data/trending_items_list.dart';
import 'package:http/http.dart' as http;
import '../models/item_class.dart';

class ApiData{

  late List items=[];

  Future apiCall()async{
    http.Response response;
    response =await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if(response.statusCode ==200){
      items=json.decode(response.body);
      for(int i=0;i<items.length;i++){
        Map apiItems=items[i];
        CategoriesListData.categories.add(apiItems['category']);
        TrendingItemList.trendingItems.add(Item(title: apiItems['title'],price: apiItems['price'].toString(), category: apiItems['category'], image: apiItems['image'],description: apiItems['description'],));
      }
    }
  }
}