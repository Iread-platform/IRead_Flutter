import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iread_flutter/bloc/avatars_bloc/avatar_events.dart';
import 'package:iread_flutter/bloc/avatars_bloc/avatars_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/profile_bloc/profile_bloc.dart';
import 'package:iread_flutter/models/attachment/attachment.dart';
import 'package:iread_flutter/services/permissions_service.dart';
import 'package:iread_flutter/views/widgets/shared/request_handler.dart';
import 'package:provider/provider.dart';

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
  AvatarsBloc _bloc;
  Future getImage() async {
    await PermissionService.checkStoragePermission();
    final img = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = img;
      indexAvatar = 0;
    });
  }

  @override
  void initState() {
    _bloc = context.read<AvatarsBloc>();
    _bloc.setProfileBloc(context.read<ProfileBloc>());
    super.initState();
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
        content: RequestHandler<SuccessState, AvatarsBloc>(
            main: Container(
              width: w,
              height: h * 0.45,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            onSuccess: (context, state) {
              final avatarsAttachment = state.data as List<Attachment>;
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                width: w,
                height: h * 0.6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: h * 0.3,
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: avatarsAttachment.length + 1,
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
                                          borderRadius:
                                              BorderRadius.circular(100))
                                      : null,
                                  child: CircleAvatar(
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.5),
                                      backgroundImage: image != null
                                          ? FileImage(image)
                                          : null,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.purple
                                                  .withOpacity(0.4),
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
                                            borderRadius:
                                                BorderRadius.circular(100))
                                        : null,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        avatarsAttachment[i - 1].downloadUrl,
                                      ),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      image = null;
                                      indexAvatar = i;
                                    });
                                  },
                                );
                        },
                      ),
                    ),
                    Container(
                        width: w * 0.40,
                        child: ElevatedButton(
                            child: Text("Save"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.purple),
                            onPressed: () {
                              image != null
                                  ? uploadAvatar()
                                  : updateExistingAvatar(
                                      avatarsAttachment[indexAvatar - 1].id);
                            }))
                  ],
                ),
              );
            }),
      ),
    );
  }

  updateExistingAvatar(int id) {
    _bloc.add(UpdateUserAvatarEvent(id: id));
  }

  uploadAvatar() {
    _bloc.add(UpdateUserAvatarEvent(image: image));
  }

  get assetImagePath => "assets/AvatarImages/$indexAvatar.png";
}
