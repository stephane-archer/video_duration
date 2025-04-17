import 'dart:io';

import 'package:thumblr/thumblr.dart';

/// Returns the duration of the video in seconds as a double.
/// Example: 3.728 means 3 seconds and 728 milliseconds.
Future<double> getVideoDuration(String videoPath) async {
  if (!FileSystemEntity.isFileSync(videoPath)){
    throw ArgumentError("$videoPath is not a file", "videoPath");
  }
  Thumbnail thumbnail = await generateThumbnail(filePath: videoPath);
  final videoDuration = thumbnail.videoDuration;
  if (videoDuration == null) {
    throw StateError("Video duration not found");
  }
  return videoDuration; // in seconds
}
