import 'package:flutter/material.dart';

class ServerView extends StatelessWidget {
  final int channelId;
  final void Function(int channelId) setChannelId;
  const ServerView({
    super.key,
    required this.channelId,
    required this.setChannelId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      body: ListView(
        children: [
          ExpansionPanelList(
            children: [
              ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder:
                    (context, isExpanded) =>
                        ListTile(title: Text('Text Channels', style: TextStyle(fontSize: 12))),
                body: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder:
                      (context, index) => ListTile(
                        leading: Icon(Icons.text_format),
                        title: Text('Text Channel $index', style: TextStyle(fontSize: 12)),
                        onTap: () => setChannelId(index),
                        selected: channelId == index,
                      ),
                ),
                isExpanded: true,
              ),
              ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder:
                    (context, isExpanded) =>
                        ListTile(title: Text('Voice Channels', style: TextStyle(fontSize: 12))),
                body: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder:
                      (context, index) => ListTile(
                        leading: Icon(Icons.speaker),
                        title: Text('Voice Channel $index', style: TextStyle(fontSize: 12)),
                        onTap: () => setChannelId(index),
                        selected: channelId == index,
                      ),
                ),
                isExpanded: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
