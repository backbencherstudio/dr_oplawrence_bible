import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ArchievedDailyDevotionalsScreen extends StatelessWidget {
  const ArchievedDailyDevotionalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xffEBEBEB),
        appBar: AppBar(
          backgroundColor: const Color(0xffEBEBEB),
          elevation: 0,
          leading: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: TabBar(
              indicatorColor: const Color(0xffB02626),
              labelColor: const Color(0xffB02626),
              unselectedLabelColor: const Color(0xff4A4A4A),
              labelStyle: GoogleFonts.merriweather(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: GoogleFonts.merriweather(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: 'Devotions'),
                Tab(text: 'Gospels & Psalms'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // ---------- First Tab: Devotions ----------
            ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildDevotionCard(
                  context,
                  '26/11/2025',
                  'Philippians 1:21',
                  'For to me to live is HAMASHIACH, and to die is gain.',
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.morningPrayerScreen);
                  },
                ),
                _buildDevotionCard(
                  context,
                  '25/11/2025',
                  '1 Yohanan 1:9',
                  'He that saith he is in the Light, and hateth his brother, is in darkness even until now.',
                  onTap: () {Navigator.pushNamed(context, RouteNames.morningPrayerScreen);},
                ),
                _buildDevotionCard(
                  context,
                  '24/11/2025',
                  '1 Chronicles 1:26',
                  'And all the people, both small and great, and the captains of the armies, arose, an...',
                  onTap: () {Navigator.pushNamed(context, RouteNames.morningPrayerScreen);},
                ),
                _buildDevotionCard(
                  context,
                  '22/11/2025',
                  '1 Chronicles 2:29',
                  'And the sons of Ram the firstborn of Yerahmeel were, Maaz, and Yamin, and E...',
                  onTap: () {  Navigator.pushNamed(context, RouteNames.morningPrayerScreen);},
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/left_bird.svg'),
                    const SizedBox(width: 8),
                    Text(
                      'End of the List - God Bless',
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
              ],
            ),

            // ---------- Second Tab: Gospels & Psalms ----------
            ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildDevotionCard(
                  context,
                  '26/11/2025',
                  'Philippians 4:5',
                  'Let your moderation be known unto all men. The Lord is at hand.',
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.gospelPsalmScreen);
                  },
                ),
                _buildDevotionCard(
                  context,
                  '25/11/2025',
                  'John 16:33',
                  'I have told you these things, so that in me you may have peace. In this world you will have trouble.',
                  onTap: () {  Navigator.pushNamed(context, RouteNames.gospelPsalmScreen);},
                ), _buildDevotionCard(
                  context,
                  '26/11/2025',
                  'Philippians 4:5',
                  'Let your moderation be known unto all men. The Lord is at hand.',
                  onTap: () {  Navigator.pushNamed(context, RouteNames.gospelPsalmScreen);},
                ),
                _buildDevotionCard(
                  context,
                  '25/11/2025',
                  'John 16:33',
                  'I have told you these things, so that in me you may have peace. In this world you will have trouble.',
                  onTap: () {  Navigator.pushNamed(context, RouteNames.gospelPsalmScreen);},
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/left_bird.svg'),
                    const SizedBox(width: 8),
                    Text(
                      'End of the List - God Bless',
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDevotionCard(
      BuildContext context,
      String date,
      String scripture,
      String verseText, {
        required VoidCallback onTap,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff4A4A4A),
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: const Border(
                  left: BorderSide(
                    color: Color(0xffCDA434),
                    width: 5,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scripture,
                    style: GoogleFonts.merriweather(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    verseText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4A4A4A),
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
