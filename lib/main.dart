import 'package:apollo_flutter/apollo.dart';
import 'package:flutter/material.dart';
import 'package:payment_flutter/payment.dart';
import 'package:payment_flutter/vnpay_ewallet/vnpay_ewallet_user.dart';
import 'package:terra_flutter/terra_app.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String apolloTheme = "";
  String terraApp = "";
  String vnpayResult = "";

  @override
  void initState() {
    initConfig();

    super.initState();
  }

  void initConfig() async {
    try {
      await Apollo.getInstance(TerraApp.defaultAppName);
    } on Exception catch (error) {}

    try {
      final terra = await TerraApp.initTerraApp();
      setState(() {
        terraApp = terra.clientId;
      });
    } on Exception catch (error) {
      terraApp = error.toString();
    }
  }

  void _openVNPAYEwallet() async {
    setState(() {
      vnpayResult = "Initial State";
    });

    const phone = "0374264438";

    try {
      final payment = await TerraPayment.getInstance(TerraApp.defaultAppName);

      payment.openVnPayEWallet(VnPayEWalletUser(
        partnerId: phone,
        phone: phone,
      ));
      setState(() {
        vnpayResult = "Success";
      });
    } on Exception catch (e) {
      setState(() {
        vnpayResult = "Failed";
      });
    } on Error catch (e) {
      setState(() {
        vnpayResult = "Failed Error";
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(terraApp),
            Text(vnpayResult),
            ElevatedButton(
                onPressed: _openVNPAYEwallet,
                child: const Text("Open VNPAY Ewallet")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openVNPAYEwallet,
        tooltip: 'Open VNPAY',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
