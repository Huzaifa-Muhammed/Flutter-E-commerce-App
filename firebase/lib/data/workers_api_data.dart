import 'dart:convert';
import 'package:firebase/data/workers_list.dart';
import 'package:firebase/models/worker_class.dart';
import 'package:http/http.dart' as http;

class WorkerApi{

  List workerData=[];

  Future apiCAll()async{
    http.Response response;
    response= await http.get(Uri.parse('https://mocki.io/v1/b425ddc3-e2cd-4046-be26-ff66d7d2db19'));
    if(response.statusCode == 200){
      workerData = json.decode(response.body);
      for(int i=0;i<workerData.length;i++){
        Map apiWorker=workerData[i];
        WorkersList.workers.add(Worker(name: apiWorker['name'], city: apiWorker['city'], picture: apiWorker['picture'], category: apiWorker['category'], gender: apiWorker['gender'], rate: apiWorker['rate']));
      }
    }
  }
}