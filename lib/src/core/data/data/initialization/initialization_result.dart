import 'package:multivendor_clean_architecture_starter/src/core/data/data/dependency/dependency_application.dart';
import 'package:multivendor_clean_architecture_starter/src/core/data/data/dependency/dependency_data.dart';

class InitializationResult {
  const InitializationResult({
    required this.data,
    required this.application,
  });

  final DependencyData data;
  final DependencyApplication application;
}
