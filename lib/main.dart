import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StreamSubscription<List<ConnectivityResult>> subscription;

  IconData? icon;

  @override
  initState() {
    super.initState();

    StreamSubscription<List<ConnectivityResult>> subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> connectivityResult) {
      if (connectivityResult.contains(ConnectivityResult.mobile)) {
        setState(() {
          icon = Icons.h_mobiledata;
        });
      } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
        setState(() {
          icon = Icons.wifi;
        });
      } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
        setState(() {
          icon = Icons.settings_ethernet;
        });
      } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
        setState(() {
          icon = Icons.vpn_lock;
        });
      } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
        setState(() {
          icon = Icons.bluetooth_connected;
        });
      } else if (connectivityResult.contains(ConnectivityResult.other)) {
        setState(() {
          icon = Icons.device_unknown;
        });
      } else if (connectivityResult.contains(ConnectivityResult.none)) {
        setState(() {
          icon = Icons.wifi_off;
        });
      }
    });
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(icon, size: 48),
      ),
    );
  }
}
