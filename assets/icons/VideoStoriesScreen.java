import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoStoriesScreen extends StatelessWidget {
  const VideoStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEBEBEB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.video_library,
                      color: Color(0xFFC70039),
                      size: 24,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Video',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC70039),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              _buildVideoCard(
                context,
                title: 'Jesus Baptized',
                episode: 'Epi 1',
                videoUrl: 'https://www.youtube.com/watch?v=06YqTou5GV8',
              ),

              _buildVideoCard(
                context,
                title: 'Jesus\' Temptation',
                episode: 'Epi 2',
                videoUrl: 'https://www.youtube.com/watch?v=2RmTjEDK7iw',
              ),

              _buildVideoCard(
                context,
                title: 'Water Into Wine',
                episode: 'Epi 3',
                videoUrl: 'https://www.youtube.com/watch?v=Ry34CP_JCXE',
              ),

              _buildVideoCard(
                context,
                title: 'Nicodemus\'s Night Visit',
                episode: 'Epi 4',
                videoUrl: 'https://www.youtube.com/watch?v=2RmTjEDK7iw',
              ),

              const SizedBox(height: 20),
              _buildEndOfListMessage(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoCard(
      BuildContext context, {
        required String title,
        required String episode,
        required String videoUrl,
      }) {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl)!;
    final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => YoutubePlayerScreen(videoId: videoId),
                ),
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    thumbnailUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
                const Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                  size: 60,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            episode,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEndOfListMessage() {
    return SizedBox(
      height: 120.h,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/left_bird.svg'),
              const SizedBox(width: 8),
              Text(
                'More stories coming soon!\nYour feedback helps us improve.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset('assets/images/right_bird.svg'),
            ],
          ),
        ),
      ),
    );
  }
}

/// Separate screen to play YouTube video
class YoutubePlayerScreen extends StatefulWidget {
  final String videoId;
  const YoutubePlayerScreen({super.key, required this.videoId});

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true, // auto play video
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Video Player'),
          ),
          body: Center(child: player),
        );
      },
    );
  }
}
