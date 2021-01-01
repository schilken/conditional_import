import 'midi_player_provider.dart';
import 'package:tonic/tonic.dart' as tonic;
import 'dart:js' as js;
import 'package:logging/logging.dart';

MidiPlayer getMidiPlayer() => MidiPlayerWeb();

class MidiPlayerWeb extends MidiPlayer {
  final logger = Logger('MidiPlayerWeb');
  Future<void> init() async {
    logger.fine('MidiPlayerWeb.init');
  }

  void play(int midi) {
    logger.fine('play midi $midi');
    String note = tonic.Pitch.fromMidiNumber(midi).toString();
    playNote(note);
  }

  @override
  void playNote(String note) {
    logger.fine('playNote $note');
    final fullNote = note.replaceAll('♭', 'b').replaceAll('♯', '#');
    js.context.callMethod("playNote", ["$fullNote", "8n"]);
  }
}
