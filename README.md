# 📹 video_duration

A Flutter package that provides a simple cross-platform utility to get the **duration of a video file in seconds**.

Currently supports **Windows** and **macOS**. Contributions are welcome to extend support to **Linux**, **Android**, **iOS**, and **Web**!

## ✨ Features

- Returns the **duration of a video** file.
- Outputs a **double** value (e.g., `3.728` = 3 seconds and 728 milliseconds).
- Works seamlessly on **Windows** and **macOS**.
- Minimal, focused, and easy to integrate.

## 🔧 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  video_duration: ^<latest_version>
```
or type:
```bash
flutter pub add video_duration
```

Then run:
```bash
flutter pub get
```
## 🧠 Usage

```Dart
import 'package:video_duration/video_duration.dart';

void main() async {
  final duration = await getVideoDuration('path/to/video.mp4');
  print('Video duration: $duration seconds');
}
```

## 💻 Supported Platforms
- ✅ macOS
- ✅ Windows
- ⏳ Linux (Help wanted!)
- ✅ iOS
- ⏳ Android (Help wanted!)
- ⏳ Web (Help wanted!)

## 🤝 Contributing

Contributions are **welcome and appreciated**!
Feel free to:
- Submit a pull request for additional platform support
- Report issues or bugs
- Suggest improvements
