import 'package:flutter/material.dart';

class BasharImage extends StatefulWidget {
  final VoidCallback onTap;
  final bool isAngry;

  const BasharImage({
    Key? key,
    required this.onTap,
    required this.isAngry,
  }) : super(key: key);

  @override
  _BasharImageState createState() => _BasharImageState();
}

class _BasharImageState extends State<BasharImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Setup animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    
    // Setup scale animation
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticIn,
        reverseCurve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    // Play tap animation
    _controller.forward().then((_) => _controller.reverse());
    
    // Call the parent's onTap callback
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              child: SvgPicture.asset(
                'assets/bashar.svg',
                fit: BoxFit.contain,
              ),
            ),
            if (widget.isAngry)
              Container(
                width: 250,
                height: 250,
                child: SvgPicture.asset(
                  'assets/angry_effect.svg',
                  fit: BoxFit.contain,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
