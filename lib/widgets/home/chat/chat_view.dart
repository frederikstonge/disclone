import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  final int channelId;
  final void Function(int channelId) setChannelId;

  const ChatView({super.key, required this.channelId, required this.setChannelId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      body: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder:
                (context, index) => ListTile(
                  leading: Icon(Icons.account_box),
                  title: Text(
                    'User $index',
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () => setChannelId(index),
                  selected: channelId == index,
                ),
          ),
        ],
      ),
    );
  }
}
