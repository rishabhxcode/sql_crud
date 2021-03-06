import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_crud/bloc/random/randomscientist_bloc.dart';

class ShowRandom extends StatefulWidget {
  @override
  _ShowRandomState createState() => _ShowRandomState();
}

class _ShowRandomState extends State<ShowRandom> {

  @override
  void initState() {
    BlocProvider.of<RandomScientistBloc>(context)
        .add(RandomScientistsLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime[700],
        title: Text('Random'),
      ),
      body: Center(
          child: Card(
        elevation: 10,
        child: BlocBuilder<RandomScientistBloc, RandomScientistState>(
            builder: (context, state) {
          if (state is RandomScientistsLoadedState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(state
                                      .scientist.imageUrl !=
                                  ''
                              ? state.scientist.imageUrl
                              : 'https://www.curepharmaceutical.com/wp-content/uploads/2020/04/istockphoto-1147544807-612x612-1.jpg'))),
                ),
                Container(
                    width: 300,
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(state.scientist.name,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('known for: ',
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontStyle: FontStyle.italic)),
                            Text(state.scientist.knownFor),
                          ],
                        )
                      ],
                    )),
                Container(
                    child: FlatButton(
                  color: Colors.lime,
                  child: Text("Next"),
                  onPressed: () {
                context.read<RandomScientistBloc>().add(LoadNextScientistEvent());
                  },
                )),
              ],
            );
          } else if (state is RandomScientistsLoadingState) {
            return CircularProgressIndicator();
          }
          return Text('Something went wrong');
        }),
      )),
    );
  }
}
