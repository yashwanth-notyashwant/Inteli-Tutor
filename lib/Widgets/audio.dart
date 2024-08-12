import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TTSWidget extends StatefulWidget {
  final String text;

  const TTSWidget({Key? key, required this.text}) : super(key: key);

  @override
  _TTSWidgetState createState() => _TTSWidgetState();
}

class _TTSWidgetState extends State<TTSWidget> {
  late FlutterTts _flutterTts;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();

    _flutterTts.setCompletionHandler(() {
      setState(() {
        _isPlaying = false;
      });
    });
  }

  Future<void> _toggleSpeak() async {
    if (_isPlaying) {
      await _flutterTts.stop();
    } else {
      await _flutterTts.setSpeechRate(0.5);  
      await _flutterTts.setPitch(0.9);
      await _flutterTts.speak(widget.text);
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      child: IconButton(
        icon: Icon(_isPlaying ? Icons.stop : Icons.record_voice_over_rounded),
        color: Color.fromARGB(255, 241, 239, 239),
        onPressed: _toggleSpeak,
      ),
    );
  }
}
