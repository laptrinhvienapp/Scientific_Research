import 'dart:convert'; // Added for jsonDecode
import 'dart:io';
import 'dart:typed_data';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:project/utils/utils.dart';
import 'package:project/widgets/widgets.dart';
import 'package:screenshot/screenshot.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class LayoutGui extends StatefulWidget {
  const LayoutGui({
    super.key,
    required this.callID,
    required this.appID,
    required this.appSign,
    required this.userID,
    required this.userName,
    required this.config,
  });

  final String callID;
  final int appID;
  final String appSign;
  final String userID;
  final String userName;
  final ZegoUIKitPrebuiltCallConfig config;

  @override
  State<LayoutGui> createState() => _LayoutGuiState();
}

class _LayoutGuiState extends State<LayoutGui> {
  final ScreenshotController _screenshotController = ScreenshotController();
  Uint8List? _capturedImage;

  // Function to send image to Python API and get prediction
  Future<String> sendImage(Uint8List imageBytes) async {
    final url = Uri.parse('http://10.0.2.2:5000/analyze_image');

    try {
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = '${tempDir.path}/screenshot_$timestamp.png';

      File file = File(filePath);
      await file.writeAsBytes(imageBytes);

      var request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('image', file.path));

      var response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        debugPrint('📸 Ảnh đã gửi thành công: $filePath');
        final jsonResponse = jsonDecode(responseBody);
        final prediction = jsonResponse['prediction'];
        if (prediction == "0") {
          return "DeepFake";
        } else if (prediction == "1") {
          return "Real";
        } else {
          return "Unknown";
        }
      } else if (response.statusCode == 400) {
        debugPrint('⚠️ Không phát hiện khuôn mặt hoặc ảnh không hợp lệ');
        return "Unknown (No face detected)";
      } else {
        debugPrint('⚠️ Gửi ảnh thất bại: ${response.statusCode}');
        return "Error: Failed to analyze image";
      }
    } catch (e) {
      debugPrint('❌ Lỗi khi gửi ảnh: $e');
      return "Error: $e";
    }
  }




  void _showDeepFakeWarning() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        content: AwesomeSnackbarContent(
          title: 'Cảnh báo DeepFake!',
          message: 'Người dùng trong cuộc gọi có thể đang sử dụng DeepFake.',
          contentType: ContentType.warning,
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showNoDeepFakeWarning() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        content: AwesomeSnackbarContent(
          title: 'Không phát hiện DeepFake',
          message: 'Người dùng trong cuộc gọi không sử dụng DeepFake.',
          contentType: ContentType.success,
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showUnknownWarning() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        content: AwesomeSnackbarContent(
          title: 'Không xác định',
          message: 'Nhận diện không phải người hoặc không phát hiện khuôn mặt.',
          contentType: ContentType.help, // Using 'help' for neutral/unknown case
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showCaptureAlert() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomConfirmDialog(
          title: 'Xác nhận yêu cầu',
          content: 'Bạn có chắc muốn xác nhận DeepFake hay không?',
          titleConfirm: 'Đồng ý',
          titleCancel: 'Huỷ',
          onConfirm: () {
            Navigator.pop(context);
            _captureImage();
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _captureImage() async {
    if (!mounted) return;

    final image = await _screenshotController.capture();
    if (image == null || !mounted) return;

    setState(() {
      _capturedImage = image;
    });

    if (!mounted) return;

    Future.microtask(() async {
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return CustomShowDialog(
              title: 'Xác nhận gửi yêu cầu',
              onConfirm: () async {
                Navigator.pop(dialogContext);
                if (_capturedImage != null) {
                  String result = await sendImage(_capturedImage!);
                  if (mounted) {
                    _showResult(result); // Show appropriate warning based on result
                  }
                }
              },
              onCancel: () => Navigator.pop(dialogContext),
              titleConfirm: 'Gửi yêu cầu',
              titleCancel: 'Huỷ bỏ',
              image: Image.memory(_capturedImage!),
            );
          },
        );
      }
    });
  }

  void _showResult(String result) {
    if (result == "DeepFake") {
      _showDeepFakeWarning();
    } else if (result == "Real") {
      _showNoDeepFakeWarning();
    } else {
      _showUnknownWarning(); // Covers "Unknown", "Unknown (No face detected)", or "Error"
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenshot(
        controller: _screenshotController,
        child: ZegoUIKitPrebuiltCall(
          appID: widget.appID,
          appSign: widget.appSign,
          callID: widget.callID,
          userID: widget.userID,
          userName: widget.userName,
          config: widget.config,
        ),
      ),
      floatingActionButton: Padding(
        padding: AppSpacings.allSmall,
        child: FloatingIcon(
          onPressed: _showCaptureAlert,
          child: const Icon(
            Icons.face,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}