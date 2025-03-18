import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class TextChannelView extends StatefulWidget {
  final int serverId;
  final int channelId;
  final bool isSplitScreen;
  const TextChannelView({
    super.key,
    required this.serverId,
    required this.channelId,
    this.isSplitScreen = false,
  });

  @override
  State<TextChannelView> createState() => _TextChannelViewState();
}

class _TextChannelViewState extends State<TextChannelView> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

@override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    if (!widget.isSplitScreen &&
        ResponsiveBreakpoints.of(context).breakpoint.name != 'SHRINK') {
      if (mounted) {
        WidgetsBinding.instance.removeObserver(this);
        GoRouter.of(context).pop();
      }
    }

    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        automaticallyImplyLeading: !widget.isSplitScreen,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: 20,
              itemBuilder:
                  (context, index) => Align(
                    alignment:
                        index % 2 == 0
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Text $index'),
                      ),
                    ),
                  ),
            ),
          ),
          TextField(),
        ],
      ),
    );
  }
}
