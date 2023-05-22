import 'package:flutter/material.dart';

class ReloadPage extends StatelessWidget {
  const ReloadPage({super.key, required this.erroMsg, required this.onTap});
  final String erroMsg;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Ooopsies: $erroMsg"),
            const SizedBox(
              height: 8,
            ),
            TextButton(
                onPressed: onTap,
                child: const Text("Reload"))
          ],
        ),
      ),
    );
  }
}
