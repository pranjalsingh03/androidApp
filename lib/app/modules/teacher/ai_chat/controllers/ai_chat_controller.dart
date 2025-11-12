import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/app/data/api/chat_api_client.dart';
import 'package:sheshya/app/data/model/ai_chat_model.dart';
import 'package:sheshya/app/data/model/body/ai_chat_req_model.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';

class AiChatController extends GetxController {
  ChatApiClient chatApiClient = ChatApiClient();

  List<AiChatModel> chatList = [];

  List<String> lastMessages = [];

  TextEditingController messageController = TextEditingController();
  FocusNode messageFocusNode = FocusNode();
  ScrollController scrollController = ScrollController();

  bool isLoading = false;

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void setMessageText(String text) {
    messageController.text = text;
    update();
  }

  void reset() {
    chatList = [];
    lastMessages = [];
    messageController.clear();
    isLoading = false;
    update();
  }

  void scrollToBottom() {
    try{
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      messageFocusNode.unfocus();
      update();
    }
    catch(e){

    }
  }

  void sendMessage({String msg = ""}) async {
    String message = msg.trim().isEmpty ? messageController.text.trim() : msg;
    if (message.isEmpty) return;
    isLoading = true;
    update();
    chatList.add(
      AiChatModel(
          message: message, createdAt: DateTime.now(), isCreatedByMe: true),
    );
    messageController.clear();
    scrollToBottom();
    // Get AI Response
    await getAiResponse(message: message);

    isLoading = false;
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    update();
  }

  List<String> getLastMessages() {
    List<String> temp = [];
    int count = 0;
    for (var message in lastMessages.reversed) {
      if (count == 5) break;
      temp.add(message);
      count++;
    }
    return lastMessages;
  }

  Future<void> getAiResponse({required String message}) async {
    AiChatReqModel body = AiChatReqModel(
      query: message,
      history: getLastMessages(),
    );

    final res =
        await chatApiClient.postData(ApiConstants.chatUri, body.toMap());
    if (res.statusCode == 200) {
      lastMessages.add(res.body.toString());
      chatList.add(
        AiChatModel(
          message: '''
${res.body}
''',
          createdAt: DateTime.now(),
          isCreatedByMe: false,
        ),
      );
    } else {
      showCustomSnackBar("Something went wrong! Please try again!");
    }
    update();
  }
}
