import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_crud/bloc/listing_bloc/listing_bloc.dart';
import 'package:sql_crud/bloc/random/randomscientist_bloc.dart';
import 'package:sql_crud/bloc/scientist_bloc.dart';
import 'package:sql_crud/screen/scientist_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ScientistListingBloc()),
          BlocProvider(
              create: (context) => ScientistBloc(
                  scientistListBloc:
                      BlocProvider.of<ScientistListingBloc>(context))),
          BlocProvider(
            create: (context) => RandomScientistBloc(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ScientistListScreen(),
        ));
  }
}
