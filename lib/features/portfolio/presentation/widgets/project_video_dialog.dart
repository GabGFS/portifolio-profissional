import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Abre o video de um projeto numa camada sobreposta, sem sair da pagina.
Future<void> showProjectVideo(
  BuildContext context, {
  required String asset,
  required String title,
  required Color accent,
}) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.86),
    builder: (BuildContext _) =>
        ProjectVideoDialog(asset: asset, title: title, accent: accent),
  );
}

/// Player do video de um projeto: capa em tela cheia sobre a pagina, com
/// controles proprios (play/pause, barra de progresso, som e fechar).
class ProjectVideoDialog extends StatefulWidget {
  final String asset;
  final String title;
  final Color accent;

  const ProjectVideoDialog({
    super.key,
    required this.asset,
    required this.title,
    required this.accent,
  });

  @override
  State<ProjectVideoDialog> createState() => _ProjectVideoDialogState();
}

class _ProjectVideoDialogState extends State<ProjectVideoDialog> {
  late final VideoPlayerController _controller;
  bool _ready = false;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.asset);
    _load();
  }

  Future<void> _load() async {
    try {
      await _controller.initialize();
      if (!mounted) return;
      setState(() => _ready = true);
      await _controller.play();
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  void _toggleMute() {
    _controller.setVolume(_controller.value.volume > 0 ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    final Size stage = _stageSize(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(AppSizes.x24),
      child: SizedBox(
        width: stage.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _header(),
            const SizedBox(height: AppSizes.x12),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              child: ColoredBox(
                color: Colors.black,
                child: SizedBox(
                  width: stage.width,
                  height: stage.height,
                  child: _stage(),
                ),
              ),
            ),
            if (_ready) ...<Widget>[
              const SizedBox(height: AppSizes.x12),
              _controls(),
            ],
          ],
        ),
      ),
    );
  }

  /// Maior retangulo com a proporcao do video que cabe na janela — necessario
  /// porque videos verticais estourariam a altura se so a largura limitasse.
  Size _stageSize(BuildContext context) {
    final Size screen = MediaQuery.sizeOf(context);
    final double maxWidth = math.min(1080, screen.width - 96);
    final double maxHeight = screen.height - 260;
    final double ratio = _ready ? _controller.value.aspectRatio : 16 / 9;
    double width = maxWidth;
    double height = width / ratio;
    if (height > maxHeight) {
      height = maxHeight;
      width = height * ratio;
    }
    return Size(math.max(width, 240), math.max(height, 135));
  }

  Widget _header() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            widget.title,
            style: AppText.h3,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: AppSizes.x12),
        _IconAction(
          icon: FontAwesomeIcons.xmark,
          tooltip: 'action.close'.tr,
          accent: widget.accent,
          onTap: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _stage() {
    if (_failed) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.x24),
          child: Text(
            'action.videoError'.tr,
            textAlign: TextAlign.center,
            style: AppText.body,
          ),
        ),
      );
    }
    if (!_ready) {
      return Center(
        child: SizedBox(
          width: 34,
          height: 34,
          child:
              CircularProgressIndicator(color: widget.accent, strokeWidth: 2.5),
        ),
      );
    }
    return GestureDetector(
      onTap: _togglePlay,
      child: Center(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }

  Widget _controls() {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: _controller,
      builder: (BuildContext context, VideoPlayerValue value, Widget? _) {
        return Row(
          children: <Widget>[
            _IconAction(
              icon: value.isPlaying
                  ? FontAwesomeIcons.pause
                  : FontAwesomeIcons.play,
              tooltip: value.isPlaying ? 'action.pause'.tr : 'action.play'.tr,
              accent: widget.accent,
              onTap: _togglePlay,
            ),
            const SizedBox(width: AppSizes.x12),
            Text(
              '${_fmt(value.position)} / ${_fmt(value.duration)}',
              style: AppText.small,
            ),
            const SizedBox(width: AppSizes.x16),
            Expanded(
              child: VideoProgressIndicator(
                _controller,
                allowScrubbing: true,
                padding: const EdgeInsets.symmetric(vertical: AppSizes.x12),
                colors: VideoProgressColors(
                  playedColor: widget.accent,
                  bufferedColor: AppColors.border,
                  backgroundColor: AppColors.surface,
                ),
              ),
            ),
            const SizedBox(width: AppSizes.x16),
            _IconAction(
              icon: value.volume > 0
                  ? FontAwesomeIcons.volumeHigh
                  : FontAwesomeIcons.volumeXmark,
              tooltip: value.volume > 0 ? 'action.mute'.tr : 'action.unmute'.tr,
              accent: widget.accent,
              onTap: _toggleMute,
            ),
          ],
        );
      },
    );
  }

  String _fmt(Duration d) {
    final String m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final String s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}

/// Botao circular discreto usado nos controles do player.
class _IconAction extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color accent;
  final VoidCallback onTap;

  const _IconAction({
    required this.icon,
    required this.tooltip,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusPill),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: Center(child: FaIcon(icon, size: 15, color: accent)),
        ),
      ),
    );
  }
}
