import 'package:flutter/material.dart';

class TextChannelView extends StatelessWidget {
  final int serverId;
  final int channelId;
  final bool isSplitScreen;
  const TextChannelView({super.key, required this.serverId, required this.channelId, this.isSplitScreen = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
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
                    child: Card(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Text $index'),
                    )),
                  ),
            ),
          ),
          TextField(),
        ],
      ),
    );
  }
}
