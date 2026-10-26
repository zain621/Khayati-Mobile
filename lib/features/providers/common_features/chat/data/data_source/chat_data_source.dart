import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:app_mobile/constants/request_constants/request_constants_endpoints.dart';
import 'package:app_mobile/core/network/app_api.dart';
import '../request/create_conversation_request.dart';
import '../response/chat_offer_response.dart';
import '../response/conversations_response.dart';
import '../response/create_conversation_response.dart';
import '../response/messages_response.dart';
import '../response/send_message_response.dart';

abstract class ChatDataSource {
  Future<ConversationsResponse> getConversations();
  Future<CreateConversationResponse> createOrGetConversation(
      CreateConversationRequest request);
  Future<MessagesResponse> getMessages(String conversationId);
  Future<SendMessageResponse> sendMessage(
      String conversationId, String content, List<String> filePaths);
  Future<ChatOfferResponse> createChatOffer(
      String conversationId, Map<String, dynamic> body);
  Future<ChatOfferResponse> updateChatOffer(
      String conversationId, String offerId, Map<String, dynamic> body);
  Future<ChatOfferResponse> cancelChatOffer(
      String conversationId, String offerId);
}

class ChatDataSourceImplement implements ChatDataSource {
  final AppService _appService;
  final Dio _dio;

  ChatDataSourceImplement(this._appService, this._dio);

  @override
  Future<ConversationsResponse> getConversations() async {
    return await _appService.getConversations();
  }

  @override
  Future<CreateConversationResponse> createOrGetConversation(
      CreateConversationRequest request) async {
    return await _appService.createOrGetConversation(
      request.tailorId,
      request.userId,
    );
  }

  @override
  Future<MessagesResponse> getMessages(String conversationId) async {
    return await _appService.getMessages(conversationId);
  }

  @override
  Future<SendMessageResponse> sendMessage(
      String conversationId, String content, List<String> filePaths) async {
    final formData = FormData.fromMap({
      'conversationId': conversationId,
      if (content.isNotEmpty) 'content': content,
      if (filePaths.isNotEmpty)
        'attachments': [
          for (final path in filePaths)
            await MultipartFile.fromFile(
              path,
              filename: path.split('/').last.split('\\').last,
              contentType: _resolveMediaType(path),
            ),
        ],
    });
    final response = await _dio.post(
      RequestConstantsEndpoints.chatMessages,
      data: formData,
    );
    return SendMessageResponse.fromJson(
        response.data as Map<String, dynamic>);
  }

  @override
  Future<ChatOfferResponse> createChatOffer(
      String conversationId, Map<String, dynamic> body) async {
    return await _appService.createChatOffer(conversationId, body);
  }

  @override
  Future<ChatOfferResponse> updateChatOffer(
      String conversationId, String offerId, Map<String, dynamic> body) async {
    return await _appService.updateChatOffer(conversationId, offerId, body);
  }

  @override
  Future<ChatOfferResponse> cancelChatOffer(
      String conversationId, String offerId) async {
    return await _appService.cancelChatOffer(conversationId, offerId);
  }

  /// Resolves the MIME type from the file extension so the server accepts it.
  MediaType _resolveMediaType(String path) {
    final ext = path.split('.').last.toLowerCase();
    const map = {
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
      'gif': 'image/gif',
      'webp': 'image/webp',
      'heic': 'image/heic',
      'pdf': 'application/pdf',
      'doc': 'application/msword',
      'docx':
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'xls': 'application/vnd.ms-excel',
      'xlsx':
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'mp4': 'video/mp4',
      'mov': 'video/quicktime',
    };
    final mime = map[ext] ?? 'application/octet-stream';
    final parts = mime.split('/');
    return MediaType(parts[0], parts[1]);
  }
}
