import 'package:get_it/get_it.dart';
import 'package:inventory_management_app/utils/hive_configs.dart';
import 'package:inventory_management_app/utils/hive_helper.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Initialize Hive and register adapters
  final hiveConfig = HiveConfig();
  await hiveConfig.initHive();

  // Register HiveHelper
  getIt.registerSingleton<HiveHelper>(HiveHelper());
}
