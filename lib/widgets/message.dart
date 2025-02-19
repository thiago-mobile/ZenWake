import 'package:flutter/material.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget(
      {super.key, required this.text, required this.isFromUser});

  final String text;
  final bool isFromUser;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: Container(
          child: Column(
            children: [],
          ),
        ))
      ],
    );
  }
}
