import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        title: const Text('隐私政策'),
        backgroundColor: const Color(0xFF7B1FA2),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              '隐私政策',
              '最后更新时间：2026 年 3 月 17 日',
            ),
            const SizedBox(height: 24),
            _buildSection(
              '一、信息收集与使用',
              '我们收集以下类型的信息以提供更好的服务：\n\n'
              '1. 您提供的信息\n'
              '• 账号信息：注册时提供的用户名、邮箱等\n'
              '• 个人资料：头像、昵称、性别、生日等\n'
              '• 用户内容：上传的照片、收藏的姿势、浏览历史等\n\n'
              '2. 自动收集的信息\n'
              '• 设备信息：设备型号、操作系统、唯一设备标识符\n'
              '• 日志信息：使用时长、点击记录、崩溃日志等\n'
              '• 位置信息：经您授权后收集的地理位置信息',
            ),
            const SizedBox(height: 16),
            _buildSection(
              '二、信息共享与披露',
              '我们不会向第三方出售、出租或交易您的个人信息。但在以下情况下，我们可能会共享您的信息：\n\n'
              '• 经您同意：在您明确同意的情况下\n'
              '• 服务提供商：与为我们提供服务的合作伙伴（如云服务、支付处理）\n'
              '• 法律要求：根据法律法规要求或政府部门要求\n'
              '• 保护权益：为保护我们或用户的合法权益',
            ),
            const SizedBox(height: 16),
            _buildSection(
              '三、信息安全',
              '我们采取合理的安全措施保护您的信息：\n\n'
              '• 数据加密：使用 SSL/TLS 等加密技术传输数据\n'
              '• 访问控制：严格限制数据访问权限\n'
              '• 安全存储：将数据存储在安全的服务器环境中\n'
              '• 定期审计：定期进行安全审计和风险评估\n\n'
              '但请注意，互联网环境并非 100% 安全，我们无法保证绝对安全。',
            ),
            const SizedBox(height: 16),
            _buildSection(
              '四、用户权利',
              '您对自己的个人信息享有以下权利：\n\n'
              '• 访问权：您可以查看我们收集的您的信息\n'
              '• 更正权：您可以更正不准确的个人信息\n'
              '• 删除权：在特定情况下，您可以请求删除个人信息\n'
              '• 撤回同意：您可以撤回之前给予的同意\n'
              '• 注销账号：您可以申请注销账号',
            ),
            const SizedBox(height: 16),
            _buildSection(
              '五、未成年人保护',
              '我们重视未成年人个人信息保护：\n\n'
              '• 若您是 14 周岁以下的未成年人，请在监护人陪同下使用本服务\n'
              '• 若您是 14-18 周岁的未成年人，请在监护人同意下使用本服务\n'
              '• 监护人如对未成年人信息保护有疑问，请联系我们',
            ),
            const SizedBox(height: 16),
            _buildSection(
              '六、政策更新',
              '我们可能会不时更新本隐私政策：\n\n'
              '• 更新后，我们会通过应用内通知等方式告知您\n'
              '• 若您继续使用我们的服务，即表示同意受更新后的政策约束\n'
              '• 建议您定期查看本政策以了解最新的保护措施',
            ),
            const SizedBox(height: 16),
            _buildSection(
              '七、联系我们',
              '如对本隐私政策有任何疑问、意见或建议，请通过以下方式联系我们：\n\n'
              '• 邮箱：privacy@poseguide.ai\n'
              '• 地址：XX 省 XX 市 XX 区 XX 路 XX 号',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
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
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7B1FA2),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              content,
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
}
