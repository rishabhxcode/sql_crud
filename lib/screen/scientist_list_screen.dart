import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_crud/bloc/listing_bloc/listing_bloc.dart';
import 'package:sql_crud/bloc/scientist_bloc.dart';
import 'package:sql_crud/database_helper.dart';
import 'package:sql_crud/model.dart';
import 'package:sql_crud/screen/add_new_sceintist.dart';

class ScientistListScreen extends StatefulWidget {
  @override
  _ScientistListScreenState createState() => _ScientistListScreenState();
}

class _ScientistListScreenState extends State<ScientistListScreen> {
  DatabaseHelper helper = DatabaseHelper();
  Future<List<Scientist>> scientists;

  @override
  void initState() {
    BlocProvider.of<ScientistListingBloc>(context)
        .add(ScientistListLoadEvent());
    scientists = helper.getScientists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.lime[700],
        title: Text('Scientists'),
      ),
      body: BlocBuilder<ScientistListingBloc, ScientistListingState>(
        builder: (context, state) {
          if (state is ScientistListLoadedState) {
            return ListView.builder(
                itemCount: state.scientists.length,
                itemBuilder: (context, index) {
                  return ScientistItem(
                    helper: helper,
                    scientist: state.scientists[index],
                  );
                });
          } else if (state is ScientistListLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Text('Something went wrong!'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewScientist()));
        },
        backgroundColor: Colors.amber[900],
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}

class ScientistItem extends StatelessWidget {
  final Scientist scientist;
  final DatabaseHelper helper;
  const ScientistItem({Key key, this.scientist, this.helper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(scientist.imageUrl != ''
                          ? scientist.imageUrl
                          : 'https://www.curepharmaceutical.com/wp-content/uploads/2020/04/istockphoto-1147544807-612x612-1.jpg'))),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      scientist.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<ScientistBloc>(context)
                            .add(ScientistDeleteEvent(id: scientist.id));
                        // var result = helper.deleteScientist(scientist.id);
                      },
                      icon: Icon(Icons.delete_outline),
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      'known for: ',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                          color: Colors.grey[600]),
                    ),
                    Text(scientist.knownFor)
                  ],
                ),
                const Spacer()
              ],
            ),
          )
        ],
      ),
    );
  }
}
