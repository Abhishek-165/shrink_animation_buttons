import 'package:flutter/material.dart';

class ShrinkAnimationCard extends StatefulWidget {
  const ShrinkAnimationCard({
    this.color,
    this.elevation,
    super.key,
    this.onTap,
    this.clipBehavior,
    this.duration = const Duration(
      milliseconds: 400,
    ),
    this.lowerBound = 0.0,
    this.upperBound = 0.03,
    this.shadowColor,
    this.surfaceTintColor,
    this.borderOnForeground = true,
    this.semanticContainer = true,
    this.margin,
    required this.child,
    this.shape,
  });

  ///To overlay
  final double? elevation;
  //The value at which this animation is deemed to be dismissed.
  final double lowerBound;
  //The value at which this animation is deemed to be completed.
  final double upperBound;
  final Widget child;
  // Called when the widget is clicked
  final VoidCallback? onTap;
  final Clip? clipBehavior;
  final Color? color;
  //The length of time this animation should last.
  //If [reverseDuration] is specified, then [duration] is only used when going [forward]. Otherwise, it specifies the duration going in both directions.
  final Duration duration;
  final ShapeBorder? shape;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final bool borderOnForeground;
  final bool semanticContainer;
  final EdgeInsetsGeometry? margin;
  @override
  State createState() => _ShrinkAnimationCardState();
}

class _ShrinkAnimationCardState extends State<ShrinkAnimationCard>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;
  @override
  void initState() {
    ///initialise the animation controller for the shrink animation on the widget
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: widget.lowerBound,
      upperBound: widget.upperBound,
      // Calls the listener every time the value of the animation changes.
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // Called when this _controller object is removed from the tree permanently.
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return GestureDetector(
      // Reverse the state of the controller when the controller changes changed to forward or completed.
      onTapCancel: () {
        if (_controller?.status == AnimationStatus.forward ||
            _controller?.status == AnimationStatus.completed) {
          _tapUp(null);
        }
      },
      onTapDown: _tapDown,
      onTap: widget.onTap,
      onTapUp: _tapUp,

      ///[ScaleTransition], which animates changes in scale smoothly over a given duration.

      child: Transform.scale(
        scale: _scale,
        child: Card(
          key: widget.key,
          color: widget.color,
          shadowColor: widget.shadowColor,
          surfaceTintColor: widget.surfaceTintColor,
          elevation: widget.elevation,
          shape: widget.shape,
          borderOnForeground: widget.borderOnForeground,
          margin: widget.margin,
          clipBehavior: widget.clipBehavior,
          semanticContainer: widget.semanticContainer,
          child: widget.child,
        ),
      ),
    );
  }

//Starts running this animation forwards (towards the end).
  void _tapDown(TapDownDetails details) {
    _controller!.forward();
  }

  // Starts running this animation in reverse (towards the beginning).
  void _tapUp(TapUpDetails? tapUpDetails) {
    _controller!.reverse();
  }
}
