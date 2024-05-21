class AppState {
  static String? _userId;

  static String? getUserId() {
    return _userId;
  }

  static void setUserId(String? userId) {
    _userId = userId;
  }
}
