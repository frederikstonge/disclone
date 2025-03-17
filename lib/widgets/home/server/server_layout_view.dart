import 'package:disclone/router/routes.dart';
import 'package:disclone/widgets/home/server/server_view.dart';
import 'package:disclone/widgets/home/server/text_channel_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ServerLayoutView extends StatefulWidget {
  final int selectedServerId;
  final int? selectedChannelId;
  const ServerLayoutView({
    super.key,
    required this.selectedServerId,
    required this.selectedChannelId,
  });

  @override
  State<ServerLayoutView> createState() => _ServerLayoutViewState();
}

class _ServerLayoutViewState extends State<ServerLayoutView> {
  late int selectedChannelId;

  @override
  void initState() {
    selectedChannelId = widget.selectedChannelId ?? 0;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ServerLayoutView oldWidget) {
    if (widget.selectedChannelId != null) {
      selectedChannelId = widget.selectedChannelId!;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).breakpoint.name == 'SHRINK') {
      return ServerView(
        selectedChannelId: selectedChannelId,
        setSelectedChannelId:
            (channelId) => _setSelectedChannelId(channelId, false),
      );
    }

    return Row(
      children: [
        SizedBox.fromSize(
          size: Size.fromWidth(160),
          child: ServerView(
            selectedChannelId: selectedChannelId,
            setSelectedChannelId:
                (channelId) => _setSelectedChannelId(channelId, true),
          ),
        ),
        // OR VOICE CHANNEL VIEW
        Expanded(
          child: TextChannelView(
            serverId: widget.selectedServerId,
            channelId: selectedChannelId,
          ),
        ),
      ],
    );
  }

  void _setSelectedChannelId(int channelId, bool isSplitScreen) {
    if (isSplitScreen) {
      GoRouter.of(context).pushNamed(
        Routes.home,
        queryParameters: {
          'selectedServerId': '${widget.selectedServerId}',
          'selectedChannelId': '$channelId',
        },
      );
    } else {
      setState(() {
        selectedChannelId = channelId;
      });

      GoRouter.of(context).pushNamed(
        Routes.textChannel,
        pathParameters: {
          'serverId': '${widget.selectedServerId}',
          'channelId': '$channelId',
        },
      );
    }
  }
}
