import 'package:flutter/material.dart';
import 'package:progressive_button_flutter/progressive_button_flutter.dart';

/// The main entry point of the application.
void main() {
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  /// Creates an instance of [MyApp].
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

/// The home page of the application.
class MyHomePage extends StatelessWidget {
  /// Creates an instance of [MyHomePage].
  const MyHomePage({super.key, required this.title});

  /// The title of the home page.
  final String title;

  @override
  Widget build(BuildContext context) {
    /// Simulates an API call with a delay.
    Future<void> makeApiCall() async {
      await Future.delayed(const Duration(seconds: 8));
    }

    /// Displays a success message.
    Future<void> onSuccess() async {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Success!')),
      );
    }

    /// Displays a failure message.
    Future<void> onFailure() async {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failure!')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            ProgressiveButtonFlutter(
              text: 'Default Button',
              onPressed: makeApiCall,
              estimatedTime: const Duration(seconds: 1),
              elevation: 5,
              audioAssetPath: 'assets/audio/pop_effect.wav',
              volume: 1.0,
            ),
            const SizedBox(height: 50),
            ProgressiveButtonFlutter(
              text: 'Button with Success Callback',
              onPressed: makeApiCall,
              onSuccess: onSuccess,
              estimatedTime: const Duration(seconds: 5),
              elevation: 5,
              width: 300,
            ),
            const SizedBox(height: 50),
            ProgressiveButtonFlutter(
              text: 'Button with Failure Callback',
              onPressed: () async {
                throw Exception('Simulated Failure');
              },
              onFailure: onFailure,
              estimatedTime: const Duration(seconds: 5),
              elevation: 5,
              width: 300,
            ),
            const SizedBox(height: 50),
            ProgressiveButtonFlutter(
              text: 'Stretched Button',
              onPressed: makeApiCall,
              estimatedTime: const Duration(seconds: 5),
              stretched: true,
              elevation: 5,
              gradient: const LinearGradient(
                colors: [
                  Colors.pinkAccent,
                  Colors.blueAccent,
                ],
              ),
              progressGradient: const LinearGradient(
                colors: [
                  Colors.brown,
                  Colors.purpleAccent,
                  Colors.white,
                ],
              ),
            ),
            const SizedBox(height: 50),
            ProgressiveButtonFlutter(
              text: 'Custom Styled Button',
              onPressed: makeApiCall,
              estimatedTime: const Duration(seconds: 5),
              backgroundColor: Colors.blue,
              progressColor: Colors.lightBlue,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              borderRadius: BorderRadius.circular(10),
              elevation: 5,
            ),
            const SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
