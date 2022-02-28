class ChatMessage {
  String? messageUser;
  String? messageText;
  DateTime? messageTime;
  ChatMessage({this.messageUser,this.messageText,this.messageTime});

  String? get getMessageUser => messageUser;
  String? get getMessageText => messageText;
  DateTime? get getDateTime => messageTime;

  set setMessageUser(String messageUser){
    this.messageUser = messageUser;
  }

  set setMessageText(String messageText){
    this.messageText = messageText;
  }
  set setMessageTime(DateTime messageTime){
    this.messageTime = messageTime;
  }

}