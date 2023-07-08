import 'package:hive_flutter/hive_flutter.dart';

import 'adapter.dart';

void configureAdapter() {
  Hive.registerAdapter(UserAdapter());
}
