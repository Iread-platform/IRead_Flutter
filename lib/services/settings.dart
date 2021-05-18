/// Where all app static settings should be set.
class Settings {
  static const double BORDER_RADIUS_SMALL = 5;
  static const double BORDER_RADIUS_MEDIUM = 10;
  static const double BORDER_RADIUS_LARGE = 20;

  static const String ASSET_ICON_MENU = "assets/icons/menu.svg";

  static const Map<int, String> HTTP_REQUEST_STATE_CODE = {
    200: "Ok",
    400: "Bad Request",
    401: "Unauthorized",
    403: "Forbidden",
    404: "Not Found",
    408: "Request Timeout",
  };
}

enum DataStatus { inProgress, succeed, faild, timeout, none }

enum NetworkState { connected, disconnected, none }

enum ErrorType { network, emptyResponse, other, none }
