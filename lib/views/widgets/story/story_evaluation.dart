import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/story/story_details_bloc/story_details_bloc.dart';
import 'package:iread_flutter/bloc/story/story_details_bloc/story_details_events.dart';
import 'package:iread_flutter/bloc/story/story_details_bloc/story_details_states.dart';
import 'package:iread_flutter/config/themes/border_radius.dart';
import 'package:iread_flutter/services/auth_service.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:iread_flutter/views/widgets/review/review_list.dart';
import 'package:iread_flutter/views/widgets/user/avatar.dart';
import 'package:provider/provider.dart';

class StoryEvaluation extends StatefulWidget {
  final String _evaluationHeader = 'Evaluation';
  final String _evaluateLabel = 'Evaluate';

  const StoryEvaluation({Key key}) : super(key: key);

  @override
  _StoryEvaluationState createState() => _StoryEvaluationState();
}

class _StoryEvaluationState extends State<StoryEvaluation> {
  StoryDetailsBloc _bloc;
  _StoryEvaluationState();

  @override
  void initState() {
    _bloc = context.read<StoryDetailsBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            widget._evaluationHeader,
            style: Theme.of(context).textTheme.headline4,
          ),
          UserAvatar(
            imageUrl: AuthService().cU.imageUrl,
            radius: 50.0,
          ),
          Text(
            AuthService().cU.firstName + " " + AuthService().cU.lastName,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 8,
          ),
          BlocBuilder<StoryDetailsBloc, BlocState>(
              buildWhen: (previous, current) {
            return current is ReviewState || current is InitialState;
          }, builder: (context, state) {
            return RatingBar.builder(
                itemSize: 24,
                itemCount: 5,
                glowColor: Colors.amberAccent,
                minRating: 1,
                initialRating: 1,
                unratedColor: Colors.black12,
                itemBuilder: (context, index) => Icon(
                      IReadIcons.star,
                      color: Colors.amber,
                    ),
                onRatingUpdate: state.runtimeType == ReviewIsSubmitting
                    ? null
                    : (rating) {
                        _bloc.rate = rating.round();
                      });
          }),
          SizedBox(
            height: 12,
          ),
          BlocBuilder<StoryDetailsBloc, BlocState>(
              buildWhen: (previous, current) {
            return current is ReviewState || current is InitialState;
          }, builder: (context, state) {
            return ElevatedButton(
              onPressed: state is ReviewIsSubmitting
                  ? null
                  : () => {_bloc.add(SubmitReviewEvent())},
              child: Text(
                state is ReviewIsSubmitting
                    ? 'Evaluating'
                    : state is ReviewSubmittedState ? 'Re-Evaluate' : widget._evaluateLabel,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Theme.of(context).colorScheme.surface),
              ),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(storyBorderRadius)),
              ),
            );
          }),
          SizedBox(
            height: 24,
          ),
          ReviewList()
        ],
      ),
    );
  }
}
