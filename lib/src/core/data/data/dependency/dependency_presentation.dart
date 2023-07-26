import 'package:multi_vendor_starter/src/presentation/router/application_router.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/widgets.dart';

part '../../../../../generated/src/core/data/data/dependency/dependency_presentation.freezed.dart';

@freezed
class DependencyPresentation with _$DependencyPresentation {
  const factory DependencyPresentation({
    required Locale locale,
    required ApplicationRouter router,
  }) = _DependencyPresentation;
}
