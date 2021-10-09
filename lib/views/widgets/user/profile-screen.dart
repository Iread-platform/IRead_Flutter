import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/avatars_bloc/avatar_events.dart';
import 'package:iread_flutter/bloc/avatars_bloc/avatars_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/profile_bloc/profile_bloc.dart';
import 'package:iread_flutter/bloc/profile_bloc/profile_states.dart';
import 'package:iread_flutter/models/user/profile.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:iread_flutter/views/widgets/Image_picker_dialog.dart';
import 'package:iread_flutter/views/widgets/opened_library/stories_section.dart';
import 'package:iread_flutter/views/widgets/shared/request_handler.dart';
import 'package:iread_flutter/views/widgets/user/avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RequestHandler<ProfileDataFetched, ProfileBloc>(
          main: Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          onSuccess: (context, state) {
            Profile user = state.data.data as Profile;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 70),
              color: Theme.of(context).colorScheme.surface,
              child: ListView(
                children: [
                  userDetailsRow(
                      context,
                      '${user.firstName} ${user.lastName}',
                      user.schoolMember.classes[0].title,
                      user.schoolMember.schoolTitle,
                      user.avatarAttachment.downloadUrl),
                  StoriesSection(
                    title: 'Read Stories',
                    storiesList: user.viewStories,
                    storyWidth: 100,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget userDetailsRow(BuildContext context, String name,
      String classSectionName, String schoolName, String imageUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              name,
              style: _userDetailsTextStyle(context),
            ),
            Text(
              classSectionName,
              style: _userDetailsTextStyle(context),
            ),
            Text(
              schoolName,
              style: _userDetailsTextStyle(context),
            )
          ],
        ),
        Container(
          height: 200,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              UserAvatar(
                imageUrl: imageUrl,
                radius: 60.0,
                showShadow: true,
              ),
              Positioned(
                  top: 30,
                  right: 5,
                  child: IconButton(
                    icon: Icon(
                      IReadIcons.camera_fill,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return BlocProvider(
                                create: (context) => AvatarsBloc(InitialState())
                                  ..add(FetchAvatarDataEvent()),
                                child: ImagePickerDialog());
                          });
                    },
                  ))
            ],
          ),
        )
      ],
    );
  }

  TextStyle _userDetailsTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.headline4;
  }
}
