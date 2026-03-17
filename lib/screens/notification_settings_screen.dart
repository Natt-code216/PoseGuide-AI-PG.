import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  // 通知开关状态
  bool _pushEnabled = true;
  bool _systemEnabled = true;
  bool _activityEnabled = true;
  bool _emailEnabled = false;
  bool _newFeatureEnabled = true;
  bool _reminderEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _pushEnabled = prefs.getBool('push_enabled') ?? true;
      _systemEnabled = prefs.getBool('system_enabled') ?? true;
      _activityEnabled = prefs.getBool('activity_enabled') ?? true;
      _emailEnabled = prefs.getBool('email_enabled') ?? false;
      _newFeatureEnabled = prefs.getBool('new_feature_enabled') ?? true;
      _reminderEnabled = prefs.getBool('reminder_enabled') ?? false;
    });
  }

  Future<void> _saveSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        title: const Text('通知设置'),
        backgroundColor: const Color(0xFF7B1FA2),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('推送通知'),
            _buildToggleCard(
              icon: Icons.notifications_active,
              title: '推送通知开关',
              subtitle: '接收应用推送的消息通知',
              value: _pushEnabled,
              onChanged: (value) {
                setState(() {
                  _pushEnabled = value;
                });
                _saveSetting('push_enabled', value);
              },
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('消息类型'),
            _buildToggleCard(
              icon: Icons.settings,
              title: '系统通知',
              subtitle: '系统更新、维护公告等重要通知',
              value: _systemEnabled,
              onChanged: (value) {
                setState(() {
                  _systemEnabled = value;
                });
                _saveSetting('system_enabled', value);
              },
            ),
            const SizedBox(height: 8),
            _buildToggleCard(
              icon: Icons.event,
              title: '活动通知',
              subtitle: '新功能上线、优惠活动等通知',
              value: _activityEnabled,
              onChanged: (value) {
                setState(() {
                  _activityEnabled = value;
                });
                _saveSetting('activity_enabled', value);
              },
            ),
            const SizedBox(height: 8),
            _buildToggleCard(
              icon: Icons.auto_awesome,
              title: '新功能提醒',
              subtitle: '新功能和改进的通知',
              value: _newFeatureEnabled,
              onChanged: (value) {
                setState(() {
                  _newFeatureEnabled = value;
                });
                _saveSetting('new_feature_enabled', value);
              },
            ),
            const SizedBox(height: 8),
            _buildToggleCard(
              icon: Icons.access_time,
              title: '拍照提醒',
              subtitle: '每日拍照练习提醒',
              value: _reminderEnabled,
              onChanged: (value) {
                setState(() {
                  _reminderEnabled = value;
                });
                _saveSetting('reminder_enabled', value);
              },
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('邮件订阅'),
            _buildToggleCard(
              icon: Icons.email_outlined,
              title: '邮件通知',
              subtitle: '通过邮件接收重要通知和精选内容',
              value: _emailEnabled,
              onChanged: (value) {
                setState(() {
                  _emailEnabled = value;
                });
                _saveSetting('email_enabled', value);
              },
            ),
            const SizedBox(height: 32),
            // 恢复默认按钮
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  setState(() {
                    _pushEnabled = true;
                    _systemEnabled = true;
                    _activityEnabled = true;
                    _emailEnabled = false;
                    _newFeatureEnabled = true;
                    _reminderEnabled = false;
                  });
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('push_enabled', true);
                  await prefs.setBool('system_enabled', true);
                  await prefs.setBool('activity_enabled', true);
                  await prefs.setBool('email_enabled', false);
                  await prefs.setBool('new_feature_enabled', true);
                  await prefs.setBool('reminder_enabled', false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('已恢复默认设置'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF7B1FA2),
                  side: const BorderSide(color: Color(0xFF7B1FA2)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('恢复默认设置'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF7B1FA2),
        ),
      ),
    );
  }

  Widget _buildToggleCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF7B1FA2),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF7B1FA2),
            ),
          ],
        ),
      ),
    );
  }
}
