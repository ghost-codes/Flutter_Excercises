import 'package:flutter/material.dart';
import 'package:mortgage_payment_starter_app/util/Network.dart';

class JsonParsing extends StatefulWidget {
  @override
  _JsonParsingState createState() => _JsonParsingState();
}

class _JsonParsingState extends State<JsonParsing> {
  Future data;
  
  @override
  void initState(){
    super.initState();
    data = getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json Parsing"),
      ),
      body: FutureBuilder(
        future: data,
        builder: (context, AsyncSnapshot snapShot){
          if(snapShot.hasData){
            return listViewData(context, snapShot.data);
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget listViewData(BuildContext context, List data){
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index){
          return Column(
            children:[ ListTile(
              leading: CircleAvatar(
                child: Text("${data[index]["id"]}"),
                backgroundColor: Colors.black26,
              ),
              title: Text(data[index]["title"]),
              subtitle: Text(data[index]["body"]),
            ),
            Divider()]
          );
        },
    );
  }

  Future getData() async{
    Future data;
    Network network = Network("https://jsonplaceholder.typicode.com/posts");

    data = network.fetchData();
    return data;
  }
}
