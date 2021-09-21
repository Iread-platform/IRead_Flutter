import 'package:flutter/material.dart';
import 'package:iread_flutter/bloc/profile_bloc/profile_bloc.dart';
import 'package:iread_flutter/bloc/profile_bloc/profile_states.dart';
import 'package:iread_flutter/views/widgets/shared/request_handler.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RequestHandler<ProfileDataFetched, ProfileBloc>(
        main: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        onSuccess: (context, state) {
          return Container();
        },
      ),
    );
  }
}
