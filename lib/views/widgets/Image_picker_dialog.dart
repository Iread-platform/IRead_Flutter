import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//Example :
/*
  onPressed: (){
    return showDialog(context: context, builder: (context) {
        return ImagePickerDialog();
          },);
  },
*/
class ImagePickerDialog extends StatefulWidget {
  @override
  _ImagePickerDialogState createState() => _ImagePickerDialogState();
}

class _ImagePickerDialogState extends State<ImagePickerDialog> {
  File image;
  int indexAvatar = 0;
  List<String> avatars = [];
  Future getImage() async {
    final img = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = img;
      indexAvatar = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Center(
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.all(15),
        content: Container(
          padding: EdgeInsets.all(15),
          width: w,
          height: h * 0.45,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GridView.builder(
                shrinkWrap: true,
                itemCount: 12,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15),
                itemBuilder: (context, i) {
                  //======== Choise Avatar from gallay ==============
                  return i == 0
                      ? Container(
                          decoration: i == indexAvatar
                              ? BoxDecoration(
                                  border: Border.all(
                                      color: Colors.purple, width: 3),
                                  borderRadius: BorderRadius.circular(100))
                              : null,
                          child: CircleAvatar(
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              backgroundImage:
                                  image != null ? FileImage(image) : null,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.purple.withOpacity(0.4),
                                      shape: CircleBorder(
                                          side: BorderSide(width: 2))),
                                  child: Icon(Icons.camera_alt_rounded),
                                  onPressed: getImage)),
                        )
                      //===========  Avatars  ==============
                      : InkWell(
                          child: Container(
                            decoration: i == indexAvatar
                                ? BoxDecoration(
                                    border: Border.all(
                                        color: Colors.purple, width: 3),
                                    borderRadius: BorderRadius.circular(100))
                                : null,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/AvatarImages/$i.png"),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              indexAvatar = i;
                            });
                          },
                        );
                },
              ),
              Container(
                  width: w * 0.40,
                  child: ElevatedButton(
                      child: Text("Save"),
                      style: ElevatedButton.styleFrom(primary: Colors.purple),
                      onPressed: () {
                        Navigator.pop(context);
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
