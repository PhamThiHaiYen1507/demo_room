import 'dart:ui';

import 'package:demo_room/controller.dart';
import 'package:demo_room/model.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:get/get.dart';
import 'package:touchable/touchable.dart';

//import 'package:vector_graphics/vector_graphics.dart' ;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class TypeSeat {
  String type;
  Color color;
  TypeSeat(this.type, this.color);
}

List<TypeSeat> listType = [
  TypeSeat(type.selecting.toString(), Colors.blue),
  TypeSeat(type.empty.toString(), Colors.black.withOpacity(0.2)),
  TypeSeat(type.enable.toString(), Colors.red),
  TypeSeat(type.disable.toString(), Colors.red.withOpacity(0.5))
];

class _MyHomePageState extends State<MyHomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
        init: Controller(),
        builder: (c) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.yellow.withOpacity(0.5),
              title: const Text(
                'Phòng Hòa Nhạc Của Phạm Thị Hải Yến',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      color: Colors.red.withOpacity(0.3),
                      width: Get.width,
                      child: Obx(
                        () => Text(
                          'Bạn đang chọn: ${c.countSeatSelected.value.toString()} ghế',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      )),
                ),
                const SizedBox(height: 20),
                Expanded(
                  flex: 3,
                  child: Obx(
                    () {
                      final listData = c.listData.value;
                      final mapImage = c.mapImage.value;
                      return InteractiveViewer(
                        minScale: 0.1,
                        maxScale: 2,
                        child: LayoutBuilder(
                          builder: (_, box) => SizedBox(
                              height: box.maxHeight,
                              width: box.maxWidth,
                              child: CanvasTouchDetector(
                                builder: (contextPain) => CustomPaint(
                                  painter: _LinePainter(contextPain, listData,
                                      mapImage, c.selectedSeat),
                                ),
                              )),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.blue.withOpacity(0.4),
                    width: Get.width,
                    child: const Text(
                      'Sân khấu',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _LinePainter extends CustomPainter {
  BuildContext context;
  final Paint _paint;
  final List<Data> listData;
  final Map<String, Image> mapImage;
  final void Function({required DataSeat dataSeat})? selectSeat;

  _LinePainter(this.context, this.listData, this.mapImage, this.selectSeat)
      : _paint = Paint()
          ..color = Colors.black.withOpacity(0.1)
          ..style = PaintingStyle.fill;
  void loadAsset(Canvas canvas) async {}

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    TouchyCanvas myCanvas = TouchyCanvas(context, canvas);
    final Path path = Path();

    for (Data data in listData) {
      for (DataBlock dataBlock in data.listBlock) {
        final width = dataBlock.lenghtSeatRow * data.widthSeat;
        final height = dataBlock.lenghtRow * data.widthSeat +
            (dataBlock.lenghtRow - 1) * data.distanceRows;
        final Rect rect = Rect.fromLTWH(dataBlock.x.toDouble(),
            dataBlock.y.toDouble(), width.toDouble(), height.toDouble());

        drawRotated(
          canvas,
          Offset(
            dataBlock.x + (width / 2),
            dataBlock.y + (height / 2),
          ),
          dataBlock.radius.toDouble(),
          () {
            for (List<DataSeat> dataSeatList in dataBlock.listSeat) {
              for (DataSeat dataSeat in dataSeatList) {
                // Vẽ Khung Vuông

                // final paintSeat = Paint()
                //   ..color = listType
                //           .firstWhereOrNull((element) => element.type == j.type)
                //           ?.color ??
                //       Colors.red
                //   ..style = PaintingStyle.fill;
                // final Rect rectSeat = Rect.fromLTWH(
                //     x + (widthSeat * j.row).toDouble(),
                //     y + ((j.column) * (widthSeat + distanceRows)).toDouble(),
                //     widthSeat.toDouble(),
                //     widthSeat.toDouble());

                // canvas.drawRect(rectSeat, paintSeat);

                final paintSeatSvg = Paint();
                final Image? image = mapImage[dataSeat.type.toString()];
                if (image != null) {
                  myCanvas.drawImage(
                    image,
                    Offset(
                      dataBlock.x + (data.widthSeat * dataSeat.row).toDouble(),
                      dataBlock.y +
                          ((dataSeat.column) *
                                  (data.widthSeat + data.distanceRows))
                              .toDouble(),
                    ),
                    paintSeatSvg,
                    onTapDown: (tapDetail) {
                      if (Get.isSnackbarOpen) {
                        Get.back(closeOverlays: true);
                      }

                      selectSeat?.call(dataSeat: dataSeat);
                    },
                  );
                }
              }
            }

            canvas.drawRect(rect, _paint);
          },
        );
      }
    }
    path.close();

    canvas.drawPath(path, _paint);
  }

  void drawRotated(
    Canvas canvas,
    Offset center,
    double angle,
    VoidCallback drawFunction,
  ) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    canvas.translate(-center.dx, -center.dy);
    drawFunction();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
