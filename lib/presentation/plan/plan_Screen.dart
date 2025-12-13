import 'package:dr_oplawrence_bible/presentation/plan/screens/youtube_video_player_screen.dart';
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
      appBar: AppBar(  backgroundColor: const Color(0xffEBEBEB),
        leading:  Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset('assets/icons/video.svg',width: 15.w,height: 15.h,),
        ),
        title: Text(
          'Video',
          style: GoogleFonts.merriweather(
            fontSize: 18,
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
            SizedBox(height: 20.h,),

            _buildVideoCard(
              context,
              title: 'The Temptation of Jesus',
              episode: 'Epi 1',
              videoUrl: 'https://www.youtube.com/watch?v=MP0PpIle9wk&pp=ygUlSmVzdXPigJkgVGVtcHRhdGlvbiB2aWRlbyAgaW4gZW5nbGlzaA%3D%3D',
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
      height: 180.h,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
      ),
    );
  }
}