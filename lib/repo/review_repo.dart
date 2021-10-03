import 'dart:convert';

import 'package:iread_flutter/models/review/review_submit.dart';
import 'package:iread_flutter/services/api_service.dart';
import 'package:iread_flutter/utils/data.dart';

class ReviewRepo {
  static final ReviewRepo _instance = ReviewRepo._internal();
  ReviewRepo._internal();

  factory ReviewRepo() => _instance;

  final _apiService = ApiService();

  final String _submitReviewEndPoint = 'review/add';

  Future<Data> submitReview(ReviewSubmit reviewSubmit) async {
    try {
      final response = await _apiService.request(
          requestType: RequestType.POST,
          endPoint: _submitReviewEndPoint,
          parameter: reviewSubmit);
      print(response);
      final json = jsonDecode(response);

      return Data.success(json);
    } catch (e) {
      return Data.handleException(e);
    }
  }
}
