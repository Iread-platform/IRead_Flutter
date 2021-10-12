
class Data<T> {
  T _data;
  String _message = "";
  int st;
  Data(this._data, this._message);

  T get data => _data;
  String get message => _message;

  Data.succeed({T data}) {
    this._data = data;
  }
  Data.faild({String message}) {
    this._message = message;
  }
}
