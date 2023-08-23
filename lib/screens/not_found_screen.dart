import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  static const name = 'screenNotFound';

  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Screen not found'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back'),
            )
          ],
        ),
      ),
    );
  }
}
