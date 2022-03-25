import 'package:flutter/material.dart';

import './responsive_helper.dart';

// ! This will cause issue in RELEASE mode.
// * Lightweight application can be loaded very fast in release mode,
// * and device size information unable to be fetched on time.
// * e.g. `MediaQuery.of(context).size.width`, `WidgetsBinding.instance.window.physicalSize.width`.
// * Uncomment this main function and comment out main async function below to replicate the issue.
// void main() {
//   runApp(const MyApp());
// }

// ! Use this to resolve the issue.
// * To resolve the issue, I add one delay task and let Flutter has enough time to get the device information.
void main() async {
  /* 
    * Additional function call to ensure widgets fluttter binding is initialized,
    * but the issue still happens if no delay task below.
  */
  WidgetsFlutterBinding.ensureInitialized();
  /* 
    * This will make splash screen lasts for the duration of the delay task.
    * 300ms looks well for me, can adjust based on your preference.
  */
  await Future.delayed(const Duration(milliseconds: 300));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.setRatio();

    return MaterialApp(
      title: 'Device Width Issue Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          toolbarHeight: ResponsiveHelper.relativePixel(50),
          iconTheme: IconThemeData(
            size: ResponsiveHelper.relativeFontSize(1.5),
            color: Colors.white,
          ),
          titleSpacing: ResponsiveHelper.relativePixel(20),
        ),
        textTheme: Theme.of(context)
            .textTheme
            .apply(fontSizeFactor: ResponsiveHelper.ratio),
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Device Width Issue Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(ResponsiveHelper.defaultPadding),
              decoration: const BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                'Responsive text.',
                style: TextStyle(
                  fontSize: ResponsiveHelper.relativeFontSize(2),
                ),
              ),
            ),
            SizedBox(
              height: ResponsiveHelper.relativePixel(20),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Text(
                'Fixed size text.',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
