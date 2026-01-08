import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Modern Glassmorphism container widget with gradient support
class GlassContainer extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double blur;
  final Color? backgroundColor;
  final BoxBorder? border;
  final List<Color>? gradientColors;
  final bool enableShimmer;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.padding,
    this.margin,
    this.blur = 10,
    this.backgroundColor,
    this.border,
    this.gradientColors,
    this.enableShimmer = false,
  });

  @override
  State<GlassContainer> createState() => _GlassContainerState();
}

class _GlassContainerState extends State<GlassContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.enableShimmer) {
      _shimmerController = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      )..repeat();
      _shimmerAnimation = Tween<double>(begin: -1, end: 2).animate(
        CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOutSine),
      );
    }
  }

  @override
  void dispose() {
    if (widget.enableShimmer) {
      _shimmerController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBgColor = theme.colorScheme.surface.withOpacity(0.15);

    BoxDecoration decoration;
    
    if (widget.gradientColors != null) {
      decoration = BoxDecoration(
        gradient: LinearGradient(
          colors: widget.gradientColors!,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: widget.border ?? Border.all(color: Colors.white.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: widget.blur,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      );
    } else {
      decoration = BoxDecoration(
        color: widget.backgroundColor ?? defaultBgColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: widget.border ?? Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: widget.blur,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      );
    }

    return Container(
      margin: widget.margin ?? const EdgeInsets.all(0),
      padding: widget.padding,
      decoration: decoration,
      child: widget.enableShimmer
          ? AnimatedBuilder(
              animation: _shimmerAnimation,
              builder: (context, child) {
                return ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.white.withOpacity(0.3),
                        Colors.transparent,
                      ],
                      stops: [
                        _shimmerAnimation.value - 0.5,
                        _shimmerAnimation.value,
                        _shimmerAnimation.value + 0.5,
                      ].map((e) => (e + 1) / 3).toList(),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: child,
                );
              },
              child: widget.child,
            )
          : widget.child,
    );
  }
}

/// Glassmorphism card with animated hover effect
class GlassCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<Color>? gradientColors;

  const GlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius = 16,
    this.padding,
    this.margin,
    this.gradientColors,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shadowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _shadowAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTapDown: widget.onTap != null ? (_) => _controller.forward() : null,
      onTapUp: widget.onTap != null
          ? (_) {
              _controller.reverse();
              widget.onTap!();
            }
          : null,
      onTapCancel: widget.onTap != null ? () => _controller.reverse() : null,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              margin: widget.margin,
              padding: widget.padding,
              decoration: BoxDecoration(
                gradient: widget.gradientColors != null
                    ? LinearGradient(
                        colors: widget.gradientColors!,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                )
                    : LinearGradient(
                        colors: [
                          theme.colorScheme.surface.withOpacity(0.25),
                          theme.colorScheme.surface.withOpacity(0.15),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color: Colors.white.withOpacity(0.35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08 + _shadowAnimation.value * 0.12),
                    blurRadius: 12 + _shadowAnimation.value * 10,
                    spreadRadius: _shadowAnimation.value * 2,
                    offset: Offset(0, 6 + _shadowAnimation.value * 6),
                  ),
                ],
              ),
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

/// Frosted glass effect container
class FrostedGlass extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double opacity;
  final Color? tintColor;

  const FrostedGlass({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.padding,
    this.margin,
    this.opacity = 0.15,
    this.tintColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: (tintColor ?? theme.colorScheme.surface).withOpacity(opacity),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: child,
    );
  }
}

/// Gradient glass container with animated gradient
class AnimatedGradientGlass extends StatefulWidget {
  final List<List<Color>> gradientSets;
  final Widget child;
  final Duration duration;
  final double borderRadius;

  const AnimatedGradientGlass({
    super.key,
    required this.gradientSets,
    required this.child,
    this.duration = const Duration(seconds: 5),
    this.borderRadius = 20,
  });

  @override
  State<AnimatedGradientGlass> createState() => _AnimatedGradientGlassState();
}

class _AnimatedGradientGlassState extends State<AnimatedGradientGlass>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final int index = (_animation.value * (widget.gradientSets.length - 1)).toInt();
        return GlassContainer(
          borderRadius: widget.borderRadius,
          gradientColors: widget.gradientSets[index],
          child: child!,
        );
      },
      child: widget.child,
    );
  }
}

/// Liquid glass effect with wobble animation
class LiquidGlassCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double borderRadius;

  const LiquidGlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius = 24,
  });

  @override
  State<LiquidGlassCard> createState() => _LiquidGlassCardState();
}

class _LiquidGlassCardState extends State<LiquidGlassCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _distortionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _distortionAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.surface.withOpacity(0.4),
                  theme.colorScheme.surface.withOpacity(0.25),
                ],
                transform: GradientRotation(_distortionAnimation.value * 2 * math.pi),
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.4),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF764BA2).withOpacity(0.15),
                  blurRadius: 20,
                  spreadRadius: 5,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}

/// Gradient background widget
class GradientBackground extends StatelessWidget {
  final List<Color> colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final Widget child;

  const GradientBackground({
    super.key,
    required this.colors,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: begin,
          end: end,
        ),
      ),
      child: child,
    );
  }
}

/// Animated gradient background
class AnimatedGradientBackground extends StatefulWidget {
  final List<Color> colors;
  final Widget child;
  final Duration duration;

  AnimatedGradientBackground({
    super.key,
    required this.colors,
    required this.child,
    this.duration = const Duration(seconds: 10),
  });

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0 + _animation.value * 0.3,
                0.5 + _animation.value * 0.3,
                1,
              ],
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

