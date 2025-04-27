import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter/media_information.dart';
import 'package:ffmpeg_kit_flutter/media_information_session.dart';
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
  MediaInformationSession mediaInformationSession =
      await FFprobeKit.getMediaInformation(videoPath);
  MediaInformation? mediaInformation =
      mediaInformationSession.getMediaInformation();
  if (mediaInformation == null) {
    throw StateError("media information not found");
  }
  String? durationString = mediaInformation.getDuration();
  if (durationString == null) {
    throw StateError("duration not found");
  }
  final double seconds = double.parse(durationString);
  return seconds;
}

Future<double> _getVideoDurationMacAndWindows(String videoPath) async {
  Thumbnail thumbnail = await generateThumbnail(filePath: videoPath);
  final videoDuration = thumbnail.videoDuration;
  if (videoDuration == null) {
    throw StateError("Video duration not found");
  }
  return videoDuration;
}
