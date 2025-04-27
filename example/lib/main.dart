import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_duration/video_duration.dart';

void main() {
  runApp(const VideoDurationApp());
}

class VideoDurationApp extends StatelessWidget {
  const VideoDurationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Duration Checker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const VideoDurationHomePage(),
    );
  }
}

class VideoDurationHomePage extends StatefulWidget {
  const VideoDurationHomePage({super.key});

  @override
  State<VideoDurationHomePage> createState() => _VideoDurationHomePageState();
}

class _VideoDurationHomePageState extends State<VideoDurationHomePage> {
  String? _filePath;
  double? _videoDurationSeconds;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Duration Checker')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _loading ? null : _pickFile,
                child: const Text('Select Video File'),
              ),
              const SizedBox(height: 20),
              if (_loading) const CircularProgressIndicator(),
              if (_videoDurationSeconds != null) ...[
                const SizedBox(height: 20),
                Text(
                  'Selected File:\n${_filePath ?? ""}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Video Duration: ${_videoDurationSeconds?.toStringAsFixed(3)} seconds',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickFile() async {
    setState(() {
      _loading = true;
      _videoDurationSeconds = null;
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null && result.files.single.path != null) {
      String path = result.files.single.path!;
      double duration = await getVideoDuration(path);

      setState(() {
        _filePath = path;
        _videoDurationSeconds = duration;
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }
}
