import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/utills/custom_widget.dart';
import '../model/todo_model.dart';
import 'login_page.dart';

class AddPage extends StatelessWidget {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  String title, desc, docId;
  bool isUpdate;

  AddPage(
      {this.desc = "",
      this.title = "",
      this.isUpdate = false,
      this.docId = ""});

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  //static var currentTime = DateTime.now().millisecondsSinceEpoch.toString();
  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      titleController.text = title;
      descController.text = desc;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade200,
        title: FittedBox(
            child: Text(
          isUpdate ? "Update Your Todo's" : "Add Your Todo's",
          style: myTextstyle15(mFontWeight: FontWeight.bold),
        )),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            )),
        actions: [
          /// add and update todo here
          TextButton(
              onPressed: () async {
                var currentTime =
                    DateTime.now().millisecondsSinceEpoch.toString();
                SharedPreferences pref = await SharedPreferences.getInstance();
                String uid = pref.getString(LoginPage.LoginId) ?? "";
                if (isUpdate) {
                  if (titleController.text.isNotEmpty &&
                      descController.text.isNotEmpty) {
                    TodoModel todomodel = TodoModel(
                        createAT: currentTime.toString(),
                        title: titleController.text,
                        desc: descController.text);
                    fireStore
                        .collection("Users")
                        .doc(uid)
                        .collection("Todos")
                        .doc(docId)
                        .update(todomodel.toMap());
                  }
                } else {
                  if (titleController.text.isNotEmpty &&
                      descController.text.isNotEmpty) {
                    fireStore
                        .collection("Users")
                        .doc(uid)
                        .collection("Todos")
                        .doc(currentTime)
                        .set(TodoModel(
                          createAT: currentTime.toString(),
                          title: titleController.text,
                          desc: descController.text,
                        ).toMap());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("Error: Please Fill the All Blanks Field",style: myTextstyle20(),)));
                  }
                }
                Navigator.pop(context);
              },
              child: Text(isUpdate ? "Update Todo" : "Add Todo",
                  style: myTextstyle12(mFontWeight: FontWeight.bold))),

          /// delete todo here
          TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text("Cancel",
                  style: myTextstyle12(mFontWeight: FontWeight.bold))),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.indigo.shade200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isUpdate ? "Update Title" : "Add Title",
                    style: myTextstyle20(mFontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: titleController,
                  maxLines: null,
                  //scrollPhysics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  minLines: 5,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText:"Enter the note here "),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(isUpdate ? "Update Desc" : "Add Description",
                    style:myTextstyle20(mFontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: descController,
                  maxLines: null,
                  //scrollPhysics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  minLines: 10,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText:"Enter the Description here "),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
  Dio
  api socket
  live calling
  zigo cloud
  riverPod State Management
  otp
  notification
  Ad integrate
  payment gateway
  git pr create karna sikhayege and  pull request & branches
*/
