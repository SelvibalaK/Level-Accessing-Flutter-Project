import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Wrap with Provider
    ChangeNotifierProvider(
      create: (context) => LevelStatus(),
      child: const MyApp(),
    ),
  );
}

class LevelStatus extends ChangeNotifier {
  bool level1Completed = false;
  bool level2Completed = false;
  bool level3Completed = false;
  bool level4Completed = false;

  void markLevelCompleted(int level) {
    switch (level) {
      case 1:
        level1Completed = true;
        break;
      case 2:
        level2Completed = true;
        break;
      case 3:
        level3Completed = true;
        break;
      case 4:
        level4Completed = true;
        break;
    }
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(levelStatus: context.watch<LevelStatus>()),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final LevelStatus levelStatus;

  const HomeScreen({Key? key, required this.levelStatus}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _handlePlayButtonPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GameScreen()),
    );
  }

  void _handleSettingsButtonPress() {
    // Reset all level completion flags
    Provider.of<LevelStatus>(context, listen: false).level1Completed = false;
    Provider.of<LevelStatus>(context, listen: false).level2Completed = false;
    Provider.of<LevelStatus>(context, listen: false).level3Completed = false;
    Provider.of<LevelStatus>(context, listen: false).level4Completed = false;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ACCESS THE LEVELS',
              style: const TextStyle(
                fontSize: 40.0,
                fontFamily: 'ComicNeue',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 100.0),
            ElevatedButton(
              onPressed: _handlePlayButtonPress,
              child: const Text('Play'),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _handleSettingsButtonPress,
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  void showLevelCompletionNotice(BuildContext context, String level) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please finish Level $level first!'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final levelStatus = Provider.of<LevelStatus>(context);
    return Scaffold(
      backgroundColor: Colors.pink[300],
      appBar: AppBar(
        title: const Text('ACCESS THE LEVELS'),
      ),
      body: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      const Text(
      'CHOOSE THE LEVEL',
      style: TextStyle(fontSize: 35.0,
          fontFamily: 'ComicNeue',
          color: Colors.black),
    ),
    const SizedBox(height: 20.0),
    Expanded(
    child: ListView(
    shrinkWrap: true,
    padding: const EdgeInsets.symmetric(horizontal: 20.0),

      children: [
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Level1Screen(
                levelStatus: Provider.of<LevelStatus>(context),
              ),
            ),
          ),
          child: Text('Level 1'),
        ),
        const SizedBox(height: 20.0),
        TextButton(
          onPressed: () => levelStatus.level1Completed
              ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Level2Screen(
                levelStatus: Provider.of<LevelStatus>(context),
              ),
            ),
          )
              : showLevelCompletionNotice(context, '1'),
          child: Text('Level 2'),
        ),
        const SizedBox(height: 20.0),
        TextButton(
          onPressed: () => levelStatus.level2Completed
              ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Level3Screen(
                levelStatus: Provider.of<LevelStatus>(context),
              ),
            ),
          )
              : showLevelCompletionNotice(context, '2'),
          child: Text('Level 3'),
        ),
        const SizedBox(height: 20.0),
        TextButton(
          onPressed: () => levelStatus.level3Completed
              ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Level4Screen(
                levelStatus: Provider.of<LevelStatus>(context),
              ),
            ),
          )
              : showLevelCompletionNotice(context, '3'),
          child: Text('Level 4'),
        ),
      ],
    ),
    ),
      ],
      ),
      ),
    );
  }
}

class Level1Screen extends StatelessWidget {
  final LevelStatus levelStatus;

  const Level1Screen({Key? key, required this.levelStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 1'),
      ),
      body: Center(
        child: Text('You have accessed the Level 1 Window!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          levelStatus.markLevelCompleted(1);
          // Alternative: Provider.of<LevelStatus>(context, listen: false).level1Completed = true;
          // Notify listeners for UI update
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

class Level2Screen extends StatelessWidget {
  final LevelStatus levelStatus;

  const Level2Screen({Key? key, required this.levelStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 2'),
      ),
      body: Center(
        child: Text('You have accessed the Level 2 Window!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          levelStatus.markLevelCompleted(2);
          // Alternative: Provider.of<LevelStatus>(context, listen: false).level2Completed = true;
          // Notify listeners for UI update
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

class Level3Screen extends StatelessWidget {
  final LevelStatus levelStatus;

  const Level3Screen({Key? key, required this.levelStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 3'),
      ),
      body: Center(
        child: Text('You have accessed the Level 3 Window!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          levelStatus.markLevelCompleted(3);
          // Alternative: Provider.of<LevelStatus>(context, listen: false).level3Completed = true;
          // Notify listeners for UI update
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

class Level4Screen extends StatelessWidget {
  final LevelStatus levelStatus;

  const Level4Screen({Key? key, required this.levelStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 4'),
      ),
      body: Center(
        child: Text('You have accessed the Level 4 Window!'),
      ),
    );
  }
}
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      backgroundColor: Colors.yellow[600],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is the settings window!'),
            const SizedBox(height: 60.0),
            ElevatedButton(
              onPressed: () {
                // Reset all level completion flags using Provider
                Provider.of<LevelStatus>(context, listen: false)
                  ..level1Completed = false
                  ..level2Completed = false
                  ..level3Completed = false
                  ..level4Completed = false;
              },
              child: const Text('RESET'),
            ),
          ],
        ),
      ),
    );
  }
}

// Closing MaterialApp widget
