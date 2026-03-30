import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PixelBossVideoPlayer extends StatefulWidget {
  const PixelBossVideoPlayer({super.key});

  @override
  State<PixelBossVideoPlayer> createState() => _PixelBossVideoPlayerState();
}

class _PixelBossVideoPlayerState extends State<PixelBossVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/boss_idle.mp4');

    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {
        _controller.setVolume(0.0); // 1. SES TAMAMEN KAPATILDI
        _controller.setPlaybackSpeed(0.5); // 2. YARI HIZDA OYNAT (Daha ağır ve korkutucu)
        _controller.setLooping(true);
        _controller.play();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // 3. VİDEOYU EKRANA YAY (Arka plan olması için)
          return SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator(color: Colors.redAccent));
        }
      },
    );
  }
}