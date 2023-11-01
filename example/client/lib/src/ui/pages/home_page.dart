// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:socket_example_2_client/src/ui/components/button_component.dart';

// Project imports:
import '../../utils/page_args.dart';
import '../page_controllers/home_page_controller.dart';

class HomePage extends StatefulWidget {
  final PageArgs? args;
  const HomePage(this.args, {Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends StateMVC<HomePage> {
  late HomePageController _con;
  PageArgs? args;

  HomePageState() : super(HomePageController()) {
    _con = HomePageController.con;
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
            title: const Text("Web Sockets Ejemplo 2"),
          ),
          body: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ButtonComponent(
                    onPressed: () {
                      _con.onPressedMessage();
                    },
                    backgroundColor: Colors.blue,
                    text: "Mensajes con sockets",
                  ),
                  const SizedBox(height: 10),
                  ButtonComponent(
                    onPressed: () {
                      _con.onPressedDrawing();
                    },
                    backgroundColor: Colors.blue,
                    text: "Dibujo en sala con sockets",
                  )
                ],
              ),
            ),
          )),
    );
  }
}
