import 'package:flutter/widgets.dart';

/// Envolve um `builder` que reage ao estado de hover do mouse (web/desktop).
///
/// Centraliza a logica de hover para botoes e cards, evitando repeticao.
class Hover extends StatefulWidget {
  final Widget Function(bool hovering) builder;
  final MouseCursor cursor;

  const Hover({
    super.key,
    required this.builder,
    this.cursor = SystemMouseCursors.click,
  });

  @override
  State<Hover> createState() => _HoverState();
}

class _HoverState extends State<Hover> {
  bool _hovering = false;

  void _set(bool value) {
    if (_hovering != value) setState(() => _hovering = value);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.cursor,
      onEnter: (_) => _set(true),
      onExit: (_) => _set(false),
      child: widget.builder(_hovering),
    );
  }
}
