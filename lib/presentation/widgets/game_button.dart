import 'package:flutter/material.dart';

class GameButton extends StatefulWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color color;
  final double width;
  final double height;
  final double fontSize;
  final Color? textColor;

  const GameButton({
    super.key,
    this.text,
    this.icon,
    required this.onPressed,
    this.color = const Color(0xFF4CAF50), // Default Green
    this.width = 200,
    this.height = 60,
    this.fontSize = 24,
    this.textColor,
  });

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // darker shade for border and 3D depth
    final Color darkerColor = HSLColor.fromColor(widget.color)
        .withLightness((HSLColor.fromColor(widget.color).lightness - 0.2).clamp(0.0, 1.0))
        .toColor();
        
    // lighter shade for gradient top
    final Color lighterColor = HSLColor.fromColor(widget.color)
        .withLightness((HSLColor.fromColor(widget.color).lightness + 0.1).clamp(0.0, 1.0))
        .toColor();

    final double depth = _isPressed ? 0 : 6.0;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: SizedBox(
        width: widget.width,
        height: widget.height + 6.0, // Add space for depth
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // 3D Depth Layer (Bottom shadow)
            Positioned(
              top: depth,
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  color: darkerColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
              ),
            ),
            // Visible Button Layer
            AnimatedPositioned(
              duration: const Duration(milliseconds: 50),
              top: _isPressed ? 6.0 : 0.0,
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: darkerColor,
                    width: 2,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [lighterColor, widget.color],
                  ),
                ),
                child: Stack(
                  children: [
                    // Glossy Highlight (Top Shine)
                    Positioned(
                      top: 4,
                      left: 10,
                      right: 10,
                      height: widget.height * 0.4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.6),
                              Colors.white.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Content (Icon and/or Text)
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.icon != null) ...[
                            Icon(
                              widget.icon,
                              color: widget.textColor ?? Colors.white,
                              size: widget.fontSize * 1.2,
                              shadows: [
                                Shadow(
                                  color: darkerColor,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            if (widget.text != null) const SizedBox(width: 8),
                          ],
                          if (widget.text != null)
                            Text(
                              widget.text!,
                              style: TextStyle(
                                color: widget.textColor ?? Colors.white,
                                fontSize: widget.fontSize,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: darkerColor,
                                    offset: const Offset(0, 2),
                                    blurRadius: 0,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
