import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shmart/helper/loadingAnimation.dart';

class GoalTracker extends StatefulWidget {
  var dbobj;
  GoalTracker({super.key,required this.dbobj});

  @override
  State<GoalTracker> createState() => _GoalTrackerState();
}

class _GoalTrackerState extends State<GoalTracker> {
  var db, response;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = widget.dbobj;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: const Text(
          'Goal Tracker',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 26,
              color: Colors.white,
              fontFamily: "Dashiki"),
        ),
        backgroundColor: const Color(0xffff7a40),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              addGoal();
            },
            icon: const Icon(Icons.add_rounded),
          )
        ],
      ),
      body: SizedBox(
        child: FutureBuilder(
            future: db.collection('goalTracker').get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: LoadingAnimation()
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error fetching data")
                );
              }
              var documentSnapshot =
              snapshot.data;
              var data = documentSnapshot.docs;
              var a = data.map((d) => {"id": d.id, "data": d.data()});
              print(a);
              var cmpList = [];
              for(var a in data){
                if(a["visible"]){
                  cmpList.add(a);
                }
              }
              // var cmpList = cmpList.keys.toList();
              if(cmpList.isEmpty){
                return const Center(
                  child: Text("No Data Here!!!",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,fontFamily: "Dashiki"),),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.only(top: 8, left: 16, right:16),
                itemCount: cmpList.length,
                itemBuilder: (BuildContext context, int index) {
                  if(!cmpList[index]["visible"]){
                    return Container();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      onTap: (){
                        // Navigator.toNamed(context, "/goalDetails",arguments: {"id":cmpList[index].id,"title":cmpList[index]["title"]});
                        Navigator.pushNamed(context, "/goalDetails",arguments: {"id":cmpList[index].id,"title":cmpList[index]["title"]} );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xffff7a40)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(cmpList[index]["title"],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "Dashiki"),),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children:[
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () async {
                                        try{
                                          print("Value of the document is ${cmpList[index].id}");
                                          editCmp(cmpList[index].id, cmpList[index]["title"]);
                                        }catch(e){
                                          print(e);
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        try{
                                          print("Value of the document is ${cmpList[index].id}");
                                          deleteCmp(cmpList[index].id);
                                        }catch(e){
                                          print(e);
                                        }
                                      },
                                    )
                                  ]
                                )
                              ],
                            ),
                          ]
                        ),
                      ),
                    ),
                  );
                },
              );
            }
        )
      ),
    );
  }

  addGoal(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Goal"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Name of Firm",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                try{
                  if(nameController.text.isEmpty){
                    return;
                  }
                  final docRef = await db.collection('goalTracker').add({"title":nameController.text, "visible":true});
                  nameController.clear();
                  setState(() {});
                  Navigator.pop(context);
                }catch(e){
                  print(e);
                }
              },
              child: const Text("Add"),
            )
          ],
        );
      }
    );
  }

  editCmp(String id, String cmpName){
    nameController.text = cmpName;
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text("Edit Item"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name of Firm",
                  border: const OutlineInputBorder(),
                  hintText: cmpName,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              try{
                if(nameController.text.isEmpty){
                  return;
                }
                var ref = db.collection('goalTracker').doc(id);
                ref.update({"title":nameController.text});
                nameController.clear();
                setState(() {});
                Navigator.pop(context);
              }catch(e){
                print(e);
              }
            },
            child: const Text("Edit"),
          )
        ],
      );
    });
  }

  deleteCmp(String id) async {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text("Delete Item"),
      content: const Text("Are you sure you want to delete this item?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () async {
            try{
              var ref = db.collection('goalTracker').doc(id);
              ref.update({"visible": false});
              Navigator.of(context).pop();
              setState(() {});
            }catch(e){
              print(e);
            }
          },
          child: const Text("Yes"),
        ),
      ],
    ));
  }
}
