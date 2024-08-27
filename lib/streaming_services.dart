import 'package:flutter/material.dart';
import 'package:sharepact_app/responsive_widgets.dart';
import 'package:sharepact_app/responsive_helpers.dart';
import 'package:sharepact_app/netflix_details.dart';
// Import other screens similarly

class StreamingServicesScreen extends StatelessWidget {
  const StreamingServicesScreen({super.key, this.id});
  final String? id;
  void _navigateToScreen(BuildContext context, String imagePath) {
    switch (imagePath) {
      case 'assets/netflix.png':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NetflixDetailsScreen()),
        );
        break;
      // case 'assets/primevideo.png':
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const PrimeVideoScreen()),
      //   );
      //   break;
      // // Add cases for other streaming services
      // default:
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const AvailableGroupsScreen()),
      //   );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Streaming Services',
          style: TextStyle(
            fontSize: responsiveWidth(context, 0.05),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ResponsiveContainer(
        child: Column(
          children: [
            SizedBox(height: responsiveHeight(context, 0.02)),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: responsiveWidth(context, 0.04),
                mainAxisSpacing: responsiveHeight(context, 0.02),
                children: [
                  'assets/netflix.png',
                  'assets/primevideo.png',
                  'assets/showmax.png',
                  'assets/hulu.png',
                  'assets/disney.png',
                  'assets/hbo.png',
                  'assets/paramount.png',
                ].map((imagePath) {
                  return GestureDetector(
                    onTap: () => _navigateToScreen(context, imagePath),
                    child: _buildBorderedResponsiveImage(context, imagePath),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBorderedResponsiveImage(BuildContext context, String imagePath) {
    return Container(
      width: responsiveWidth(context, 0.4),
      height: responsiveHeight(context, 0.25),
      padding: EdgeInsets.all(responsiveWidth(context, 0.08)),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffD1D4D7), width: 1.0),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(0.0),
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
        ),
      ),
      child: ResponsiveImage(
        imagePath: imagePath,
        heightFactor: 0.1,
        widthFactor: 0.1,
      ),
    );
  }
}
