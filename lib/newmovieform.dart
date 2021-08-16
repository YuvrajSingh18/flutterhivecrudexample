import 'package:flutter/material.dart';
import 'package:yellowclassassignment/moviedisplay.dart';
import 'boxes.dart';
import 'package:yellowclassassignment/models/moviemodel.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NewMovieForm extends StatelessWidget {
  //const NewMovieForm2({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _director;
  late Uint8List _poster;

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            'Add new Movie',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          color: Colors.black,
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Expanded(
            child: Column(children: [
              Form(
                  key: _formKey,
                  child: Column(children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          onSaved: (String? value) {
                            _name = value!;
                          },
                          cursorColor: Colors.amber,
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'It can not be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Name",
                              labelStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: "Name"),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          onSaved: (String? value) {
                            _director = value!;
                          },
                          cursorColor: Colors.amber,
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Somebody must have directed it!';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Director",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: "Director"),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.amber),
                          onPressed: () async {
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            // Capture a photo
                            var poster = await image!.readAsBytes();
                            _poster = poster;
                          },
                          icon: Icon(Icons.add_photo_alternate),
                          label: Text('Add Image for Poster')),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_poster == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Image missing')),
                            );
                          } else {
                            _formKey.currentState!.save();
                            addMovie(_name, _director, _poster);
                            Navigator.pop(context);
                            const SnackBar(content: Text('Processing'));
                          }
                        }
                      },
                      child: Text('Submit'),
                    )
                  ])),
            ]),
          ),
        ));
  }
}

void addMovie(String name, String director, Uint8List poster) {
  final movie = Movie(name, director, poster)
    ..name = name
    ..director = director
    ..poster = poster;

  final box = Boxes.getMovies();
  box.add(movie);
}
