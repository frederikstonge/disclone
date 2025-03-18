import 'package:disclone/widgets/home/server_view.dart';
import 'package:disclone/widgets/home/channels/text_channel_view.dart';
import 'package:disclone/widgets/home/channels/voice_channel_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ServerLayoutView extends StatelessWidget {
  final int selectedServerId;
  final int selectedChannelId;
  final void Function(int channelId, bool isSplitScreen) setSelectedChannelId;

  const ServerLayoutView({
    super.key,
    required this.selectedServerId,
    required this.selectedChannelId,
    required this.setSelectedChannelId,
  });

  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).breakpoint.name == 'SHRINK') {
      return ServerView(
        key: ValueKey(selectedServerId),
        selectedChannelId: selectedChannelId,
        setSelectedChannelId:
            (channelId) => setSelectedChannelId(channelId, false),
      );
    }

    return Row(
      children: [
        SizedBox.fromSize(
          size: Size.fromWidth(160),
          child: ServerView(
            key: ValueKey(selectedServerId),
            selectedChannelId: selectedChannelId,
            setSelectedChannelId:
                (channelId) => setSelectedChannelId(channelId, true),
          ),
        ),
        if (selectedChannelId % 2 == 0) ...[
          Expanded(
            child: TextChannelView(
              key: ValueKey(selectedChannelId),
              serverId: selectedServerId,
              channelId: selectedChannelId,
              isSplitScreen: true,
            ),
          ),
        ] else ...[
          Expanded(
            child: VoiceChannelView(
              key: ValueKey(selectedChannelId),
              serverId: selectedServerId,
              channelId: selectedChannelId,
              isSplitScreen: true,
            ),
          ),
        ],
      ],
    );
  }
}
