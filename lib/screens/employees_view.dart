
import 'package:finnovation_z/screens/employees_bloc.dart';
import 'package:finnovation_z/screens/employees_modal.dart';
import 'package:finnovation_z/screens/widgets/socket.dart';
import 'package:finnovation_z/services/emp_api.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class NotificationPage extends StatefulWidget {
    
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with TickerProviderStateMixin {
       TextEditingController editingController = new TextEditingController();
  var varoneone = [];
  bool isActive = true;
  final WebSocketChannel channel = IOWebSocketChannel.connect("ws://echo.websocket.org");
  final empBloc = EmpBloc();



  TabController _controller;
  bool tabOneWhite = true;
  bool tabTwoWhite = false;

  var event;
Future<Employee> _empDetails;

  @override
  void initState() {
      _empDetails = getNews();
    _controller = TabController(
      length: 2,
      vsync: this,
    );

    super.initState();
    _controller.addListener(_handleTabSelectionordering);

empBloc.eventSink.add(NewsAction.Fetch);
   
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
 
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.purple,
        appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0.0,
            title: Text(
              'Name',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w800),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              Row(
                children: [],
              )
            ],
            bottom: PreferredSize(
              child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(75.0, 0, 20, 30),
                        child: Column(
                          children: [
                            Text(
                              'Social Distributor',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0, 20, 30),
                        child: Column(
                          children: [
                      
                          ],
                        ),
                      )
                    ]),
              ),
              preferredSize: Size.fromHeight(30.0),
            )),
        body: Container(
          child: Column(
            children: [
              TabBar(
                indicatorColor: Colors.transparent,
                controller: _controller,
                tabs: [
                  Container(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Tab(
                        child: Stack(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: tabOneWhite
                                        ? Colors.black
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                  // color: Colors.white
                                  color: Colors.amber,
                                ),
                                child: Container(
                                    width: 105,
                                    height: 70,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Critical',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: tabOneWhite
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ))),
                    
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Tab(
                        child: Stack(
                          children: [
                            Container(
                                width: 115,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: tabTwoWhite
                                        ? Colors.black
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                  // color: Colors.white
                                  color: Colors.amber
                                ),
                                child: Container(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('General',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: tabTwoWhite
                                            ? Colors.white
                                            :  Colors.black,
                                      )),
                                ))),
                            Container(
                            
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 400,
                height: 400,
                // color: HexColor(colorWhite),
                child: TabBarView(
                  // physics: NeverScrollableScrollPhysics(),
                  controller: _controller,
                  children: <Widget>[
                    MyApp(),
                     empView()],
                ),
              ),
         
     
            ],
          ),
        ),
      ),
    );
  }

  void _handleTabSelectionordering() {
    if (_controller.indexIsChanging) {
      if (_controller.index == 0) {
        setState(() {
          tabOneWhite = true;
          tabTwoWhite = false;
        });
      } else {
        setState(() {
          tabOneWhite = false;
          tabTwoWhite = true;
        });
      }
    }
  }

  // Widget empView(){
  //   return Container(
  //                           child: StreamBuilder<List<Datum>>(
  //         stream:empBloc.empStream,
  //         builder: (context, snapshot) {
  //           if (snapshot.hasData) {
  //             return ListView.builder(
  //                 itemCount: snapshot.data.length,
  //                 itemBuilder: (context, index) {

  //                   var notificationDetails = snapshot.data[index];
                   
  //                   return Container(
  //                     height: 100,
  //                     margin: const EdgeInsets.all(8),
  //                     child: Row(
  //                       children: <Widget>[

  //                           SizedBox(width: 16),
  //                           Flexible(
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: <Widget>[
                                 
  //                                 Text(
  //                                   notificationDetails.employeeName,
  //                                   overflow: TextOverflow.ellipsis,
  //                                   style: TextStyle(
  //                                       fontSize: 20,
  //                                       fontWeight: FontWeight.bold),
  //                                 ),
  //                                 Text(
  //                                   notificationDetails.employeeAge.toString(),
  //                                   maxLines: 2,
  //                                   overflow: TextOverflow.ellipsis,
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                       ],
  //                     ),
  //                   );
  //                 });
  //           } else
  //             return Center(child: Text('error'));
  //         },
  //       ),
  //                         );

  // }


Widget empView(){
    return Container(
                            child: FutureBuilder<Employee>(
          future:_empDetails,
          builder: (context, snapshot) {
            print('datagg');
            if (snapshot.hasData) {
              return Container(  
            padding: EdgeInsets.all(12.0),  
            child: GridView.builder(  
              itemCount:  snapshot.data.data.length,  
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                  crossAxisCount: 3,  
                  crossAxisSpacing: 4.0,  
                  mainAxisSpacing: 4.0  
              ),  
              itemBuilder: (BuildContext context, int index){  
                 print('fff');
                 var empDetails = snapshot.data.data[index];
                 return Expanded(
                                    child: Container(
                        // height: 400,
                        margin: const EdgeInsets.all(8),
                        child: Row(
                          children: <Widget>[

                              SizedBox(width: 16),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                   
                                    Text(
                                      empDetails.employeeName,
                                      
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                               
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                 );  
              },  
            ));
     
            } else
              return Center(child: Text('error'));
          }),
                          );

  }




    Widget generalView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 0),
      child: Container(
        color:Colors.blue,
        height: 200,
      ),
    );
  }

}
