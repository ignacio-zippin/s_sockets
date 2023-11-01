// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:socket_example_2_client/src/ui/page_controllers/message_page_controller.dart';

// Project imports:
import '../../utils/page_args.dart';

class MessagePage extends StatefulWidget {
  final PageArgs? args;
  const MessagePage(this.args, {Key? key}) : super(key: key);

  @override
  MessagePageState createState() => MessagePageState();
}

class MessagePageState extends StateMVC<MessagePage> {
  late MessagePageController _con;
  PageArgs? args;

  MessagePageState() : super(MessagePageController()) {
    _con = MessagePageController.con;
  }

  @override
  void initState() {
    _con.initPage(arguments: widget.args);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Mensajería",
              style: TextStyle(
                color: Colors.white,
              )),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                child: TextFormField(
                  controller: _con.controller,
                  decoration:
                      const InputDecoration(labelText: 'Enviar mensaje'),
                ),
              ),
              const SizedBox(height: 24),
              StreamBuilder(
                stream: _con.recivedMessage(),
                builder: (context, snapshot) {
                  return Text(snapshot.hasData ? '${snapshot.data}' : '');
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _con.sendMessage(),
          tooltip: 'Enviar mensaje',
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}
