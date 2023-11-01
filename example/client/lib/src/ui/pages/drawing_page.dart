// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:socket_example_2_client/src/managers/socket_manager.dart';
import 'package:socket_example_2_client/src/ui/page_controllers/drawing_page_controller.dart';

// Project imports:
import '../../utils/page_args.dart';
import '../complements/painter.dart';

class DrawingPage extends StatefulWidget {
  final PageArgs? args;
  const DrawingPage(this.args, {Key? key}) : super(key: key);

  @override
  DrawingPageState createState() => DrawingPageState();
}

class DrawingPageState extends StateMVC<DrawingPage> {
  late DrawingPageController _con;
  PageArgs? args;

  DrawingPageState() : super(DrawingPageController()) {
    _con = DrawingPageController.con;
  }

  @override
  void initState() {
    _con.initPage(arguments: widget.args);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Canvas"),
      ),
      body: Container(
        key: _con.key,
        color: Colors.grey[200],
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onPanDown: (details) {
            _con.addPointsForCurrentFrame(details.globalPosition);
          },
          onPanUpdate: (details) {
            _con.addPointsForCurrentFrame(details.globalPosition);
          },
          onPanEnd: (_) {
            _con.finishLine();
          },
          child: StreamBuilder<Offset?>(
            stream: SocketManager().recivedPaint(),
            builder: (BuildContext context, AsyncSnapshot<Offset?> snapshot) {
              return snapshot.data != null
                  ? CustomPaint(
                      painter: Painter(
                          offsets: _con.points..add(snapshot.data),
                          drawColor: Colors.red),
                    )
                  : CustomPaint(
                      painter:
                          Painter(offsets: _con.points, drawColor: Colors.red),
                    );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _con.clearCanvas,
        tooltip: 'Clear canvas',
        child: const Icon(Icons.delete),
      ),
    );
  }
}
