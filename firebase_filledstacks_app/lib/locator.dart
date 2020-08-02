import 'package:firebase_filledstacks_app/services/analytics_service.dart';
import 'package:firebase_filledstacks_app/services/authentication_service.dart';
import 'package:firebase_filledstacks_app/services/cloud_storage_service.dart';
import 'package:firebase_filledstacks_app/services/firestore_service.dart';
import 'package:firebase_filledstacks_app/services/push_notification_service.dart';
import 'package:firebase_filledstacks_app/utils/image_selector.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_filledstacks_app/services/navigation_service.dart';
import 'package:firebase_filledstacks_app/services/dialog_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => CloudStorageService());
  locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => AnalyticsService());
}
