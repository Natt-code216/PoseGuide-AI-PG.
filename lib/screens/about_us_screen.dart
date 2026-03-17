import 'package:flutter/material.dart';
import 'privacy_policy_screen.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        title: const Text('关于我们'),
        backgroundColor: const Color(0xFF7B1FA2),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Logo 和应用名称
            _buildLogoSection(),
            const SizedBox(height: 32),
            // 应用介绍
            _buildIntroCard(),
            const SizedBox(height: 16),
            // 版本信息
            _buildVersionCard(context),
            const SizedBox(height: 16),
            // 开发团队
            _buildTeamCard(),
            const SizedBox(height: 16),
            // 相关链接
            _buildLinksCard(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF7B1FA2), Color(0xFFCE93D8)],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.camera_alt,
            size: 50,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '灵感快门',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7B1FA2),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'PoseGuide AI',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildIntroCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '应用介绍',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7B1FA2),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '灵感快门是一款专为摄影爱好者打造的 AI 姿势指导应用。\n\n'
              '• AI 智能分析：上传照片，AI 为您分析构图、光线、姿势\n'
              '• 海量姿势库：数千种专业摄影姿势模板，随心选择\n'
              '• 个性化推荐：根据您的喜好推荐适合的拍摄姿势\n'
              '• 实时匹配：快速找到与您场景匹配的拍摄方案\n\n'
              '让每一次拍摄都更加专业、高效、有趣！',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVersionCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '版本信息',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7B1FA2),
              ),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('当前版本', '1.0.0'),
            const SizedBox(height: 8),
            _buildInfoRow('更新日期', '2026 年 3 月'),
            const SizedBox(height: 8),
            _buildInfoRow('系统要求', 'Android 5.0+ / iOS 12.0+'),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // TODO: 检查更新
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('已是最新版本')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF7B1FA2),
                  side: const BorderSide(color: Color(0xFF7B1FA2)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('检查更新'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '开发团队',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7B1FA2),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '灵感快门由一支热爱摄影和技术的团队开发。\n\n'
              '我们相信，通过 AI 技术的力量，可以让每个人都能拍出专业级别的照片。\n\n'
              '如果您有任何建议或反馈，欢迎随时与我们联系！',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinksCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                '相关链接',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B1FA2),
                ),
              ),
            ),
            _buildLinkItem(
              context,
              Icons.description_outlined,
              '用户协议',
              () {
                // TODO: 跳转到用户协议
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('用户协议开发中...')),
                );
              },
            ),
            const Divider(height: 1),
            _buildLinkItem(
              context,
              Icons.privacy_tip_outlined,
              '隐私政策',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PrivacyPolicyScreen(),
                  ),
                );
              },
            ),
            const Divider(height: 1),
            _buildLinkItem(
              context,
              Icons.email_outlined,
              '联系我们',
              () {
                // TODO: 跳转到联系我们
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('联系我们开发中...')),
                );
              },
            ),
            const Divider(height: 1),
            _buildLinkItem(
              context,
              Icons.star_outline,
              '给个好评',
              () {
                // TODO: 打开应用商店评价
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('感谢支持！评价功能开发中...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildLinkItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF7B1FA2)),
      title: Text(title),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
