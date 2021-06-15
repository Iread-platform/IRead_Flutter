enum DataState { Loading, Success, Fail, Init, Close }

abstract class BlocState {
  DataState state = DataState.Success;
  String message = "Success";
}

class SuccessState<T> extends BlocState {
  T data;
}

abstract class BlocEvent {}

class CloseEvent extends BlocEvent {}
