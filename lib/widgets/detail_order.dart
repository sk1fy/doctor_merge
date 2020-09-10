import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/models/chat_message.dart';
import 'package:medical_app/models/data_providers.dart';
import 'package:medical_app/models/network.dart';
import 'package:medical_app/models/order.dart';
import 'package:medical_app/screens/doctor/avalible_order.dart';
import 'package:medical_app/utilities/constans.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class DetailOrderScreen extends StatefulWidget {
  final String orderId;
  final String type;
  DetailOrderScreen({this.orderId, this.type})
      : channel = IOWebSocketChannel.connect(
            'wss://medic.bw2api.ru/api/v1/order/chat/$orderId/$type');
  final WebSocketChannel channel;

  @override
  _DetailOrderScreenState createState() =>
      _DetailOrderScreenState(channel: channel);
}

Widget _buildMessageTo({String text, String toDate, bool user}) {
  var parsedDate = DateTime.parse(toDate);
  return Row(
    mainAxisAlignment:
        user == true ? MainAxisAlignment.end : MainAxisAlignment.start,
    //this will determine if the message should be displayed left or right
    children: [
      Flexible(
        //Wrapping the container with flexible widget
        child: Container(
            constraints: BoxConstraints(minWidth: 150, maxWidth: 300),
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(228, 239, 243, 1.0),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: user == true
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  //We only want to wrap the text message with flexible widget
                  child: Container(
                    child: Text(text),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    DateFormat(
                      'dd MMM yyyy  HH:mm',
                    ).format(parsedDate),
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
              ],
            )),
      )
    ],
  );
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {
  final WebSocketChannel channel;
  final _inputController = TextEditingController();
  List<Order> chatMessages = [];
  List ss = [];
  List messageList = [];
  ScrollController _controller;
  int render = 0;

  _DetailOrderScreenState({this.channel}) {
    channel.stream.listen((data) {
      setState(() {
        print(data);
        messageList.add({
          'text': data,
          'date': DateTime.now().toString(),
          'isUser': !Constants.prefs.getBool('type')
        });
        _controller.animateTo(
            1000000.0,
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 300),
          );
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    httpService.getChat(widget.orderId).then((chatFromServer) {
      setState(() {
        chatMessages = chatFromServer;
      });
      ss = chatMessages
          .map((e) => e.chat
              .map((c) => {'text': c.text, 'date': c.date, 'isUser': c.isUser})
              .toList())
          .toList()
          .expand((pair) => pair)
          .toList()
          .map((e) => e)
          .toList();
      messageList.addAll(ss);
      _controller =
          ScrollController(initialScrollOffset: 85.0 * messageList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru_RU', null);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Заказ " + widget.orderId.substring(0, 8)),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: ListView.builder(
                    controller: _controller,
                    itemCount: messageList.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Row(
                        mainAxisAlignment: messageList[i]['isUser'] == true
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        //this will determine if the message should be displayed left or right
                        children: [
                          Flexible(
                            //Wrapping the container with flexible widget
                            child: Container(
                                constraints: BoxConstraints(
                                    minWidth: 150, maxWidth: 300),
                                padding: EdgeInsets.all(8.0),
                                margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(228, 239, 243, 1.0),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      messageList[i]['isUser'] == true
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      //We only want to wrap the text message with flexible widget
                                      child: Container(
                                        child: Text(messageList[i]['text']),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Text(
                                        DateFormat(
                                                'dd MMM yyyy  HH:mm', 'ru_RU')
                                            .format(DateTime.parse(
                                                messageList[i]['date'])),
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                )),
                          )
                        ],
                      );
                    })
                // getMessageList(),
                ),
            Divider(
              color: Colors.black.withOpacity(0.3),
              height: 3,
              thickness: 1,
              endIndent: 0,
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: _inputController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        maxLength: 200,
                        decoration: InputDecoration.collapsed(
                            hintText: "Отправить сообщение"),
                        onChanged: (String text) => null,
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () => {
                              if (_inputController.text.isNotEmpty) {sendMsg()}
                            }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future sendMsg() async {
    final order = Provider.of<OrderProvider>(context, listen: false);
    final String input = _inputController.value.text;
    final bool isUser = Constants.prefs.getBool("type");
    var msg = ChatMessage(DateTime.now().toString(), input, isUser);
    var msgList =
        ChatMessage(DateTime.now().toString(), input, isUser).toJson();
    if (order.order.chat == null) {
      order.order.chat = [];
      order.order.chat.add(msg);
    }
    try {
      channel.sink.add(input);
      messageList.add(msgList);
      order.order.chat.add(msg);
      await AuthNetwork.of(context).sendMessage(widget.orderId, messageList);
      setState(() {
        render++;
        _controller.animateTo(
            1000000.0,
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 300),
          );
      });
    } catch (err) {
      print(err);
    }
    _inputController.text = '';
    ScrollController(initialScrollOffset: _controller.position.maxScrollExtent);
  }
}
