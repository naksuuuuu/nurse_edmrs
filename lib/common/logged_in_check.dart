import 'package:get_storage/get_storage.dart';

bool isLoggedIn() {
  return GetStorage().read('isLoggedIn') ?? false;
}
