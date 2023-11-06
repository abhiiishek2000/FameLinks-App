import 'dart:io';
import 'dart:typed_data';

import 'package:famelink/ui/filter/models/face_filters.dart';
import 'package:famelink/ui/filter/models/vignette.dart';
import 'package:famelink/ui/filter/utils/filter_matrix.dart';
import 'package:famelink/ui/filter/utils/save_image.dart';
import 'package:famelink/ui/filter/widgets/dialog.dart';
import 'package:famelink/ui/filter/widgets/paint_image.dart';
import 'package:famelink/ui/filter/widgets/save_to_gallery_alert_dialog.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;


enum Filter {
  noFilter,
  brightness,
  saturation,
  contrast,
  hue,
  highlight,
  temperature,
}
enum Screens { edit, sharpness, vignette, filter, beauty }

class FilterImage extends StatefulWidget {
  // final File file;
  final List<File>? files;

  const FilterImage({Key? key, @required this.files}) : super(key: key);

  @override
  _FilterImageState createState() => _FilterImageState();
}

class _FilterImageState extends State<FilterImage> {
  final List<img.Image> tinyImages = [];
  List<ui.Image> uiImages = [];
  final List<img.Image> originalImages = [];
  int currentImage = 0;
  double eyesOpacity = 0.05;
  int skinToneLevel = 0;

  // late ui.Image tinyUiImage;
  double brightness = 1,
      saturation = 1,
      contrast = 1,
      hue = 0,
      highlight = 1,
      temperature = 1,
      sharpen = 0;
  List<Color> skinColors = [
    const Color(0XFFF6E8B1),
    const Color(0XFFffe2c6),
    const Color(0XFFffd7ae),
    const Color(0XFFdfc4a8),
    const Color(0XFFfde7d6),
    const Color(0XFFecbcb4),
    const Color(0XFFd1a3a4),
    const Color(0XFFF8F0C6),
    const Color(0XFFFFFDD1),
    const Color(0XFFFFFEF2),
    const Color(0XFFF0DDD7),
    const Color(0XFFFEF9F3),
    const Color(0xFFFFCEB4),
    const Color(0xFFD2A18C),
    const Color(0XFFc58c85),
  ];

  List<Color> eyesColors = [
    const Color(0xFF000000),
    const Color(0xFF634e34),
    const Color(0xFF38101c),
    const Color(0xFF0D5176),
  ];

  double filterOpacity = 1;
  Filter _currentFilter = Filter.noFilter;
  int _faceFilterIndex = 0;
  ValueNotifier currentPresetFilter =
      ValueNotifier(FiltersMatrix.filtersList.keys.first);
  Screens currentScreen = Screens.edit;
  List<List<Face>> facesList = [];
  PageController pageController = PageController();

  final GlobalKey _repaintBoundaryKey = GlobalKey();

  bool isLoading = true;
  Vignette vignette = Vignette(vignetteType: VignetteType.none, amount: 0);

  int _currentSkinColorIndex = 3;

