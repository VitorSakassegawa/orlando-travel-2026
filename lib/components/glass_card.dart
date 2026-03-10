import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Color? color;
  final double blur;
  final double borderRadius;
  final Border? border;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.color,
    this.blur = 20.0,
    this.borderRadius = 20.0,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black.withOpacity(0.3) 
                : Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  (color ?? (isDark ? Colors.white : Colors.white))
                      .withOpacity(isDark ? 0.1 : 0.8),
                  (color ?? (isDark ? Colors.white : Colors.white))
                      .withOpacity(isDark ? 0.05 : 0.5),
                ],
              ),
              borderRadius: BorderRadius.circular(borderRadius),
              border: border ?? Border.all(
                color: isDark 
                    ? Colors.white.withOpacity(0.1) 
                    : Colors.white.withOpacity(0.5),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
