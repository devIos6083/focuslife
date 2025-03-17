// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:focus_life/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class MessengerChatScreen extends StatefulWidget {
  final String userName;
  final String userProfileImage;

  const MessengerChatScreen({
    super.key,
    required this.userName,
    this.userProfileImage = 'img/chat_bot.png',
  });

  @override
  State<MessengerChatScreen> createState() => _MessengerChatScreenState();
}

class _MessengerChatScreenState extends State<MessengerChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];
  bool _showAttachmentOptions = false;

  @override
  void initState() {
    super.initState();
    // 예시 메시지 추가
    _messages.addAll(
      [
        Message(
            text: "안녕하세요! 무엇을 도와드릴까요?",
            isMe: false,
            timestamp: DateTime.now().subtract(const Duration(minutes: 6))),
        Message(
            text: "오늘 출근 기록을 확인하고 싶어요.",
            isMe: true,
            timestamp: DateTime.now().subtract(const Duration(minutes: 5))),
        Message(
            text: "네, 오늘 출근 기록이 9시 30분에 확인되었습니다.",
            isMe: false,
            timestamp: DateTime.now().subtract(const Duration(minutes: 4))),
        Message(
            text: "혹시 근무 시간 계산도 해줄 수 있나요?",
            isMe: true,
            timestamp: DateTime.now().subtract(const Duration(minutes: 3))),
        Message(
            text: "네, 현재까지 총 근무 시간은 4시간 15분입니다. (점심시간 제외)",
            isMe: false,
            timestamp: DateTime.now().subtract(const Duration(minutes: 2))),
        Message(
            text: "오후 6시까지 근무하면 총 몇 시간인가요?",
            isMe: true,
            timestamp: DateTime.now().subtract(const Duration(minutes: 1))),
        Message(
            text: "예상 근무 시간은 8시간 30분입니다. 연장 근무 여부도 확인할까요?",
            isMe: false,
            timestamp: DateTime.now())
      ],
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(Message(
          text: _messageController.text,
          isMe: true,
          timestamp: DateTime.now(),
        ));
        _messageController.clear();
      });

      // 봇 응답 시뮬레이션
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _messages.add(Message(
            text: "네, 근무 시간은 현재 5시간 30분입니다.",
            isMe: false,
            timestamp: DateTime.now(),
          ));
        });
      });
    }
  }

  void _toggleAttachmentOptions() {
    setState(() {
      _showAttachmentOptions = !_showAttachmentOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(widget.userProfileImage),
          ),
        ),
        title: Text(
          widget.userName,
          style: GoogleFonts.sora(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call, color: Colors.blue, size: 28),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // 채팅 메시지 영역
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // 첨부 옵션 영역
          if (_showAttachmentOptions)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAttachmentOption(
                      Icons.camera_alt, "카메라", Colors.purple),
                  _buildAttachmentOption(
                      Icons.photo_library, "앨범", Colors.green),
                  _buildAttachmentOption(Icons.mic, "마이크", Colors.orange),
                ],
              ),
            ),

          // 메시지 입력 영역
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    _showAttachmentOptions ? Icons.close : Icons.chevron_right,
                    color: Colors.blue,
                  ),
                  onPressed: _toggleAttachmentOptions,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "메시지를 입력하세요...",
                      hintStyle: GoogleFonts.sora(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(
                    Icons.send_outlined,
                    color: Colors.blueAccent,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.thumb_up, color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      _messages.add(Message(
                        text: "👍",
                        isMe: true,
                        timestamp: DateTime.now(),
                      ));
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentOption(IconData icon, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 24,
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.sora(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isMe) ...[
            CircleAvatar(
              radius: 12,
              backgroundImage: const AssetImage('img/chat_bot.png'),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: message.isMe ? Colors.blue[400] : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: message.isMe
                      ? const Radius.circular(16)
                      : const Radius.circular(4),
                  bottomRight: message.isMe
                      ? const Radius.circular(4)
                      : const Radius.circular(16),
                ),
              ),
              child: Text(
                message.text,
                style: GoogleFonts.sora(
                  fontSize: 14,
                  color: message.isMe ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
