import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'boxes.dart';
import 'moviedisplay.dart';
import 'models/moviemodel.dart';
import 'package:image_picker/image_picker.dart';

void editMovie(
    Movie movie,
    String name,
    String director,
    Uint8List poster
    ) {
  movie.name = name;
  movie.director = director;
  movie.poster = poster;

  movie.save();
}

class movieeditor extends StatefulWidget {
  movieeditor({Key? key, required this.movie}) : super(key: key);
  final Movie movie;



  @override
  _movieeditorState createState() => _movieeditorState();
}

class _movieeditorState extends State<movieeditor> {

  late Movie movie;
  var posterity;
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final directorController = TextEditingController();
  final box = Boxes.getMovies();

  void initState(){
    super.initState();
    movie = widget.movie;
    nameController.text = movie.name;
    directorController.text = movie.director;
    var posterity = movie.poster;

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },),
          title: Text('Edit Movie Details'),),
        body: Container(
          padding: EdgeInsets.all(15),
          color: Colors.black,
          width: double.infinity,
          child:
          Form(
              key: formkey,
              child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.grey),
                          labelText: 'Name'
                      ),
                      controller: nameController,
                      style: TextStyle(color: Colors.white),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.grey),
                          labelText: 'Director'
                      ),
                      controller: directorController,
                      style: TextStyle(color: Colors.white),
                    ),
                    //Image.memory(posterity),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(primary: Colors.amber),
                        onPressed: () async {
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          // Capture a photo
                          posterity = await image!.readAsBytes();
                        },
                        icon: Icon(Icons.add_photo_alternate),
                        label: Text('Select Poster',style: TextStyle(color: Colors.white),)
                    ),
                    SizedBox(height: 15,),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close),
                              label: Text('Cancel',style: TextStyle(color: Colors.white),)
                          ),
                          SizedBox(width: 15),
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(primary: Colors.green),
                              onPressed: (){
                                // if (formkey.currentState!.validate()){
                                formkey.currentState!.save();
                                editMovie(movie, nameController.text, directorController.text, posterity);
                                // }
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.save),
                              label: Text('Save',style: TextStyle(color: Colors.white),)
                          )
                        ])
                  ])
          ),
        )
    );
  }
}
