import 'package:firebase/data/users_review_list.dart';
import 'package:firebase/models/user_review_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserReviewApi{

  List userData=[];

  Future apiCall() async{
    http.Response response;
    response=await http.get(Uri.parse('https://mocki.io/v1/85c20b59-0e46-4bd3-9937-1c6ab1ee0686'));
    if(response.statusCode==200){
      userData=json.decode(response.body);
      for(int i=0;i<userData.length;i++){
        Map apiUsers=userData[i];
        UserReviewList.users.add(ReviewUsers(name: apiUsers['name'], comment: apiUsers['comments'], picture: apiUsers['picture']));
      }
    }
  }
}