import 'package:codelab_list_data_json/model/movie_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Result result;

  const DetailPage({Key key, @required this.result}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail"),
        ),
        body: Container(
          margin: EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: InkWell(
              onTap: () => print("ciao"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.network(
                        "https://image.tmdb.org/t/p/w500" +
                            result.backdropPath,
                        // width: 300,
                        height: 150,
                        fit: BoxFit.fill),
                  ),
                  ListTile(
                    title: Text(result.originalTitle,
                        textAlign: TextAlign.center),
                    subtitle: Text(result.overview, textAlign: TextAlign.justify),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }


}