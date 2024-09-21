import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shmart/screens/old_screens/helper/loadingAnimation.dart';

// ignore: must_be_immutable
class GoalDetails extends StatefulWidget {
  var dbobj;
  GoalDetails({super.key, this.dbobj});
  @override
  State<GoalDetails> createState() => _GoalDetailsState();
}

class _GoalDetailsState extends State<GoalDetails> {
  var db, paramater;
  TextEditingController goalAmount = TextEditingController();
  TextEditingController goalDate = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = widget.dbobj;
  }

  @override
  Widget build(BuildContext context) {
    paramater = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Text(
          "${paramater['title']}",
          style: const TextStyle(
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
              createNewGoal();
            },
            icon: const Icon(Icons.add_rounded),
          )
        ],
      ),
      body: bodyContent(),
    );
  }

  bodyContent() {
    return FutureBuilder(
        future: db
            .collection('goalTracker')
            .doc(paramater['id'])
            .collection("goals")
            .get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: LoadingAnimation(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (snapshot.hasData) {
            var documentSnapshot = snapshot.data;
            var data = documentSnapshot.docs;
            // print("Data: ${data.length}");
            if (data.length == 0) {
              return const Center(
                child: Text("No Goals Entered!!"),
              );
            }
            if (data != null) {
              return dataList(data);
            }
          }
          return const Center(
            child: Text("No Data"),
          );
        });
  }

  createNewGoal() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add New Goal"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: goalAmount,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Enter Goal",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    readOnly: true,
                    onTap: () async {
                      var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025),
                      );
                      goalDate.text = date.toString().substring(0, 10);
                    },
                    controller: goalDate,
                    decoration: const InputDecoration(
                      labelText: "Enter Goal Date",
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
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    insertGoalData();
                  },
                  child: const Text("Add")),
            ],
          );
        });
  }

  insertGoalData() {
    if (goalAmount.text.isEmpty || goalDate.text.isEmpty) {
      return;
    }
    db.collection('goalTracker').doc(paramater['id']).collection("goals").add({
      "goalAmount": goalAmount.text,
      "goalDate": goalDate.text,
      "entries": []
    });
    goalAmount.text = "";
    goalDate.text = "";
    Navigator.pop(context);
  }

  dataList(data) {
    List sortedData = data.map((snapshot) {
      return {
        'goalAmount': snapshot['goalAmount'],
        'goalDate': snapshot['goalDate'],
        'id': snapshot.id,
        'entries': snapshot['entries']
      };
    }).toList();
    print("Date d is $sortedData");

    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        var goal = data[index];
        var targetReached = 0;
        if (goal['entries'] != null) {
          for (int i = 0; i < goal['entries'].length; i++) {
            targetReached += int.parse(goal['entries'][i]['entry']);
          }
        }
        List sortedList = goal['entries'];
        sortedList.sort((a, b) {
          DateTime dateA = DateFormat('yyyy-MM-dd').parse(a['date']);
          DateTime dateB = DateFormat('yyyy-MM-dd').parse(b['date']);
          return dateB.compareTo(dateA);
        });

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xffff7a40), width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Goal: ${goal['goalAmount']}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.green,
                      child: IconButton(
                        onPressed: () {
                          addEntry(goal.id, goal['entries']);
                        },
                        color: Colors.white,
                        icon: const Icon(Icons.add_rounded),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Goal Date: ${goal['goalDate']}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        onPressed: () {
                          updateGoal(goal.id, goal['goalAmount'], goal['goalDate']);
                        },
                        color: Colors.white,
                        icon: const Icon(Icons.edit_rounded),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Target Reached: $targetReached",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.redAccent,
                      child: IconButton(
                        onPressed: () {
                          deleteGoal(goal.id);
                        },
                        color: Colors.white,
                        icon: const Icon(Icons.delete_rounded),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Target Remains ${targetReached-int.parse(goal['goalAmount'])}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.light?Colors.grey[200] : Colors.grey[800],
                  title: const Text(
                    "Entries",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  tilePadding: EdgeInsets.only(left: 0, right: MediaQuery.of(context).size.width/80),
                  children: [
                    if (goal == null ||
                        goal['entries'] == null ||
                        goal['entries'].length == 0)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("No Entries"),
                      ),
                    if (goal['entries'].length > 0)
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: sortedList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var entry = sortedList[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Date: ${entry['date']}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "${entry['entry']}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteEntry(
                                        index, goal.id, sortedList);
                                  },
                                  color: Colors.redAccent,
                                  icon: const Icon(Icons.delete_rounded),
                                ),
                              ],
                            );
                          })
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  addEntry(key, entries) {
    TextEditingController entry = TextEditingController();
    TextEditingController entryDate = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add Entry"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: entry,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Enter Entry",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    readOnly: true,
                    onTap: () async {
                      var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025),
                      );
                      entryDate.text = date.toString().substring(0, 10);
                    },
                    controller: entryDate,
                    decoration: const InputDecoration(
                      labelText: "Enter Date",
                      border: OutlineInputBorder(),
                    ),
                  )
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (entry.text == "") {
                      return;
                    }
                    var dt = "";
                    if (entryDate.text.isEmpty) {
                      dt = DateTime.now().year.toString();
                      if(DateTime.now().month < 10){
                        dt += "-0${DateTime.now().month}";
                      } else {
                        dt += "-${DateTime.now().month}";
                      }
                      if(DateTime.now().day < 10){
                        dt += "-0${DateTime.now().day}";
                      } else {
                        dt += "-${DateTime.now().day}";
                      }
                    } else {
                      dt = entryDate.text;
                    }
                    var data = {
                      "entry": entry.text,
                      "date": dt,
                    };
                    entries.add(data);
                    db
                        .collection('goalTracker')
                        .doc(paramater['id'])
                        .collection("goals")
                        .doc(key)
                        .update({"entries": entries});
                    entry.text = "";
                    Navigator.pop(context);
                  },
                  child: const Text("Add")),
            ],
          );
        });
  }

  deleteEntry(index, id, entries) {
    entries.removeAt(index);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Entry"),
          content: const Text("Are you sure you want to delete this entry?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                db
                    .collection('goalTracker')
                    .doc(paramater['id'])
                    .collection("goals")
                    .doc(id)
                    .update({"entries": entries});
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  updateGoal(id, goal, d){
    goalAmount.text = goal;
    goalDate.text = d;

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("Update Goal"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: goalAmount,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Enter Goal",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                readOnly: true,
                onTap: () async {
                  var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.tryParse(d) ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  );
                  goalDate.text = date.toString().substring(0, 10);
                },
                controller: goalDate,
                decoration: const InputDecoration(
                  labelText: "Enter Goal Date",
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
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                if(goalAmount.text.isEmpty || goalDate.text.isEmpty){
                  return;
                }
                db.collection('goalTracker').doc(paramater['id']).collection("goals").doc(id).update({
                  "goalAmount": goalAmount.text,
                  "goalDate": goalDate.text
                });
                goalAmount.text = "";
                goalDate.text = "";
                Navigator.pop(context);
              },
              child: const Text("Update")),
        ],
      );
    });
  }

  deleteGoal(id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Goal"),
          content: const Text("Are you sure you want to delete this goal?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                db.collection('goalTracker').doc(paramater['id']).collection("goals").doc(id).delete();
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
