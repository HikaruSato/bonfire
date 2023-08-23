import 'dart:ui' as ui;

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import 'bar_life_controller.dart';

class BarLifeInterface extends InterfaceComponent
    with UseStateController<BarLifeController> {
  final double padding = 20;
  final double widthBar = 90;
  final double strokeWidth = 12;
  final ui.Image image;

  BarLifeInterface({
    required this.image,
  })
      : super(
          id: 1,
          position: Vector2(20, 20),
          spriteUnselected: Sprite.load('health_ui.png'),
          size: Vector2(120, 40),
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    try {
      // _init();
      _drawLife(canvas);
      _drawStamina(canvas);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // ui.Image? image;
  // Future<void> _init() async {
  //   rootBundle.load("assets/images/fire_icon.png").then((icon) {
  //     Uint8List lst = Uint8List.view(icon.buffer);
  //     ui.instantiateImageCodec(lst).then((codec) {
  //       codec.getNextFrame().then((frameInfo) {
  //         image = frameInfo.image;
  //         if (kDebugMode) {
  //           print("bkImage instantiated: $image");
  //         }
  //       });
  //     });
  //   });
    // properties ??= <String, dynamic>{};
    // final ui.Image? image = properties?['image'];
    // if (image != null) {
    //   return;
    // }
    //
    // try {
    //   final ByteData data = await rootBundle.load('assets/images/fire_icon.png');
    //   final image = await loadImage(Uint8List.view(data.buffer));
    //   if (properties?['image'] == null) {
    //     properties?['image'] = image;
    //   }
    // } catch(e) {
    //   if (kDebugMode) {
    //     print(e.toString());
    //   }
    // }
  // }

  // Future<ui.Image> loadImage(List<int> img) async {
  //   final Completer<ui.Image> completer = Completer();
  //   ui.decodeImageFromList(img as Uint8List, (ui.Image img) {
  //     return completer.complete(img);
  //   });
  //   return completer.future;
  // }

  void _drawLife(Canvas canvas) {
    double xBar = position.x + 26;
    double yBar = position.y + 10;
    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + widthBar, yBar),
        Paint()
          ..color = Colors.blueGrey[800]!
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);

    double currentBarLife = (controller.life * widthBar) / controller.maxLife;

    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + currentBarLife, yBar),
        Paint()
          ..color = _getColorLife(currentBarLife)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);

    final textPainter = TextPainter(
      text: const TextSpan(text: "ケイパビリティ"),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: 300,
    );

    textPainter.paint(canvas, Offset(xBar, yBar + 30));

    canvas.drawImage(image, Offset(xBar, yBar + 60), ui.Paint());
  }

  void _drawStamina(Canvas canvas) {
    double xBar = position.x + 26;
    double yBar = position.y + 28;

    double currentBarStamina =
        (controller.stamina * widthBar) / controller.maxStamina;

    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + currentBarStamina, yBar),
        Paint()
          ..color = Colors.yellow
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);
  }

  Color _getColorLife(double currentBarLife) {
    if (currentBarLife > widthBar - (widthBar / 3)) {
      return Colors.green;
    }
    if (currentBarLife > (widthBar / 3)) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}
