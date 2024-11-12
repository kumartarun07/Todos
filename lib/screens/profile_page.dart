import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? profilePic ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Profile"),centerTitle: true,),
      body: Center(
        child: Column(
          children: [
            Stack(alignment: Alignment.topRight,
              children: [
                Container(
                  height: 100,width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2,color: Colors.black),
                    shape: BoxShape.circle,
                    color: Colors.orange,
                     image:profilePic!=null? DecorationImage(image:FileImage(profilePic!)):
                     DecorationImage(image: AssetImage("lib/assets/image/todo.jpeg"),fit: BoxFit.cover)
                  ),
                ),
                IconButton(onPressed: (){
                  showModalBottomSheet(context: context, builder: (context){
                    return bottomsheet(context);
                  });
                }, icon: Icon(Icons.edit,size: 35,))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget bottomsheet(BuildContext context)
  {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back,size: 25,)),
              IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.highlight_remove_outlined,size: 25,)),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(onPressed: ()
                  async{
                    XFile? imgPicked =await ImagePicker().pickImage(source: ImageSource.camera);
                    if(imgPicked!=null)
                    {
                      CroppedFile? croppedFile= await ImageCropper().cropImage(sourcePath: imgPicked.path,
                          maxHeight: 200,
                          maxWidth: 200,
                          uiSettings: [
                            AndroidUiSettings(
                              toolbarTitle: "Cropper",
                              toolbarColor: Colors.deepOrange,
                              toolbarWidgetColor: Colors.white,
                            ),
                            IOSUiSettings(
                              title: "Cropper",
                            ),
                            WebUiSettings(context: context)
                          ]
                      );
                      if(croppedFile!=null){
                        profilePic = File(croppedFile.path);
                        setState(() {

                        });
                      }

                    }

                  }, icon: Icon(Icons.camera_alt_outlined,color: Colors.black,size: 100,)),
                  Text("Camera",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                ],
              ),
              Column(
                children: [
                  IconButton(onPressed: ()async{
                    XFile? imgPicked = await ImagePicker().pickImage(source: ImageSource.gallery);

                    if(imgPicked!=null){
                      CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: imgPicked.path,
                          maxWidth: 200,
                          maxHeight: 200,
                          uiSettings: [
                            AndroidUiSettings(
                                toolbarTitle: "Cropper",
                                toolbarColor: Colors.deepOrange,
                                toolbarWidgetColor: Colors.white
                            ),
                            IOSUiSettings(title: "Cropper"),
                            WebUiSettings(context: context)
                          ]
                      );
                      if(croppedFile!=null){
                        profilePic=File(croppedFile.path);
                        setState(() {

                        });
                      }
                    }
                  }, icon: Icon(Icons.photo_album,color: Colors.black,size: 100,)),
                  Text("Gallery",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                ],
              ),
             /* Column(
                children: [
                  IconButton(onPressed: ()async{
                    XFile? imgPicked = await ImagePicker().pickImage(source: ImageSource.gallery);

                    if(imgPicked!=null){
                      CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: imgPicked.path,
                          maxWidth: 200,
                          maxHeight: 200,
                          uiSettings: [
                            AndroidUiSettings(
                                toolbarTitle: "Cropper",
                                toolbarColor: Colors.deepOrange,
                                toolbarWidgetColor: Colors.white
                            ),
                            IOSUiSettings(title: "Cropper"),
                            WebUiSettings(context: context)
                          ]
                      );
                      if(croppedFile!=null){
                        profilePic=File(croppedFile.path);
                        setState(() {

                        });
                      }
                    }
                  }, icon: Icon(Icons.emoji_emotions,color: Colors.black,size: 100,)),
                  Text("Avatar",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                ],
              ),*/
            ],
          )
        ],
      ),
    );
  }
}
