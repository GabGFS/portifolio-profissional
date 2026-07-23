import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_sizes.dart';
import '../controllers/portfolio_controller.dart';

/// Revela o filho com fade + leve deslize quando ele entra na viewport.
///
/// Observa o [ScrollController] compartilhado do [PortfolioController] e dispara
/// a animacao uma unica vez, sem depender de pacotes externos.
class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final double offsetY;
  final Duration delay;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.offsetY = 30,
    this.delay = Duration.zero,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _revealed = false;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = Get.find<PortfolioController>().scrollController;
    _scrollController?.addListener(_check);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (_revealed || !mounted) return;
    final RenderObject? render = context.findRenderObject();
    if (render is! RenderBox || !render.attached) return;
    final double dy = render.localToGlobal(Offset.zero).dy;
    final double screenHeight = MediaQuery.sizeOf(context).height;
    if (dy < screenHeight * 0.9) {
      if (widget.delay == Duration.zero) {
        _reveal();
      } else {
        Future<void>.delayed(widget.delay, _reveal);
      }
    }
  }

  void _reveal() {
    if (!mounted || _revealed) return;
    setState(() => _revealed = true);
    _scrollController?.removeListener(_check);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_check);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: _revealed ? 1 : 0),
      duration: AppDurations.reveal,
      curve: Curves.easeOutCubic,
      builder: (BuildContext context, double t, Widget? child) {
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - t) * widget.offsetY),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
