import 'package:flutter/material.dart';
import 'package:progressive_button_flutter/progressive_button_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Progressive Button Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    Future<void> makeApiCall() async {
      await Future.delayed(const Duration(seconds: 8));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            ProgressiveButtonFlutter(
              text: 'Click Me',
              onPressed: makeApiCall,
              estimatedTime: const Duration(seconds: 5),
              showCircularIndicator: false,
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ProgressiveButtonFlutter(
                text: 'Click Me',
                onPressed: makeApiCall,
                estimatedTime: const Duration(seconds: 5),
                showCircularIndicator: true,
                backgroundColor: const Color(0xffabd4ed),
                progressColor: const Color(0xff5ba9d6),
                stretched: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
