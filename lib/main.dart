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

  void _playMidi(BuildContext context) async {
    logger.fine('_playMidi');
    context.read(midiProvider).play(60);
    await Future.delayed(Duration(milliseconds: 200));
    context.read(midiProvider).play(64);
    await Future.delayed(Duration(milliseconds: 200));
    context.read(midiProvider).play(67);
  }

  void _playNotes(BuildContext context) async {
    logger.fine('_playNotes');
    context.read(midiProvider).playNote('E4');
    await Future.delayed(Duration(milliseconds: 200));
    context.read(midiProvider).playNote('G4');
    await Future.delayed(Duration(milliseconds: 200));
    context.read(midiProvider).playNote('C4');
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
              child: Text("Press to play C-Major up"),
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              onPressed: () => _playNotes(context),
              child: Text("Press to play C-Major down"),
            ),
          ],
        ),
      ),
    );
  }
}
