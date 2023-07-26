import 'package:multi_vendor_starter/src/core/data/data/dependency/dependency.dart';
import 'package:multi_vendor_starter/src/utility/mixin/scope_mixin.dart';
import 'package:flutter/material.dart';

class DependencyScope extends InheritedWidget with ScopeMixin {
  const DependencyScope({
    super.key,
    required this.dependency,
    required super.child,
  });

  final Dependency dependency;

  static Dependency of(BuildContext context) =>
      ScopeMixin.of<DependencyScope>(context).dependency;

  @override
  bool updateShouldNotify(DependencyScope oldWidget) => false;
}
