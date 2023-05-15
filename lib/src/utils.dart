
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

Image createImage(
    int width, int height, Uint8List bytes, int channels, int rowStride) {
  final image = img.Image.fromBytes(
      width: width,
      height: height,
      bytes: bytes.buffer,
      numChannels: channels,
      rowStride: rowStride,
      order: img.ChannelOrder.rgb);
  final png = img.encodePng(image);
  return Image.memory(
    png,
    height: 100,
    width: 100,
  );
}
