import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_life/provider/chat_service.dart';

// 메시지 모델 클래스
class Message {
  final String text;
  final bool isMe;
  final DateTime timestamp;
  final List<Reference>? references;

  Message({
    required this.text,
    required this.isMe,
    required this.timestamp,
    this.references,
  });
}

// 채팅 상태 클래스
class ChatState {
  final List<Message> messages;
  final bool showAttachmentOptions;
  final bool isLoading;
  final String? error;

  ChatState({
    required this.messages,
    this.showAttachmentOptions = false,
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<Message>? messages,
    bool? showAttachmentOptions,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      showAttachmentOptions:
          showAttachmentOptions ?? this.showAttachmentOptions,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// 채팅 상태 관리 StateNotifier
class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(ChatState(messages: [])) {
    _loadInitialMessages();
  }

  // 초기 메시지 로드
  void _loadInitialMessages() {
    final initialMessages = [
      Message(
        text: "안녕하세요! KOSHA 가이드 챗봇입니다. 산업안전보건 관련 궁금하신 점을 물어보세요.",
        isMe: false,
        timestamp: DateTime.now(),
      ),
    ];

    state = state.copyWith(messages: initialMessages);
  }

  // 메시지 보내기 및 실제 API 호출
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // 사용자 메시지 추가
    final userMessage = Message(
      text: text,
      isMe: true,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      error: null,
    );

    try {
      // 실제 API 호출
      final response = await ChatService.sendMessage(text);

      // 봇 응답 메시지 생성
      final botMessage = Message(
        text: response.answer,
        isMe: false,
        timestamp: DateTime.now(),
        references: response.references,
      );

      state = state.copyWith(
        messages: [...state.messages, botMessage],
        isLoading: false,
      );
    } catch (e) {
      // 에러 처리
      final errorMessage = Message(
        text: "죄송합니다. 요청을 처리하는 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.",
        isMe: false,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, errorMessage],
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // 첨부 옵션 표시/숨김 토글
  void toggleAttachmentOptions() {
    state = state.copyWith(showAttachmentOptions: !state.showAttachmentOptions);
  }

  // 에러 상태 클리어
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// 채팅 Provider 정의
final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier();
});
