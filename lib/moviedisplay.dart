import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yellowclassassignment/editmoviedetails.dart';
import 'package:yellowclassassignment/models/moviemodel.dart';
import 'boxes.dart';
import 'editmoviedetails.dart';

import 'newmovieform.dart';

class MainPage extends StatefulWidget {

  const MainPage({Key? key}) : super(key: key);


  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.amber, title: Text('WatchedList'),),
      body: ValueListenableBuilder<Box<Movie>>(
        valueListenable: Boxes.getMovies().listenable(),
        builder: (context, box, _){
          final movies = box.values.toList().cast<Movie>();
          return _buildListview(movies);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewMovieForm())
          );
        },
        icon: const Icon(Icons.add_to_queue),
        label: const Text('Add Movie'),
        backgroundColor: Colors.amber,
      ),
    );
  }
}

void deleteMovie(Movie movie){
  movie.delete();
}

ListView _buildListview(movies) {
  return ListView.builder(
    padding: EdgeInsets.all(10),
    itemCount: movies.length,
    itemBuilder: (BuildContext context, int index){
      final movie = movies[index];

      return _buildMovie(context, movie);
    }
  );
}

Widget _buildMovie(BuildContext context, Movie movie){
  return Card(
    color: Colors.amberAccent,
    child: ListTile(
      leading: Image.memory(movie.poster),
      title: Text(movie.name, style: TextStyle(color: Colors.black),),
      subtitle: Text(movie.director, style: TextStyle(color: Colors.black38),),
      trailing:
          Wrap(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.white,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => movieeditor(movie: movie,)));
                },
        ),
            IconButton(onPressed: (){
              deleteMovie(movie);
              },
                icon: Icon(Icons.delete),color: Colors.white,)
          ]),

      ),
    );
}