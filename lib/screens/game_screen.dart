import 'package:flutter/material.dart';
import '../widgets/banner_ad_widget.dart';
import '../widgets/bashar_image.dart';
import '../services/ad_service.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _score = 0;
  int _clicks = 0;
  bool _isAngry = false;
  final AdService _adService = AdService();

  @override
  void initState() {
    super.initState();
    _adService.initialize();
  }

  void _hitBashar() {
    setState(() {
      _score += 10;
      _clicks++;
      
      // Display angry effect every 10 clicks
      _isAngry = _clicks % 10 == 0;
      
      // Show an ad every 20 clicks
      if (_clicks % 20 == 0) {
        _showRewardedAd();
      }
    });
  }

  void _showRewardedAd() {
    _adService.showRewardedAd(
      onComplete: (placementId) {
        // Reward player for watching the ad
        setState(() => _score += 50);
        _adService.loadRewardedAd(); // Reload for next time
      },
      onFailed: (placementId, error, message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل عرض الإعلان: $message')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اضرب بشار الأسد'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.attach_money),
            onPressed: _showRewardedAd,
            tooltip: 'شاهد إعلانًا لربح 50 نقطة',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'النقاط: $_score',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 30),
            BasharImage(
              onTap: _hitBashar,
              isAngry: _isAngry,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _showRewardedAd,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                'شاهد إعلانًا واربح 50 نقطة',
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BannerAdWidget(),
    );
  }
}
