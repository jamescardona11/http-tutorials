import 'package:chopper_one_app/service/movie_service.dart';
import 'package:chopper_one_app/ui/movie_listings.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

void main() {
  _setupLogging();
  runApp(MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => MovieService.create(),
      dispose: (_, MovieService service) {
        service.client.dispose();
      },
      child: MaterialApp(
        title: 'Movie Listings',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MovieListings(),
      ),
    );
  }
}
