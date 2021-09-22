import 'package:flutter/material.dart';
import 'package:iread_flutter/bloc/profile_bloc/profile_bloc.dart';
import 'package:iread_flutter/bloc/profile_bloc/profile_states.dart';
import 'package:iread_flutter/models/user/user.dart';
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
            User user = state.data.data as User;

            print('Profile data fetched');
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 70),
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                children: [
                  userDetailsRow(
                    context,
                    '${user.firstName} ${user.lastName}',
                    'Class Name',
                    'School Name',
                    'https://thumbs.dreamstime.com/b/man-hipster-avatar-cartoon-guy-black-hair-flat-icon-blue-background-user-person-character-vector-illustration-185480506.jpg',
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
            alignment: Alignment.center,
            children: [
              UserAvatar(
                imageUrl: imageUrl,
                radius: 60.0,
                showShadow: true,
              )
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
