import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  // 플랫폼별 URL 설정
  static String get baseUrl {
    // iOS 시뮬레이터는 localhost 사용 가능
    return 'http://localhost:8001';

    // 실제 기기에서 테스트할 때는 Mac의 IP 주소 사용
    // return 'http://192.168.1.100:8001';  // 예시 - 실제 IP로 변경
  }

  static Future<ChatApiResponse> sendMessage(String query) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/chat'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'query': query,
        }),
      );

      if (response.statusCode == 200) {
        // UTF-8 디코딩 명시적으로 처리
        final decodedResponse = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> data = jsonDecode(decodedResponse);
        return ChatApiResponse.fromJson(data);
      } else {
        throw Exception('Failed to get response from server');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}

class ChatApiResponse {
  final String answer;
  final List<Reference> references;

  ChatApiResponse({
    required this.answer,
    required this.references,
  });

  factory ChatApiResponse.fromJson(Map<String, dynamic> json) {
    return ChatApiResponse(
      answer: json['answer'] ?? '',
      references: (json['references'] as List?)
              ?.map((ref) => Reference.fromJson(ref))
              .toList() ??
          [],
    );
  }
}

class Reference {
  final int id;
  final String content;
  final Map<String, dynamic> metadata;

  Reference({
    required this.id,
    required this.content,
    required this.metadata,
  });

  factory Reference.fromJson(Map<String, dynamic> json) {
    return Reference(
      id: json['id'] ?? 0,
      content: json['content'] ?? '',
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
    );
  }
}
