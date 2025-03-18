import 'package:disclone/router/animationless_page.dart';
import 'package:disclone/router/routes.dart';
import 'package:disclone/widgets/account/account_view.dart';
import 'package:disclone/widgets/home/chat/chat_view.dart';
import 'package:disclone/widgets/home/home_layout_view.dart';
import 'package:disclone/widgets/home/channels/text_channel_view.dart';
import 'package:disclone/widgets/home/channels/voice_channel_view.dart';
import 'package:disclone/widgets/shell/shell.dart';
import 'package:disclone/widgets/notifications/notifications_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: Routes.homeRoute,
  navigatorKey: rootNavigatorKey,
  redirect: (context, state) {
    // Validate the user is authenticated
    return null;
  },
  routes: [
    StatefulShellRoute.indexedStack(
      builder:
          (context, state, navigationShell) =>
              Shell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          initialLocation: Routes.homeRoute,
          routes: [
            GoRoute(
              name: Routes.home,
              path: Routes.homeRoute,
              pageBuilder: (context, state) {
                final selectedServerIdParameter =
                    state.uri.queryParameters['serverId'];
                final selectedServerId =
                    selectedServerIdParameter != null
                        ? int.tryParse(selectedServerIdParameter)
                        : null;
                final selectedChannelIdParameter =
                    state.uri.queryParameters['channelId'];
                final selectedChannelId =
                    selectedChannelIdParameter != null
                        ? int.tryParse(selectedChannelIdParameter)
                        : null;
                return AnimationlessPage(
                  key: ValueKey(state.uri.toString()),
                  child: HomeLayoutView(
                    selectedServerId: selectedServerId,
                    selectedChannelId: selectedChannelId,
                  ),
                );
              },
              routes: [
                GoRoute(
                  name: Routes.chat,
                  path: Routes.chatRoute,
                  builder: (context, state) {
                    final chatId =
                        int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
                    return ChatView(key: state.pageKey, chatId: chatId);
                  },
                ),
                GoRoute(
                  name: Routes.textChannel,
                  path: Routes.textChannelRoute,
                  builder: (context, state) {
                    final serverId = int.parse(
                      state.pathParameters['serverId']!,
                    );
                    final channelId = int.parse(
                      state.pathParameters['channelId']!,
                    );
                    return TextChannelView(
                      key: state.pageKey,
                      serverId: serverId,
                      channelId: channelId,
                      isSplitScreen: false,
                    );
                  },
                ),
                GoRoute(
                  name: Routes.voiceChannel,
                  path: Routes.voiceChannelRoute,
                  builder: (context, state) {
                    final serverId = int.parse(
                      state.pathParameters['serverId']!,
                    );
                    final channelId = int.parse(
                      state.pathParameters['channelId']!,
                    );
                    return VoiceChannelView(
                      key: state.pageKey,
                      serverId: serverId,
                      channelId: channelId,
                      isSplitScreen: false,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.notificationsRoute,
          routes: [
            GoRoute(
              name: Routes.notifications,
              path: Routes.notificationsRoute,
              builder:
                  (context, state) => NotificationsView(key: state.pageKey),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.accountRoute,
          routes: [
            GoRoute(
              name: Routes.account,
              path: Routes.accountRoute,
              builder: (context, state) => AccountView(key: state.pageKey),
            ),
          ],
        ),
      ],
    ),
  ],
);
