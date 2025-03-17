import 'package:flutter/material.dart';

class ServerView extends StatelessWidget {
  final int selectedChannelId;
  final void Function(int channelId) setSelectedChannelId;
  const ServerView({super.key, required this.selectedChannelId, required this.setSelectedChannelId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      body: Column(),
    );
  }
}
