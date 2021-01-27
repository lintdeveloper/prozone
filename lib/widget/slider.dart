import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Slider {
  final String sliderImageUrl;
  final String sliderSubHeading;

  Slider(
      {@required this.sliderImageUrl,
        @required this.sliderSubHeading});
}

List<Asset> sliderImageList = List<Asset>();

