import 'dart:async';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/login_steps.dart';
Future<void> main() {
  enableFlutterDriverExtension();
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/**.feature")]
    ..reporters = [ProgressReporter()]
    ..stepDefinitions = [CheckGivenWidgets(),ClickLoginButton()]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart";
  return GherkinRunner().execute(config);
}