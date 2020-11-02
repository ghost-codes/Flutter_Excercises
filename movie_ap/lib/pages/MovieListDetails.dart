
import 'package:flutter/material.dart';
import 'package:movie_ap/model/movies_model.dart';

class MoviesListViewDetails extends StatefulWidget {
  String movie_name;
  Movie movie;
  MoviesListViewDetails({Key key,this.movie_name,this.movie}): super(key: key);
  @override
  _MoviesListViewDetailsState createState() => _MoviesListViewDetailsState();
}

class _MoviesListViewDetailsState extends State<MoviesListViewDetails> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Details",
        style: TextStyle(
          color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Go back ${widget.movie.title}"),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
