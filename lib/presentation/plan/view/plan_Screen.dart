import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoStoriesScreen extends StatelessWidget {
  const VideoStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEBEBEB),
      appBar: AppBar(
        backgroundColor: const Color(0xffEBEBEB),
        leading: Padding(
          padding: EdgeInsets.all(12.0.w),
          child: SvgPicture.asset(
            'assets/icons/video.svg',
            width: 15.w,
            height: 15.h,
          ),
        ),
        title: Text(
          'Video',
          style: GoogleFonts.merriweather(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC70039),
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            _buildVideoCard(
              context,
              title: 'The Temptation of Jesus',
              episode: 'Epi 1',
              videoUrl:
                  'https://www.youtube.com/watch?v=MP0PpIle9wk&pp=ygUlSmVzdXPigJkgVGVtcHRhdGlvbiB2aWRlbyAgaW4gZW5nbGlzaA%3D%3D',
            ),

            _buildVideoCard(
              context,
              title: 'Lord Lead Me Today',
              episode: 'Epi 1',
              videoUrl: 'https://www.youtube.com/watch?v=06YqTou5GV8',
            ),

            _buildVideoCard(
              context,
              title: 'Start Your Day Right',
              episode: 'Epi 2',
              videoUrl: 'https://www.youtube.com/watch?v=2RmTjEDK7iw',
            ),

            _buildVideoCard(
              context,
              title: "Put Everything in GOD's Hand's",
              episode: 'Epi 3',
              videoUrl: 'https://www.youtube.com/watch?v=Ry34CP_JCXE',
            ),

            _buildVideoCard(
              context,
              title: 'Start Your Day Right',
              episode: 'Epi 4',
              videoUrl: 'https://www.youtube.com/watch?v=2RmTjEDK7iw',
            ),

            const SizedBox(height: 20),
            _buildEndOfListMessage(),
            const SizedBox(height: 20),
          ],
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
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    final thumbnailUrl = (videoId == null || videoId.isEmpty)
        ? null
        : 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildThumbnail(
            context,
            videoId: videoId,
            thumbnailUrl: thumbnailUrl,
          ),
          SizedBox(height: 8.h),
          _buildVideoTitle(title),
          _buildVideoEpisode(episode),
        ],
      ),
    );
  }

  Widget _buildThumbnail(
    BuildContext context, {
    required String? videoId,
    required String? thumbnailUrl,
  }) {
    if (thumbnailUrl == null || videoId == null) {
      // Invalid URL — don't attempt thumbnail / player with a forced `!`.
      return _buildThumbnailFallback(height: 200.h, iconSize: 60);
    }
    return GestureDetector(
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
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              thumbnailUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200.h,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  width: double.infinity,
                  height: 200.h,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                // 404 (deleted/private/invalid video id) or offline:
                // show a graceful placeholder instead of throwing
                // NetworkImageLoadException to the console.
                return _buildThumbnailFallback(height: 200.h, iconSize: 60);
              },
            ),
          ),
          const Icon(Icons.play_circle_fill, color: Colors.white, size: 60),
        ],
      ),
    );
  }

  Widget _buildVideoTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildVideoEpisode(String episode) {
    return Text(
      episode,
      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
    );
  }

  Widget _buildThumbnailFallback({
    required double height,
    double iconSize = 60,
  }) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(Icons.play_circle_fill, color: Colors.white, size: iconSize),
    );
  }

  Widget _buildEndOfListMessage() {
    return SizedBox(
      height: 180.h,
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/left_bird.svg'),
                SizedBox(width: 8.w),
                Text(
                  'More stories coming soon!\nYour feedback helps us improve.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 8.w),
                SvgPicture.asset('assets/images/right_bird.svg'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============= youtube video Screen ===============

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
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
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
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                'assets/icons/back_arrow.png',
                scale: 4,
                color: Colors.white,
              ),
            ),
            title: Text(
              'Video Player',
              style: GoogleFonts.merriweather(fontSize: 24.sp),
            ),
          ),
          body: Center(child: player),
        );
      },
    );
  }
}
