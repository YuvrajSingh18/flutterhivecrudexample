import 'package:hive/hive.dart';
import 'package:yellowclassassignment/models/moviemodel.dart';

class Boxes{
  static Box<Movie> getMovies() => Hive.box<Movie>('movies');
}