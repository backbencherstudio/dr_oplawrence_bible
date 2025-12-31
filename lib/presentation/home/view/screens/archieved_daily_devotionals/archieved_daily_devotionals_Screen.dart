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
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset('assets/icons/back_arrow.png', scale: 4),
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
                  'Leviticus 2:6',
                  'Thou shalt part it in pieces, and pour oil thereon: it is a meat offering.',
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.morningPrayerScreen);
                  },
                ),
                _buildDevotionCard(
                  context,
                  '25/11/2025',
                  'Deuteronomy 12:13',
                  'Take heed to thyself that thou offer not thy burnt offerings in every place that thou seest:',
                  onTap: () {Navigator.pushNamed(context, RouteNames.morningPrayerScreen);},
                ),
                _buildDevotionCard(
                  context,
                  '24/11/2025',
                  'Ezekiel 16:12',
                  'And I put a helya on thy forehead, and earrings in thine ears, and a beautiful crown upon thine head.',
                  onTap: () {Navigator.pushNamed(context, RouteNames.morningPrayerScreen);},
                ),
                _buildDevotionCard(
                  context,
                  '22/11/2025',
                  '2 Samuel 4:1',
                  'And when Saul’s son heard that Abner was dead in Hebron, his hands were feeble, and all the YisraELites were troubled.',
                  onTap: () {  Navigator.pushNamed(context, RouteNames.morningPrayerScreen);},
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/left_bird.svg'),
                    const SizedBox(width: 8),
                    Text(
                      'End of the List - YAHAWAH ELOHIYM Bless',
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
                  'Luke 6:2',
                  'And certain of the Pharisees said unto them, Why do ye that which is not lawful to do on the Sabbath days?',
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.gospelPsalmScreen);
                  },
                ),
                _buildDevotionCard(
                  context,
                  '25/11/2025',
                  'Yovel 28:11',
                  'And the YAHAWAH opened the womb of Leah, and she conceived and bare Ya’aqob a son, and he called his name Reuben, on the fourteenth day of the ninth month, in the first year of the third week.',
                  onTap: () {  Navigator.pushNamed(context, RouteNames.gospelPsalmScreen);},
                ), _buildDevotionCard(
                  context,
                  '26/11/2025',
                  'Philippians 4:1',
                  'Therefore, my brethren dearly beloved and longed for, my delight and crown, so stand fast in the YAHAWAH, my dearly beloved.',
                  onTap: () {  Navigator.pushNamed(context, RouteNames.gospelPsalmScreen);},
                ),
                _buildDevotionCard(
                  context,
                  '25/11/2025',
                  'Yehuda 1:6',
                  'And the angels which kept not their first estate, but left their own habitation, he hath reserved in everlasting chains under darkness unto the mishpat of the great day.',
                  onTap: () {  Navigator.pushNamed(context, RouteNames.gospelPsalmScreen);},
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/left_bird.svg'),
                    const SizedBox(width: 8),
                    Text(
                      'End of the List - YAHAWAH ELOHIYM Bless',
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
          // Text(
          //   date,
          //   style: const TextStyle(
          //     fontSize: 14,
          //     fontWeight: FontWeight.w400,
          //     color: Color(0xff4A4A4A),
          //   ),
          // ),
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
