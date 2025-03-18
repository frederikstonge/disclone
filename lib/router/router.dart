import 'package:disclone/router/animationless_page.dart';
import 'package:disclone/router/routes.dart';
import 'package:disclone/widgets/account/account_view.dart';
import 'package:disclone/widgets/home/home_layout_view.dart';
import 'package:disclone/widgets/home/server/text_channel_view.dart';
import 'package:disclone/widgets/home/server/voice_channel_view.dart';
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
                final serverIdParameter =
                    state.uri.queryParameters['serverId'];
                final serverId =
                    serverIdParameter != null
                        ? int.tryParse(serverIdParameter)
                        : null;
                final channelIdParameter =
                    state.uri.queryParameters['channelId'];
                final channelId =
                    channelIdParameter != null
                        ? int.tryParse(channelIdParameter)
                        : null;
                return AnimationlessPage(
                  key: ValueKey(state.uri.toString()),
                  child: HomeLayoutView(
                    serverId: serverId,
                    channelId: channelId,
                  ),
                );
              },
              routes: [
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
