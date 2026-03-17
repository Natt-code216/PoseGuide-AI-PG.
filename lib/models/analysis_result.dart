class AnalysisResult {
  final String id;
  final String originalImageUrl;
  final String analysisText;
  final double qualityScore;
  final List<String> suggestions;
  final DateTime analyzedAt;

  AnalysisResult({
    required this.id,
    required this.originalImageUrl,
    required this.analysisText,
    required this.qualityScore,
    required this.suggestions,
    required this.analyzedAt,
  });

  factory AnalysisResult.fromJson(Map<String, dynamic> json) {
    return AnalysisResult(
      id: json['id'] ?? '',
      originalImageUrl: json['originalImageUrl'] ?? '',
      analysisText: json['analysisText'] ?? '',
      qualityScore: (json['qualityScore'] is int)
          ? (json['qualityScore'] as int).toDouble()
          : json['qualityScore']?.toDouble() ?? 0.0,
      suggestions: List<String>.from(json['suggestions'] ?? []),
      analyzedAt: DateTime.tryParse(json['analyzedAt']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'originalImageUrl': originalImageUrl,
      'analysisText': analysisText,
      'qualityScore': qualityScore,
      'suggestions': suggestions,
      'analyzedAt': analyzedAt.toIso8601String(),
    };
  }
}