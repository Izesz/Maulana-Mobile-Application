import 'package:flutter/material.dart';
import 'shared/follow_card.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
        home: const SetStateDemo(),
      ),
    );

class SetStateDemo extends StatefulWidget {
  const SetStateDemo({super.key});

  @override
  State<SetStateDemo> createState() => _SetStateDemoState();
}

class _SetStateDemoState extends State<SetStateDemo> {
  // STATE: tinggal di sini, hanya bisa diakses widget ini
  bool _isFollowing = false;
  int _followers = 1200;

  void _onFollowPressed() {
    setState(() {
      _isFollowing = !_isFollowing;
      _followers += _isFollowing ? 1 : -1;
    });
    showFollowSnack(context, _isFollowing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('1 · setState')),
      body: Center(
        child: FollowCard(
          name: 'Fakhry Firdaus',
          followers: _followers,
          isFollowing: _isFollowing,
          onFollowPressed: _onFollowPressed,
        ),
      ),
    );
  }
}
