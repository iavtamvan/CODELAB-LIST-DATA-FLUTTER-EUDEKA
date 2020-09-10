import 'package:codelab_list_data_json/model/movie_model.dart';
import 'package:codelab_list_data_json/network/api_client.dart';
import 'package:codelab_list_data_json/view/detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _apiKey = "0dde3e9896a8c299d142e214fcb636f8";
  String _language = "en-US";
  int _page = 1;
  Movie _movie;
  List<Result> _listData = List<Result>();
  ScrollController _controller = ScrollController();

  void _requestNewData() async {
    setState(() {});
    _movie = await ApiClient.getMoview(
        apiKey: _apiKey, language: _language, page: _page);
    _page = _movie.page;
    _listData.addAll(_movie.results);
    // print(_movie.totalPages);
    setState(() {});
  }

  Widget _homeContent() {
    return ListView.builder(
      controller: _controller,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == _listData.length) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            margin: EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(result: _listData[index]),
                    ),
                  );
                },
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
                              _listData[index].backdropPath,
                          // width: 300,
                          height: 150,
                          fit: BoxFit.fill),
                    ),
                    ListTile(
                      title: Text(_listData[index].originalTitle,
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
      itemCount: _listData.length + 1,
    );
  }

  @override
  void initState() {
    _requestNewData();
    _controller.addListener(() {
      double _pixels = _controller.position.pixels;
      double _maxScroll = _controller.position.maxScrollExtent;
      if (_pixels == _maxScroll) {
        _requestNewData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Show $_page Of ${_movie?.totalPages ?? "0"}",
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _listData.clear();
              _page = 1;
              _requestNewData();
            },
          ),
        ],
      ),
      body: _homeContent(),
    );
  }
}
