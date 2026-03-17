import '../models/analysis_result.dart';

List<AnalysisResult> mockAnalysisResults = [
  AnalysisResult(
    id: '1',
    originalImageUrl:
        'assets/images/h.jpg',
    analysisText: '这张照片构图平衡，主体突出，色彩搭配和谐。',
    qualityScore: 8.5,
    suggestions: ['可以尝试稍微低角度拍摄，增加视觉冲击力', '注意前景元素的安排，避免过于杂乱'],
    analyzedAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  AnalysisResult(
    id: '2',
    originalImageUrl:
        'assets/images/h.jpg',
    analysisText: '光线运用得当，人物表情自然，背景虚化效果良好。',
    qualityScore: 9.0,
    suggestions: ['可以稍微增加曝光，让整体色调更加明亮', '人物眼神方向有良好的引导作用'],
    analyzedAt: DateTime.now().subtract(const Duration(hours: 2)),
  ),
];
