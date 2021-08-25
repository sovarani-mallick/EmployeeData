

import 'dart:async';
import 'dart:convert';
import 'package:finnovation_z/screens/employees_modal.dart';
import 'package:http/http.dart' as http;


enum NewsAction{ Fetch, Delete }

class EmpBloc{

  final _stateStreamController = StreamController<List<Datum>>.broadcast();
  StreamSink<List<Datum>> get _empSink => _stateStreamController.sink;
  Stream<List<Datum>> get empStream => _stateStreamController.stream;


  final _eventStreamController = StreamController<NewsAction>.broadcast();
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get _eventStream => _eventStreamController.stream;

   EmpBloc(){
     empStream.listen((event) { });
     _eventStream.listen((event) async{
       if(event == NewsAction.Fetch){
          try {
            var emp = await getNews();
            _empSink.add(emp.data);
          } on Exception catch (e) {
              _empSink.addError('Something went wrong');   
          }
         
       }
     });
   }
  Future<Employee> getNews() async {
    var client = http.Client();
    var empModel;

    try {
      var response = await client.get('https://dummy.restapiexample.com/api/v1/employees');
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        empModel = Employee.fromJson(jsonMap);
      }
    } catch (Exception) {
      return empModel;
    }

    return empModel;
  }

  void dispose(){
  _stateStreamController.close();
  _eventStreamController.close();
}

}