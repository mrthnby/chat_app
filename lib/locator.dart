import 'repository/user_repository.dart';
import 'services/firebase_auth_services.dart';
import 'services/firebase_storage_services.dart';
import 'services/firestore_db_services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<FirebaseAuthServices>(FirebaseAuthServices());
  locator.registerSingleton<FirestoreDbServices>(FirestoreDbServices());
  locator.registerSingleton<FirebaseStorageServices>(FirebaseStorageServices());
  locator.registerSingleton<UserRepository>(UserRepository());
}