  _loadImage() async {
    for (var file in widget.files!) {
      Uint8List imageBytes = await file.readAsBytes();
      img.Image? decodedImage = img.decodeImage(
        imageBytes,
      );
      originalImages.add(decodedImage!);
      final tinyImage = img.copyResize(decodedImage, height: 200);
      tinyImages.add(tinyImage);
      final uiImage = await decodeImageFromList(imageBytes);
      uiImages.add(uiImage);
      await _recognizeFacesInImage(file);
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> addSharpness(int length) async {
    showLoading(context, "Processing Image...");

    debugPrint("Processing Image");
    for (int i = 0; i < length; i++) {
      print("Out put : $i");

      Uint8List imageBytes = widget.files![i].readAsBytesSync();
      double value = sharpen;

      img.Image? image = await compute(img.decodeImage, imageBytes.toList());
      image = img.convolution(
          image!, [0, -value, 0, -value, value * 4 + 1, -value, 0, -value, 0]);
      imageBytes = Uint8List.fromList(await compute(img.encodeJpg, image));
      DateTime.now().microsecondsSinceEpoch.toString();
      final uiImage = await decodeImageFromList(imageBytes);
      uiImages[i] = uiImage;
    }
    Navigator.pop(context);
    setState(() {});
  }

  // changeSkinTone() async {
  //   showLoading(context, "Processing Image");
  //   for (int i = 0; i < originalImages.length; i++) {
  //     Uint8List originalImageBytes = await widget.files[i].readAsBytes();
  //
  //   }
  // }
  //
  // addSharpness() async {
  //   print("Creating mask");
  //   image = img.decodeImage(maskedImage.toList())!;
  //   double value = 1;
  //   image = img.convolution(
  //       image, [0, -value, 0, -value, value * 4 + 1, -value, 0, -value, 0]);
  //   maskedImage = Uint8List.fromList(img.encodeJpg(image));
  //   return maskedImage;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadImage();
  }

  double _getFilterValue() {
    switch (_currentFilter) {
      case Filter.brightness:
        return brightness;
      case Filter.hue:
        return hue;
      case Filter.saturation:
        return saturation;
      case Filter.contrast:
        return contrast;
      case Filter.highlight:
        return highlight;
      case Filter.temperature:
        return temperature;
      case Filter.noFilter:
        // TODO: Handle this case.
        return -1;
    }
  }

  double _getBorderWidth(Filter filter) {
    return filter == _currentFilter ? 2 : 0;
  }

  Future<void> _assignFilterValue(double value) async {
    switch (_currentFilter) {
      case Filter.noFilter:
        return;
      case Filter.brightness:
        brightness = value;
        return;
      case Filter.hue:
        hue = value;
        return;
      case Filter.saturation:
        saturation = value;
        return;
      case Filter.contrast:
        contrast = value;
        return;
      case Filter.highlight:
        highlight = value;
        return;
      case Filter.temperature:
        temperature = value;
        return;
    }
  }

  Widget _getEditIcon(IconData icon, String title, Filter filter) {
    print("title $title");
    return InkWell(
      onTap: () {
        if (filter == Filter.noFilter) {
          brightness = 1;
          saturation = 1;
          contrast = 1;
          hue = 0;
          highlight = 1;
          temperature = 1;
          sharpen = 1;
        }
        setState(() {
          _currentFilter = filter;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: lightRed, width: _getBorderWidth(filter)),
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                icon,
                size: 20,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  Widget _getVignetteIcon(
      IconData icon, String title, VignetteType vignetteType) {
    print("title $title");
    return InkWell(
      onTap: () {
        setState(() {
          vignette.vignetteType = vignetteType;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: lightRed,
                      width: vignette.vignetteType == vignetteType ? 2 : 0),
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                icon,
                size: 20,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  Widget _getSharpnessIcon(int level) {
    return InkWell(
      onTap: () async {
        sharpen = level.toDouble();

        addSharpness(widget.files!.length);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: lightRed, width: sharpen == level ? 2 : 0),
                  borderRadius: BorderRadius.circular(5)),
              child: const Icon(
                Icons.pages,
                size: 20,
              ),
            ),
            Text(
              level.toString(),
              style: const TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _getFilters() {
    List<Widget> filtersList = [];

    for (var filterName in FiltersMatrix.filtersList.keys) {
      filtersList.add(InkWell(
        onTap: () {
          currentPresetFilter.value = filterName;
          filterOpacity = 1;
        },
        child: Container(
          margin: const EdgeInsets.all(5.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ColorFiltered(
              colorFilter:
                  ColorFilter.matrix(FiltersMatrix.filtersList[filterName]!),
              child: Image.memory(
                Uint8List.fromList(img.encodeJpg(tinyImages[currentImage])),
                fit: BoxFit.cover,
                width: 100,
              ),
            ),
          ),
        ),
      ));
    }
    return filtersList;
  }

  Future<void> _recognizeFacesInImage(File file) async {
    GoogleVisionImage googleVisionImage = GoogleVisionImage.fromFile(file);
    FaceDetector faceDetector = GoogleVision.instance.faceDetector(
        const FaceDetectorOptions(
            mode: FaceDetectorMode.accurate,
            enableContours: true,
            enableLandmarks: true,
            enableClassification: false));

    final faces = await faceDetector.processImage(googleVisionImage);
    facesList.add(faces);
  }

  // List<Widget> _getFacePresetBeauties() {
  //   List<Widget> presetBeautyList = [];
  //
  //   for (var filter in FaceBeautyList.faceBeautyList) {
  //     presetBeautyList.add(InkWell(
  //       onTap: () {
  //         setState(() {
  //           _faceFilter = filter;
  //           print(
  //               "changing face filter : ${FaceBeautyList.faceBeautyList.indexOf(filter)}");
  //         });
  //       },
  //       child: Container(
  //         width: 100,
  //         height: 100,
  //         margin: const EdgeInsets.all(5.0),
  //         child: Padding(
  //           padding: const EdgeInsets.all(3.0),
  //           child: CustomPaint(
  //             size: Size(100, 100),
  //             painter: PaintImage(
  //                 image: tinyUiImage,
  //                 faces: faces,
  //                 faceFilter: filter,
  //                 vignette: vignette),
  //           ),
  //         ),
  //       ),
  //     ));
  //   }
  //   return presetBeautyList;
  // }

  List<Widget> _getEditControls() {
    return [
      _getEditIcon(Icons.restore, "Reset", Filter.noFilter),
      _getEditIcon(Icons.wb_sunny_outlined, "Brightness", Filter.brightness),
      _getEditIcon(Icons.album_outlined, "Saturation", Filter.saturation),
      _getEditIcon(
          Icons.wb_incandescent_outlined, "Temperature", Filter.temperature),
      _getEditIcon(Icons.api, "Hue", Filter.hue),
      _getEditIcon(Icons.brightness_5_rounded, "Contrast", Filter.contrast),
      // _getEditIcon(Icons.wb_iridescent_outlined, "Sharpen", Filter.sharpen),
    ];
  }

  List<Widget> _getVignetteControls() {
    return [
      _getVignetteIcon(Icons.restore, "Reset", VignetteType.none),
      _getVignetteIcon(
          Icons.radio_button_checked, "Radial", VignetteType.radial),
      _getVignetteIcon(
          Icons.switch_left_outlined, "Left-Right", VignetteType.leftAndRight),
      _getVignetteIcon(
          Icons.wifi_protected_setup, "Up-Down", VignetteType.topAndBottom),
    ];
  }

  List<Widget> _getSharpnessControllers() {
    List<Widget> list = [];

    for (int i = 0; i <= 5; i++) {
      list.add(_getSharpnessIcon(i));
    }
    return list;
  }

  List<Widget> _getCurrentScreensList() {
    switch (currentScreen) {
      case Screens.edit:
        return _getEditControls();
      case Screens.filter:
        return _getFilters();
      case Screens.beauty:
        return [];
      case Screens.vignette:
        return _getVignetteControls();
      case Screens.sharpness:
        return _getSharpnessControllers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightRed,
        actions: [
          IconButton(
              onPressed: ()async {
                // showSaveToGalleryAlert(context, _repaintBoundaryKey,
                //     pageController, tinyImages.length);
                var result = await showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title:
                        Text('Save Image${tinyImages.length != 1 ? 's' : ''}'),
                        content: Text(
                            "Are you sure you want to save this image${tinyImages.length != 1 ? 's' : ''}?"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: lightRed, letterSpacing: 1.5),
                            ),
                            onPressed: () {
                              Navigator.pop(context,false);
                            },
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: lightRed),
                            child: const Text(
                              "Yes",
                              style: TextStyle(color: Colors.white, letterSpacing: 1.5),
                            ),
                            onPressed: () async {
                              Navigator.pop(context,true);
                            },
                          ),
                        ],
                      );
                    });
                if(result != null && result == true){
                  SaveImage.saveImage(context,_repaintBoundaryKey,pageController,tinyImages.length).then((value) {
                    if(value != null) {
                      Navigator.pop(context, value);
                    }
                  });
                }
              },
              icon: const Icon(
                Icons.done,
                size: 26,
              ))
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: InteractiveViewer(
                    child: RepaintBoundary(
                      key: _repaintBoundaryKey,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.matrix(
                            FiltersMatrix.temperature(temperature - 1)),
                        child: ColorFiltered(
                            colorFilter: ColorFilter.matrix(
                                FiltersMatrix.brightness(brightness)),
                            child: ColorFiltered(
                                colorFilter: ColorFilter.matrix(
                                    FiltersMatrix.saturation(saturation)),
                                child: ColorFiltered(
                                    colorFilter: ColorFilter.matrix(
                                        FiltersMatrix.contrast(contrast)),
                                    child: ColorFiltered(
                                        colorFilter: ColorFilter.matrix(
                                            FiltersMatrix.hue(hue * 2)),
                                        child: ColorFiltered(
                                          colorFilter: ColorFilter.matrix(
                                              FiltersMatrix.contrast(1.0 +
                                                  FaceBeautyList
                                                          .faceBeautyList[
                                                              _faceFilterIndex
                                                                  .toInt()]
                                                          .contrast! /
                                                      100)),
                                          child: ValueListenableBuilder(
                                            valueListenable:
                                                currentPresetFilter,
                                            builder: (context, value, child) {
                                              return PageView.builder(
                                                controller: pageController,
                                                itemCount: tinyImages.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                onPageChanged: (newPage) {
                                                  setState(() {
                                                    currentImage = newPage;
                                                  });
                                                },
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return FittedBox(
                                                    child: SizedBox(
                                                      width: uiImages[index]
                                                          .width
                                                          .toDouble(),
                                                      height: uiImages[index]
                                                          .height
                                                          .toDouble(),
                                                      child: ImageFiltered(
                                                        imageFilter: ui.ImageFilter.blur(
                                                            // sigmaX: FaceBeautyList.faceBeautyList[_faceFilterIndex.toInt()].bgBlur/8,
                                                            // sigmaY: FaceBeautyList.faceBeautyList[_faceFilterIndex.toInt()].bgBlur/8,
                                                            // tileMode: TileMode.mirror
                                                            ),
                                                        child: CustomPaint(
                                                          painter: PaintImage(
                                                              eyesColor:
                                                                  eyesColors[0],
                                                              eyesColorOpacity:
                                                                  eyesOpacity,
                                                              filterMatrix: FiltersMatrix.changeOpacityOfMatrix(
                                                                  FiltersMatrix
                                                                          .filtersList[
                                                                      currentPresetFilter
                                                                          .value]!,
                                                                  filterOpacity),
                                                              skinColor: skinColors[
                                                                  _currentSkinColorIndex],
                                                              image: uiImages[
                                                                  index],
                                                              vignette:
                                                                  vignette,
                                                              faceFilter: FaceBeautyList
                                                                      .faceBeautyList[
                                                                  _faceFilterIndex
                                                                      .toInt()],
                                                              faces: facesList[
                                                                  index]),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ))))),
                      ),
                    ),
                  ),
                ),
                if (Screens.edit == currentScreen &&
                    _currentFilter != Filter.noFilter)
                  Slider(
                    value: _getFilterValue(),
                    min: 0,
                    max: 2,
                    onChangeEnd: (value) {},
                    onChanged: (double value) {
                      _assignFilterValue(value);
                      setState(() {});
                    },
                  )
                else if (Screens.filter == currentScreen)
                  ValueListenableBuilder(
                    valueListenable: currentPresetFilter,
                    builder: (BuildContext context, value, Widget? child) {
                      print(
                          "Current present filter value ${currentPresetFilter.value}");
                      if (currentPresetFilter.value == 'normal') {
                        return const SizedBox();
                      }
                      return Slider(
                        value: filterOpacity,
                        min: 0,
                        max: 1,
                        onChanged: (double value) {
                          filterOpacity = value;
                          currentPresetFilter.notifyListeners();
                        },
                      );
                    },
                  )
                else if (Screens.vignette == currentScreen &&
                    vignette.vignetteType != VignetteType.none)
                  Slider(
                    value: vignette.amount!,
                    min: 0,
                    max: 100,
                    onChangeEnd: (value) {},
                    onChanged: (double value) {
                      setState(() {
                        vignette.amount = value;
                      });
                    },
                  )
                else if (currentScreen == Screens.beauty)
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 110,
                        child: Column(
                          children: [
                            Slider(
                                min: 0,
                                max: 5,
                                label: _faceFilterIndex == 0
                                    ? "None"
                                    : 'Filter ' + _faceFilterIndex.toString(),
                                divisions: 5,
                                value: _faceFilterIndex.toDouble(),
                                onChanged: (newStop) async {
                                  setState(() {
                                    _faceFilterIndex = newStop.toInt();
                                  });
                                }),
                            SizedBox(
                              height: 60,
                              child: ListView.builder(
                                itemCount: skinColors.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _currentSkinColorIndex = index;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: skinColors[index],
                                          border: Border.all(
                                              color: Colors.black45,
                                              width: index ==
                                                      _currentSkinColorIndex
                                                  ? 2
                                                  : 1)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                if (currentScreen != Screens.beauty)
                  SizedBox(
                    height: 120,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: _getCurrentScreensList()),
                  )
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentScreen.index,
        onTap: (newScreen) {
          setState(() {
            currentScreen = Screens.values[newScreen];
            print(currentScreen);
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: lightRed,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Edit'),
          BottomNavigationBarItem(icon: Icon(Icons.pages), label: 'Sharpness'),
          BottomNavigationBarItem(
              icon: Icon(Icons.vignette), label: 'Vignette'),
          BottomNavigationBarItem(icon: Icon(Icons.filter), label: 'Filter'),
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'Beauty'),
        ],
      ),
    );
  }
}

class Hole extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = 100;
    double blurRadius = 10;
    canvas.drawCircle(
      const Offset(0, 0),
      radius,
      Paint()
        ..blendMode = BlendMode.xor
        // The mask filter gives some fuziness to the cutout.
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius),
    );
  }

  @override
  bool shouldRepaint(Hole oldDelegate) => false;
}
