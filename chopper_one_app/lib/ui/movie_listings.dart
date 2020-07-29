import 'package:flutter/material.dart';

class MovieListings extends StatefulWidget {
  @override
  _MovieListingsState createState() => _MovieListingsState();
}

class _MovieListingsState extends State<MovieListings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Listings'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return _buildMovieList(context);
  }

  ListView _buildMovieList(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(IMAGE_URL + "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg"), fit: BoxFit.contain)),
                ),
                Expanded(
                  child: Container(
                    height: 200,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Ad Astra",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                            child: Container(
                                child: Text(
                          "The near future, a time when both hope and hardships drive humanity to look to the stars and beyond. While a mysterious phenomenon menaces to destroy life on planet Earth, astronaut Roy McBride undertakes a mission across the immensity of space and its many perils to uncover the truth about a lost expedition that decades before boldly faced emptiness and silence in search of the unknown.",
                          style: TextStyle(fontSize: 12),
                        ))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static const String IMAGE_URL = "https://image.tmdb.org/t/p/w500/";
}
