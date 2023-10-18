import 'package:audioplayers/audioplayers.dart';

class GameAudioWidget {
  static final player = AudioPlayer();

  static Future playAudio(String value) async {
    await player
        .play(AssetSource("games/memory_games/memory_game_sounds/$value.mp3"));
  }
}
