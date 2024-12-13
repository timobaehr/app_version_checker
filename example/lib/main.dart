import 'dart:io';

import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _ehwChecker = AppVersionChecker(
    appId: "com.ehwplus",
    androidStore: AndroidStore.apkPure,
  );
  String? ehwValue;

  @override
  void initState() {
    super.initState();
    checkVersion();
  }

  void checkVersion() async {
    await Future.wait([
      _ehwChecker
          .checkUpdate()
          .then((value) => ehwValue = value.toString()),
    ]);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('APP Version Checker'),
          actions: [
            InkWell(
              onTap: checkVersion,
              child: const Icon(Icons.refresh),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              const SizedBox(height: 25.0),
              Text(
                Platform.isAndroid
                    ? "EHW+ PlayStore (Android):"
                    : "EHW+ AppStore (iOS)",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Text(
                ehwValue ?? 'Loading ...',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
