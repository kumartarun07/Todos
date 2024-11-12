import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/screens/profile_page.dart';
import 'package:todos_app/utills/custom_widget.dart';
import '../model/todo_model.dart';
import 'add_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var uid = "";
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getUid();
  }

  DateFormat mformate = DateFormat.jms();

  getUid() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    uid = pref.getString(LoginPage.LoginId) ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> collection =
        fireStore.collection("Users").doc(uid).collection("Todos").snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo's App"),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircleAvatar(
                  child: Icon(Icons.account_circle),
                ),
              ))
        ],
      ),
      body: StreamBuilder(
          stream: collection,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error:${snapshot.error}",style: myTextstyle15(mFontWeight: FontWeight.bold),),
              );
            }
            if (snapshot.hasData) {
              return snapshot.data!.docs.isNotEmpty
                  ? ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_, index) {
                        TodoModel eachTodo = TodoModel.fromMap(
                            snapshot.data!.docs[index].data());
                        return Card(
                          color: Colors
                              .primaries[
                                  (Random().nextInt(Colors.primaries.length))]
                              .shade200,
                          child: ListTile(
                            title: Text(
                              eachTodo.title,
                              style: TextStyle(
                                  decoration: eachTodo.completed == 1
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                            subtitle: Text(
                              eachTodo.desc,
                              style: TextStyle(
                                  decoration: eachTodo.completed == 1
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                            leading: Checkbox(
                                value: eachTodo.completed == 1,
                                onChanged: (value) {
                                  var todomodel = TodoModel(
                                      createAT: eachTodo.createAT,
                                      title: eachTodo.title,
                                      desc: eachTodo.desc,
                                      completed: value! ? 1 : 0);

                                  fireStore
                                      .collection("Users")
                                      .doc(uid)
                                      .collection("Todos")
                                      .doc(snapshot.data!.docs[index].id)
                                      .update(todomodel.toMap());
                                }),
                            trailing: FittedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    mformate.format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(eachTodo.createAT))),
                                    style: myTextstyle20(),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddPage(
                                                          isUpdate: true,
                                                          title: eachTodo.title,
                                                          desc: eachTodo.desc,
                                                          docId: snapshot.data!
                                                              .docs[index].id,
                                                        )));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.green.shade300,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            fireStore
                                                .collection("Users")
                                                .doc(uid)
                                                .collection("Todos")
                                                .doc(snapshot
                                                    .data!.docs[index].id)
                                                .delete();
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : Center(
                      child: Text("No Data Yet !!",style: myTextstyle15(),),
                    );
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPage()));
        },
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.pink.shade200,
      ),
    );
  }
}
