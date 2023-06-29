import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gshoes/bloc/home_bloc/home_bloc.dart';
import 'package:gshoes/bloc/home_bloc/home_state.dart';
import 'package:gshoes/screen/home_screen.dart';

void main() {
  runApp(const MyApp( ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  List _items = [];

  Future<void> readJson() async{
    final String response = await rootBundle.loadString('lib/assets/data/shoes.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["shoes"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readJson(),
      builder: (context, data){
        if (data.hasError){
          return Text("${data.error}");
        }
        else{
          return BlocProvider(
            create: (context) => HomeBloc(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: Home( items: _items,),
            ),
          );
        }
      },
    );
  }
}
