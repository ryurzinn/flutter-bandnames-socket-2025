import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Red hot chilli peppers', votes: 5),
    Band(id: '2', name: 'Oasis', votes: 3),
    Band(id: '3', name: 'Queen', votes: 2),
    Band(id: '4', name: 'Nirvana', votes: 1),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('BandNames', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(bands[i])
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: addNewBand,
        child: const Icon(Icons.add)
      ),
    );
  }

  Widget _bandTile(Band band ) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){
        
      },
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.center,
          child: Text('Delete band', style: TextStyle(color: Colors.white)),
        )
      ),
      key: Key(band.id),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Text(band.name.substring(0,2)),
          ),
          title: Text(band.name),
          trailing: Text('${band.votes}', style: const TextStyle(fontSize: 20)),
          onTap: (){
           
          },
        ),
    );
  }
  addNewBand(){

    final textController = TextEditingController();

    if(Platform.isAndroid){
      return showDialog(
     context: context,
     builder: (context) {
      return AlertDialog(
        title: const Text('New band name'),
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            elevation: 5,
            onPressed: () => addBandToList(textController.text),
            textColor: Colors.blue,
            child: const Text('Add') 
          ),
        ],
      );
     },
    );
  }

  showCupertinoDialog(
    context: context,
    builder: ( _ ) => CupertinoAlertDialog(
      title: const Text('New band name'),
      content: CupertinoTextField(
        controller: textController,
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Add'),
          onPressed: () => addBandToList(textController.text),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: const Text('Dismiss'),
          onPressed: () => Navigator.pop(context)
        ),
      ],
    ), 
  );
 }

  void addBandToList(String name){
    if(name.length > 1){
      bands.add(Band(id: DateTime.now().toString(), name: name, votes: 1));
      Navigator.pop(context);
  }

  }
}