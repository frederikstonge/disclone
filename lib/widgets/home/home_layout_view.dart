import 'package:disclone/router/routes.dart';
import 'package:disclone/widgets/common/split_screen_layout_view.dart';
import 'package:disclone/widgets/home/chat/chat_view.dart';
import 'package:disclone/widgets/home/server/text_channel_view.dart';
import 'package:disclone/widgets/home/server/voice_channel_view.dart';
import 'package:disclone/widgets/home/home_server_list_view.dart';
import 'package:disclone/widgets/home/server/server_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeLayoutView extends StatelessWidget {
  final int? serverId;
  final int? channelId;

  const HomeLayoutView({
    super.key,
    required this.serverId,
    required this.channelId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox.fromSize(
          size: Size.fromWidth(60),
          child: HomeServerListView(
            serverId: serverId,
            setServerId:
                (serverId) => _setServerId(context, serverId),
          ),
        ),
        Expanded(
          child: SplitScreenLayoutView(
            builder:
                (context, isSplitScreen) =>
                    serverId != null
                        ? ServerView(
                          key: ValueKey(serverId),
                          channelId: channelId ?? 0,
                          setChannelId:
                              (channelId) => _setChannelId(
                                context,
                                channelId,
                                isSplitScreen,
                              ),
                        )
                        : ChatView(
                          channelId: channelId ?? 0,
                          setChannelId:
                              (channelId) => _setChannelId(
                                context,
                                channelId,
                                isSplitScreen,
                              ),
                        ),
            optionalBuilder:
                (context, isSplitScreen) =>
                    (channelId ?? 0) % 2 == 0
                        ? TextChannelView(
                          key: ValueKey(channelId),
                          serverId: serverId,
                          channelId: channelId ?? 0,
                          isSplitScreen: true,
                        )
                        : VoiceChannelView(
                          key: ValueKey(channelId),
                          serverId: serverId,
                          channelId: channelId ?? 0,
                          isSplitScreen: true,
                        ),
          ),
        ),
      ],
    );
  }

  void _setServerId(BuildContext context, int? serverId) {
    GoRouter.of(context).goNamed(
      Routes.home,
      queryParameters: {
        if (serverId != null) ...{'serverId': '$serverId'},
      },
    );
  }

  void _setChannelId(
    BuildContext context,
    int channelId,
    bool isSplitScreen,
  ) {
    if (isSplitScreen) {
      GoRouter.of(context).goNamed(
        Routes.home,
        queryParameters: {
          if (serverId != null) ...{'serverId': '$serverId'},
          'channelId': '$channelId',
        },
      );
    } else {
      if (channelId % 2 == 0) {
        GoRouter.of(context).goNamed(
          Routes.textChannel,
          pathParameters: {
            if (serverId != null) ...{'serverId': '$serverId'},
            'channelId': '$channelId',
          },
        );
      } else {
        GoRouter.of(context).goNamed(
          Routes.voiceChannel,
          pathParameters: {
            if (serverId != null) ...{'serverId': '$serverId'},
            'channelId': '$channelId',
          },
        );
      }
    }
  }
}
