import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_duration/video_duration.dart';

void main() {
  test('test getVideoDuration', () async {
    WidgetsFlutterBinding.ensureInitialized();
    final duration = await getVideoDuration(
      "test_data/SampleVideo_1280x720_1mb.mp4",
    );
    expect(duration.toInt(), 5);
  });
  test('test getVideoDuration 2', () async {
    WidgetsFlutterBinding.ensureInitialized();
    final duration = await getVideoDuration(
      "test_data/SampleVideo_1280x720_2mb.mp4",
    );
    expect(duration.toInt(), 13);
  });
}
