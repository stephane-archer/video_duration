import 'dart:io';

import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:thumblr/thumblr.dart';

/// Returns the duration of the video in seconds as a double.
/// Example: 3.728 means 3 seconds and 728 milliseconds.
Future<double> getVideoDuration(String videoPath) async {
  if (!FileSystemEntity.isFileSync(videoPath)) {
    throw ArgumentError("$videoPath is not a file", "videoPath");
  }
  if (Platform.isWindows || Platform.isMacOS) {
    double videoDuration = await _getVideoDurationMacAndWindows(videoPath);
    return videoDuration; // in seconds
  }
  if (Platform.isIOS) {
    double videoDuration = await _getVideoDurationiOS(videoPath);
    return videoDuration; // in seconds
  }
  throw UnsupportedError("Unsupported Platform");
}

Future<double> _getVideoDurationiOS(String videoPath) async {
  final videoInfo = FlutterVideoInfo();
  var info = await videoInfo.getVideoInfo(videoPath);
  if (info == null) {
    throw StateError("video information not found");
  }
  final videoDuration = info.duration; // in millisecond
  if (videoDuration == null) {
    throw StateError("Video duration not found");
  }
  return videoDuration / 1000; // in seconds
}

Future<double> _getVideoDurationMacAndWindows(String videoPath) async {
  Thumbnail thumbnail = await generateThumbnail(filePath: videoPath);
  final videoDuration = thumbnail.videoDuration;
  if (videoDuration == null) {
    throw StateError("Video duration not found");
  }
  return videoDuration;
}
