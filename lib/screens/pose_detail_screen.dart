import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/pose_model.dart';

class PoseDetailScreen extends StatelessWidget {
  final Pose pose;

  const PoseDetailScreen({Key? key, required this.pose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          // 顶部图片区域
          _buildHeroImage(context),

          // 内容区域
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题和分类
                  _buildHeader(context),
                  const SizedBox(height: 24),

                  // 审美原理分析
                  _buildSectionCard(
                    context,
                    title: '审美原理',
                    icon: Icons.palette_outlined,
                    child: _buildAestheticAnalysis(context),
                  ),
                  const SizedBox(height: 16),

                  // 构图方式
                  if (pose.composition != null) ...[
                    _buildSectionCard(
                      context,
                      title: '构图方式',
                      icon: Icons.grid_on_outlined,
                      child: Text(
                        pose.composition!,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF4A4A4A),
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // 拍摄参数
                  _buildSectionCard(
                    context,
                    title: '拍摄参数',
                    icon: Icons.camera_alt_outlined,
                    child: _buildCameraParams(context),
                  ),
                  const SizedBox(height: 16),

                  // 身体线条指导
                  if (pose.bodyLineGuide != null) ...[
                    _buildSectionCard(
                      context,
                      title: '身体线条',
                      icon: Icons.accessibility_new_outlined,
                      child: Text(
                        pose.bodyLineGuide!,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF4A4A4A),
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // 表情指导
                  if (pose.expressionGuide != null) ...[
                    _buildSectionCard(
                      context,
                      title: '表情指导',
                      icon: Icons.face_outlined,
                      child: Text(
                        pose.expressionGuide!,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF4A4A4A),
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // 场景建议
                  if (pose.sceneSuggestion != null) ...[
                    _buildSectionCard(
                      context,
                      title: '场景建议',
                      icon: Icons.landscape_outlined,
                      child: Text(
                        pose.sceneSuggestion!,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF4A4A4A),
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // 拍摄技巧
                  _buildSectionCard(
                    context,
                    title: '拍摄技巧',
                    icon: Icons.lightbulb_outline,
                    child: Text(
                      pose.tips,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF4A4A4A),
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 描述
                  _buildSectionCard(
                    context,
                    title: '姿势描述',
                    icon: Icons.description_outlined,
                    child: Text(
                      pose.description,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF4A4A4A),
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 标签
                  _buildTags(context),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 顶部英雄图片
  Widget _buildHeroImage(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 380,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 图片
              Image.asset(
                pose.imageUrl,
                fit: BoxFit.cover,
              ),
              // 底部渐变遮罩
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
              // 左上角返回按钮
              Positioned(
                top: 40,
                left: 16,
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
              ),
              // 右上角分享按钮
              Positioned(
                top: 40,
                right: 16,
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.share_outlined, size: 20),
                        color: Colors.white,
                        onPressed: () {
                          // TODO: 分享功能
                        },
                      ),
                    ),
                  ),
                ),
              ),
              // 底部标题
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pose.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildChip(
                          pose.category,
                          Colors.white.withOpacity(0.3),
                          Colors.white,
                        ),
                        if (pose.lighting != null) ...[
                          const SizedBox(width: 8),
                          _buildChip(
                            pose.lighting!,
                            Colors.white.withOpacity(0.3),
                            Colors.white,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 头部信息
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.info_outline,
          color: Color(0xFF6B7280),
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          '基本信息',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  /// 审美分析
  Widget _buildAestheticAnalysis(BuildContext context) {
    final analysis = pose.aestheticAnalysis ??
        '此姿势通过自然的身体曲线和角度，营造出优雅且不失亲和力的视觉效果。重点在于展现被摄者的气质与个性，同时保持画面的平衡与和谐。';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          analysis,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF4A4A4A),
            height: 1.8,
          ),
        ),
        const SizedBox(height: 16),
        // 美学要点
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildInsightChip('构图平衡', Icons.center_focus_strong),
            _buildInsightChip('视觉引导', Icons.auto_graph),
            _buildInsightChip('情绪表达', Icons.sentiment_satisfied),
          ],
        ),
      ],
    );
  }

  /// 拍摄参数
  Widget _buildCameraParams(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildParamItem(
              '焦距',
              pose.focalLength ?? '50mm',
              Icons.center_focus_strong,
            ),
            _buildParamItem(
              '光圈',
              pose.aperture ?? 'f/1.8',
              Icons.blur_on,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildParamItem(
              '快门',
              pose.shutterSpeed ?? '1/125s',
              Icons.speed,
            ),
            _buildParamItem(
              'ISO',
              pose.iso ?? '100-400',
              Icons.settings_brightness,
            ),
          ],
        ),
      ],
    );
  }

  /// 参数项
  Widget _buildParamItem(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 分区卡片
  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      size: 20,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ),
      ),
    );
  }

  /// 标签区域
  Widget _buildTags(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.local_offer_outlined,
                size: 20, color: Colors.grey[600]),
            const SizedBox(width: 8),
            Text(
              '相关标签',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: pose.tags.map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE9FE),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '#',
                    style: TextStyle(
                      color: Color(0xFF7C3AED),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    tag,
                    style: const TextStyle(
                      color: Color(0xFF7C3AED),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// 小芯片
  Widget _buildChip(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// 洞察芯片
  Widget _buildInsightChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
