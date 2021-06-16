enum DataState { Loading, Success, Fail, Init, Close }

abstract class BlocState {
  DataState state = DataState.Success;
  String message = "Success";
}

class LoadingState extends BlocState {
  LoadingState() {
    state = DataState.Loading;
  }
}

class InitialState extends BlocState {
  InitialState() {
    state = DataState.Init;
  }
}

class SuccessState<T> extends BlocState {
  T data;
}

class FailState extends BlocState {
  String _imageUrl;
  bool _isAssetImage;

  FailState({String imageUrl, bool isAssetImage})
      : _imageUrl = imageUrl,
        _isAssetImage = isAssetImage;
}

abstract class BlocEvent {}

class LoadingEvent extends BlocEvent {}

class CloseEvent extends BlocEvent {}
