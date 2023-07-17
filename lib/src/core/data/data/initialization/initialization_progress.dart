import 'package:multi_vendor_starter/src/core/data/source/database/application_database.dart';
import 'package:multi_vendor_starter/src/core/data/repository/cat_fact_repository.dart';
import 'package:multi_vendor_starter/src/presentation/router/application_router.dart';
import 'package:multi_vendor_starter/src/core/data/data/config/config.dart';
import 'package:multi_vendor_starter/src/core/data/client/api_clent.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/widgets.dart';

part '../../../../../generated/src/core/data/data/initialization/initialization_progress.freezed.dart';

@unfreezed
class InitializationProgress with _$InitializationProgress {
  factory InitializationProgress({
    IConfig? config,
    IApiClient? apiClient,
    ApplicationDatabase? applicationDatabase,
    ICatFactRepository? catFactRepository,
    Locale? locale,
    ApplicationRouter? router,
  }) = _InitializationProgress;
}
