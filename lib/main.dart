import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

import 'midi_player_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.FINE;
  Logger.root.onRecord.listen((record) {
    print(
        '${record.time} ${record.level.name}: ${record.loggerName}: ${record.message}');
  });
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final logger = Logger('MyApp');

  @override
  Widget build(BuildContext context) {
    logger.info('build loglevel: ${Logger.root.level}');
    context.read(midiProvider).init();
    return MaterialApp(
      title: 'Midi Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  final logger = Logger('MyHomePage');

  void _playMidi(BuildContext context) {
    logger.fine('_playMidi');
    context.read(midiProvider).play(57);
  }

  @override
  Widget build(BuildContext context) {
    logger.fine('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Midi Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () => _playMidi(context),
              child: Text("Press to play a Midi sound"),
            ),
          ],
        ),
      ),
    );
  }
}
