import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_basics/services/crud.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String carModel;
  late String carColor;
  late Stream<QuerySnapshot> cars;
  // late QuerySnapshot cars;
  CurdMethods crudObj = CurdMethods();

  Future<void> addDialoge(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext coontext) {
          return AlertDialog(
            title: const Text(
              'add data',
              style: TextStyle(fontSize: 15.0),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(hintText: 'car model'),
                    onChanged: ((value) {
                      this.carModel = value;
                    }),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: 'car color'),
                    onChanged: ((value) {
                      this.carColor = value;
                    }),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Add'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Map<String, dynamic> carData = {
                    "carName": this.carModel,
                    'color': this.carColor
                  };
                  crudObj.addData(carData).then((result) {
                    dialogTrigger(context);
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> updateDialoge(BuildContext context, selectedDoc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext coontext) {
          return AlertDialog(
            title: const Text(
              'update',
              style: TextStyle(fontSize: 15.0),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(hintText: 'car model'),
                    onChanged: ((value) {
                      this.carModel = value;
                    }),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: 'car color'),
                    onChanged: ((value) {
                      this.carColor = value;
                    }),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('upadate'),
                onPressed: () {
                  Navigator.of(context).pop();

                  crudObj.updateData(selectedDoc,
                      {'carName': this.carModel, 'color': this.carColor});
                },
              ),
            ],
          );
        });
  }

  Future<void> dialogTrigger(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Done'),
        content: const Text('Added'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('exit'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    cars = crudObj.getData();
    // cars = FirebaseFirestore.instance.collection('testCRUD').snapshots();
    // crudObj.getData().then((QuerySnapshot result) {
    //   setState(() {
    //     cars = result;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('dashboard'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: (() {
                  addDialoge(context);
                }),
                icon: const Icon(Icons.add)),
            IconButton(
                onPressed: (() => FirebaseAuth.instance.signOut().then((value) {
                      Navigator.of(context).popAndPushNamed('/landingpage');
                    })),
                icon: const Icon(Icons.logout))
          ],
        ),
        body:
            //
            //
            _carList());
  }

  Widget _carList() {
    return StreamBuilder(
        stream: cars,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(data.docs[index]['carName']),
                  subtitle: Text(data.docs[index]['color']),
                  onTap: (() {
                    updateDialoge(context, data.docs[index].id);
                  }),
                  onLongPress: (() {
                    crudObj.deleteData(data.docs[index].id);
                  }));
            },
          );
        });
  }

  // Widget _carsList() {
  //   if (cars != null) {
  //     return ListView.builder(
  //         itemCount: cars.docs.length,
  //         itemBuilder: ((context, index) {
  //           return ListTile(
  //             title: Text(cars.docs[index]['carName']),
  //           );
  //         }));
  //   } else
  //     return Text('data is loading');
  // }
}
