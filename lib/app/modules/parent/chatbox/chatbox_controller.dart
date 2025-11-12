import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/constants/pref_constants.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class ChatboxController extends GetxController {
  ApiClient apiClient = ApiClient();

  RxList<Map<String, String>> messages = <Map<String, String>>[].obs;
  RxList<Map<String, String>> connectedUsers = <Map<String, String>>[].obs;
  TextEditingController messageController = TextEditingController();
  FocusNode messageFocusNode = FocusNode();

  WebSocketChannel? channel;
  String serverUrl = ApiConstants.apiBaseUrlNew.replaceFirst('https', 'wss');
  // String serverUrl = ApiConstants.apiBaseUrlNew;
  late String currentUserId;
  late String recipientId;
  late String recipientName;
  RxString sessionId = ''.obs;

  RxBool isConnected = false.obs;
  Rx<RxStatus> isChatHistoryLoading = RxStatus.loading().obs;
  RxBool isMessageSending = false.obs;
  RxBool isLoadingConnectedUsers = false.obs;

  @override
  void onInit() {
    super.onInit();
    connectToWebSocket();
  }
void connectToWebSocket() {
  final token = GetStorage().read(PrefConstants.token) ?? '';
  try {
    // Create the WebSocket URL
    // final wsUrl = '$serverUrl';
    // print('Connecting to WebSocket server: $wsUrl');
    
    // Connect to WebSocket with cookie header
    channel = IOWebSocketChannel.connect(
      connectTimeout: Duration(seconds: 33000000),
      serverUrl,
      headers: {
        'Cookie': 'accessToken=$token'
      },
    );
    
    
    // Listen for messages from the server
    channel!.stream.listen(
      (dynamic message) {
        print('Received message: $message');
        
        try {
          final data = jsonDecode(message);
          handleWebSocketMessage(data);
        } catch (e) {
          print('Error parsing message: $e');
        }
      },
      onDone: () {
        print('WebSocket connection closed');
        isConnected.value = false;
      },
      onError: (error) {
        print('WebSocket error: $error');
        isConnected.value = false;
        // showCustomSnackBar("Connection error: $error");
      },
    );

    print('Connected to WebSocket server');
    isConnected.value = true;
    
  } catch (e) {
    print('WebSocket connection error: $e');
    // showCustomSnackBar("Failed to connect: $e");
  }
}

  void handleWebSocketMessage(Map<String, dynamic> data) {
    final type = data['type'];
    
    switch (type) {
      case 'connected':
        currentUserId = data['userId'];
        print('Authenticated as user: $currentUserId');
        break;
        
      case 'connected_users':
        final usersList = data['users'] as List;
        connectedUsers.value = usersList.map((user) => 
          Map<String, String>.from({
            '_id': user['_id'] ?? '',
            'name': user['name'] ?? '',
          })
        ).toList();
        isLoadingConnectedUsers.value = false;
        print('Connected users: ${connectedUsers.length}');
        break;
        
      case 'session_id':
        sessionId.value = data['sessionId'];
        print('Session ID received: ${sessionId.value}');
        // Load past chats once we have a session ID
        loadPastChats();
        break;
        
      case 'new_message':
        messages.insert(0, {
          'from': data['from'],
          'to': currentUserId,
          'message': data['message'],
        });
        messages.refresh();
        break;
        
      case 'message_sent':
        print('Message sent successfully: ${data['messageId']}');
        break;
        
      case 'error':
        print('Server error: ${data['message']}');
        // showCustomSnackBar(data['message']);
        break;
        
      default:
        print('Unknown message type: $type');
    }
  }

  // Load connected users
  void loadConnectedUsers() {
    if (!isConnected.value) {
      // showCustomSnackBar("Not connected to the server!");
      return;
    }
    print('Loading connected users...');
    isLoadingConnectedUsers.value = true;

    try {
      channel!.sink.add(jsonEncode({
        'type': 'getConnectedUsers'
      }));

      
    } catch (e) {
      print("Error loading connected users: $e");
      // showCustomSnackBar("Failed to load connected users!");
      isLoadingConnectedUsers.value = false;
    }
  }

  // Initialize chat with a recipient
  void startChatWithUser(String userId) {
    if (!isConnected.value) {
      // showCustomSnackBar("Not connected to the server!");
      return;
    }
    
    recipientId = userId;
    
    // Get session ID for these two users
    channel!.sink.add(jsonEncode({
      'type': 'connect',
      'toUser': recipientId,
    }));
  }

  // Load past chats using sessionId
  void loadPastChats() async {
  if (sessionId.value.isEmpty) {
    // showCustomSnackBar("Session ID is missing!");
    return;
  }

  isChatHistoryLoading.value = RxStatus.loading();

  try {
    final response = await apiClient.post(
      "/chat/getChatsBetweenTwoUsers",
      {"sessionId": sessionId.value},
      baseUrl: ApiConstants.apiBaseUrlNew,
      passToken: true,
    );

    if (response.statusCode == 200 && response.body['success'] == true) {
      final List<dynamic> chatData = response.body['data'] ?? [];
      messages.value = chatData.map((chat) {
        return {
          'from': chat['from'] as String,
          'to': chat['to'] as String,
          'message': chat['message'] as String,
          'timestamp': chat['timestamp'] as String,
        };
      }).toList().reversed.toList().cast<Map<String, String>>();

      isChatHistoryLoading.value = RxStatus.success();
    } else {
      // showCustomSnackBar(response.body['message'] ?? "Failed to load chats");
      isChatHistoryLoading.value = RxStatus.error();
    }
  } catch (e) {
    print("Error loading past chats: $e");
    // showCustomSnackBar("Something went wrong while loading chats!");
    isChatHistoryLoading.value = RxStatus.error();
  }
}

  // Send a chat message
  void sendMessage(String message) {
    if (message.trim().isEmpty || sessionId.value.isEmpty) return;

    isMessageSending.value = true;

    try {
      channel!.sink.add(jsonEncode({
        'type': 'chat_message',
        'toUser': recipientId,
        'message': message,
        'sessionId': sessionId.value,
      }));

      // Add message to list for immediate display
      // Note: We'll update this when we get confirmation from server
      messages.insert(0, {
        'from': currentUserId,
        'to': recipientId,
        'message': message,
      });

      messageController.text = '';
      messages.refresh();
    } catch (e) {
      print("Error sending message: $e");
      // showCustomSnackBar("Failed to send message!");
    } finally {
      isMessageSending.value = false;
    }
  }

  @override
  void onClose() {
    // Close WebSocket connection when the controller is destroyed
    channel?.sink.close();
    super.onClose();
  }
}