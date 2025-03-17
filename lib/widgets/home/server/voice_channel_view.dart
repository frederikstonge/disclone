import 'package:flutter/material.dart';

class VoiceChannelView extends StatelessWidget {
  final int serverId;
  final int channelId;
  final bool isSplitScreen;
  const VoiceChannelView({super.key, required this.serverId, required this.channelId, this.isSplitScreen = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Placeholder(),
    );
  }
}
