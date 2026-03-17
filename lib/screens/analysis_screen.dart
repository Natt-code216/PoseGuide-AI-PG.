import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/image_upload.dart';
import '../widgets/analysis_result_card.dart';
import '../models/analysis_result.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  File? _selectedImage;
  bool _isAnalyzing = false;
  AnalysisResult? _analysisResult;

  void _onImageSelected(File image) {
    setState(() {
      _selectedImage = image;
      _analysisResult = null; // Reset previous result
    });
  }

  Future<void> _analyzeImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请先选择一张图片')));
      return;
    }

    setState(() {
      _isAnalyzing = true;
    });

    // Simulate AI analysis delay
    await Future.delayed(const Duration(seconds: 2));

    // For demo purposes, return a mock analysis result
    // In a real app, this would be replaced with actual AI analysis

    setState(() {
      _isAnalyzing = false;
      _analysisResult = AnalysisResult(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        originalImageUrl:
            'assets/images/h.jpg',
        analysisText:
            '这张照片构图良好，主体突出，光线运用得当。建议可以尝试低角度拍摄以增加视觉冲击力，注意背景元素的安排以避免杂乱。',
        qualityScore: (8.0 + (DateTime.now().millisecond % 21) / 10).clamp(
          5.0,
          10.0,
        ),
        suggestions: [
          '尝试从低角度拍摄增加视觉冲击力',
          '注意背景元素的安排，避免过于杂乱',
          '可以适当调整曝光让整体色调更加明亮',
        ],
        analyzedAt: DateTime.now(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('图片分析'), centerTitle: true),
      body: Column(
        children: [
          ImageUpload(onImageSelected: _onImageSelected),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: _selectedImage != null && !_isAnalyzing
                  ? _analyzeImage
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: _isAnalyzing
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text('正在分析...'),
                      ],
                    )
                  : const Text('开始分析'),
            ),
          ),
          const SizedBox(height: 16),
          if (_analysisResult != null) ...[
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AnalysisResultCard(result: _analysisResult!),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
