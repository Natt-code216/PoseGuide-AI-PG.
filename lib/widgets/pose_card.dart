import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/pose_model.dart';
import '../screens/pose_detail_screen.dart';

class PoseCard extends StatelessWidget {
  final Pose pose;

  const PoseCard({Key? key, required this.pose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PoseDetailScreen(pose: pose)),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: -2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // 背景图片
              Positioned.fill(
                child: Image.asset(
                  pose.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(Icons.image, size: 48, color: Colors.grey[500]),
                    );
                  },
                ),
              ),

              // 左上角标签
              _buildTag(),

              // 底部毛玻璃遮罩 + 文字
              _buildFrostedScrim(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag() {
    final tagType = pose.tagType;

    final (label, icon, color) = switch (tagType) {
      TagType.recommended => ('推荐', Icons.star, Colors.amber),
      TagType.emerging => ('新锐', Icons.auto_awesome, Colors.blue),
      TagType.normal => ('精选', Icons.auto_awesome, Colors.grey),
    };

    return Positioned(
      top: 8,
      left: 8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.25),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: color.withOpacity(0.4),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 12, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFrostedScrim() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: 100,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.2),
                  Colors.transparent,
                ],
              ),
            ),
            child: _buildTextContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildTextContent() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 标题
          Text(
            pose.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          // 副标题信息
          if (pose.model != null || pose.lighting != null)
            SizedBox(
              height: 14,
              child: Row(
                children: [
                  if (pose.model != null) ...[
                    const Icon(Icons.person, size: 12, color: Colors.white70),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        pose.model!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                  if (pose.model != null && pose.lighting != null) ...[
                    const SizedBox(width: 8),
                  ],
                  if (pose.lighting != null) ...[
                    const Icon(Icons.light_mode, size: 12, color: Colors.white60),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        pose.lighting!,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          const SizedBox(height: 4),
          // 分类和标签
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  pose.category,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              if (pose.tags.isNotEmpty)
                Flexible(
                  child: Text(
                    pose.tags.take(2).join(' · '),
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 10,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
