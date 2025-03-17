import 'package:disclone/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeServerListView extends StatelessWidget {
  final int? selectedServerId;
  const HomeServerListView({super.key, required this.selectedServerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 2),
        itemCount: 20,
        separatorBuilder:
            (context, index) =>
                index == 0
                    ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(thickness: 1, height: 8),
                    )
                    : SizedBox.shrink(),
        itemBuilder:
            (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
              child: InkWell(
                onTap:
                    () => GoRouter.of(context).pushNamed(
                      Routes.home,
                      queryParameters: {'selectedServerId': index != 0 ? '$index' : null},
                    ),
                child: CircleAvatar(radius: 20, child: Text('$index')),
              ),
            ),
      ),
    );
  }
}
