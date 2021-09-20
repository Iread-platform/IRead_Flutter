abstract class FirebaseBaseService {
  Future<void> init();
  FirebaseBaseService() {
    init();
  }
}
