import 'package:disclone/router/routes.dart';
import 'package:disclone/widgets/home/server_layout_view.dart';
import 'package:disclone/widgets/home/home_server_list_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeLayoutView extends StatelessWidget {
  final int? selectedServerId;
  final int? selectedChannelId;

  const HomeLayoutView({
    super.key,
    required this.selectedServerId,
    required this.selectedChannelId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox.fromSize(
          size: Size.fromWidth(60),
          child: HomeServerListView(
            selectedServerId: selectedServerId,
            setSelectedServerId:
                (serverId) => _setSelectedServerId(context, serverId),
          ),
        ),
        Expanded(
          child:
              selectedServerId != null
                  ? ServerLayoutView(
                    key: ValueKey(selectedServerId!),
                    selectedServerId: selectedServerId!,
                    selectedChannelId: selectedChannelId ?? 0,
                    setSelectedChannelId:
                        (channelId, isSplitScreen) => _setSelectedChannelId(
                          context,
                          channelId,
                          isSplitScreen,
                        ),
                  )
                  : Placeholder(),
        ),
      ],
    );
  }

  void _setSelectedServerId(BuildContext context, int? serverId) {
    GoRouter.of(context).goNamed(
      Routes.home,
      queryParameters: {
        if (serverId != null) ...{'serverId': '$serverId'},
      },
    );
  }

  void _setSelectedChannelId(
    BuildContext context,
    int channelId,
    bool isSplitScreen,
  ) {
    if (isSplitScreen) {
      GoRouter.of(context).goNamed(
        Routes.home,
        queryParameters: {
          if (selectedServerId != null) ...{'serverId': '$selectedServerId'},
          'channelId': '$channelId',
        },
      );
    } else {
      if (channelId % 2 == 0) {
        GoRouter.of(context).goNamed(
          Routes.textChannel,
          pathParameters: {
            if (selectedServerId != null) ...{'serverId': '$selectedServerId'},
            'channelId': '$channelId',
          },
        );
      } else {
        GoRouter.of(context).goNamed(
          Routes.voiceChannel,
          pathParameters: {
            if (selectedServerId != null) ...{'serverId': '$selectedServerId'},
            'channelId': '$channelId',
          },
        );
      }
    }
  }
}
