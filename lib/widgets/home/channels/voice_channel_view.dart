import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class VoiceChannelView extends StatefulWidget {
  final int serverId;
  final int channelId;
  final bool isSplitScreen;
  const VoiceChannelView({
    super.key,
    required this.serverId,
    required this.channelId,
    this.isSplitScreen = false,
  });

  @override
  State<VoiceChannelView> createState() => _VoiceChannelViewState();
}

class _VoiceChannelViewState extends State<VoiceChannelView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

@override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    if (!widget.isSplitScreen &&
        ResponsiveBreakpoints.of(context).breakpoint.name != 'SHRINK') {
      if (mounted) {
        WidgetsBinding.instance.removeObserver(this);
        GoRouter.of(context).pop();
      }
    }

    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        automaticallyImplyLeading: !widget.isSplitScreen,
      ),
      body: Placeholder(),
    );
  }
}
