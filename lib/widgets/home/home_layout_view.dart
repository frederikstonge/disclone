import 'package:disclone/widgets/home/server/server_layout_view.dart';
import 'package:disclone/widgets/home/server_list/home_server_list_view.dart';
import 'package:flutter/material.dart';

class HomeLayoutView extends StatefulWidget {
  final int? selectedServerId;
  final int? selectedChannelId;

  const HomeLayoutView({
    super.key,
    required this.selectedServerId,
    required this.selectedChannelId,
  });

  @override
  State<HomeLayoutView> createState() => _HomeLayoutViewState();
}

class _HomeLayoutViewState extends State<HomeLayoutView> {
  int? selectedServerId;
  int? selectedChannelId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox.fromSize(
          size: Size.fromWidth(60),
          child: HomeServerListView(selectedServerId: widget.selectedServerId),
        ),
        Expanded(
          child:
              widget.selectedServerId != null
                  ? ServerLayoutView(
                    selectedServerId: widget.selectedServerId!,
                    selectedChannelId: widget.selectedChannelId,
                  )
                  : Placeholder(),
        ),
      ],
    );
  }
}
