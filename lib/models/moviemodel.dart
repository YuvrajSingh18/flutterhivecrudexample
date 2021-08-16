import 'dart:typed_data';
import 'package:hive/hive.dart';
part 'moviemodel.g.dart';

@HiveType(typeId: 0)
class Movie extends HiveObject{
  @HiveField(0)
   String name;

  @HiveField(1)
   String director;

  @HiveField(2)
   Uint8List poster;

  Movie( this.name, this.director, this.poster);
}