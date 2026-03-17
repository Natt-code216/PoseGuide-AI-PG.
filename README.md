# 灵感快门 (PoseGuide AI)

一个使用 Flutter 开发的摄影姿势指南应用，帮助用户找到合适的拍照姿势并提供 AI 分析功能。

## 功能特性

### 首页
- 展示各种摄影姿势卡片
- 支持按类别筛选（站立、坐姿、户外、室内等）
- 支持关键词搜索（姿势名称、描述、标签）
- 精美的毛玻璃效果卡片设计
- 推荐/新锐/精选标签分类

### AI 分析
- 支持从相册选择图片或拍照
- 模拟 AI 分析照片功能
- 提供照片评分和改进建议

### 个人中心
- 收藏的姿势列表
- 浏览历史记录
- 用户设置（通知、隐私、关于我们等）

## 项目结构

### 目录结构总览

```
lib/
├── main.dart                 # 应用入口
├── data/                     # 模拟数据
├── models/                   # 数据模型定义
├── providers/                # 状态管理
├── screens/                  # 页面/屏幕
├── services/                 # 业务逻辑服务
├── utils/                    # 工具函数和常量
└── widgets/                  # 可复用 UI 组件
```

### 各目录详细说明

| 目录 | 作用 | 包含文件 |
|------|------|----------|
| **`data/`** | 存放模拟数据，用于开发和测试 | `mock_poses.dart` - 姿势数据<br>`mock_categories.dart` - 分类数据<br>`mock_analysis.dart` - 分析结果数据 |
| **`models/`** | 定义数据结构模型 | `pose_model.dart` - 姿势模型<br>`pose_category.dart` - 分类模型<br>`analysis_result.dart` - 分析结果模型<br>`user_model.dart` - 用户模型 |
| **`providers/`** | 状态管理（Provider 模式） | `navigation_provider.dart` - 底部导航栏状态管理 |
| **`screens/`** | 完整的页面级组件 | `home_screen.dart` - 首页<br>`analysis_screen.dart` - AI 分析页<br>`user_profile_screen.dart` - 个人中心<br>`pose_detail_screen.dart` - 姿势详情页<br>`search_match_screen.dart` - 搜索页 |
| **`services/`** | 业务逻辑层，处理数据获取 | `pose_service.dart` - 姿势相关服务（查询、筛选、搜索） |
| **`utils/`** | 工具函数和常量定义 | `constants.dart` - 常量<br>`helpers.dart` - 辅助函数 |
| **`widgets/`** | 可复用的 UI 组件 | `bottom_nav_bar.dart` - 底部导航栏<br>`category_filter.dart` - 分类筛选器<br>`custom_search_bar.dart` - 搜索栏<br>`pose_card.dart` - 姿势卡片<br>`image_upload.dart` - 图片上传组件<br>`analysis_result_card.dart` - 分析结果卡片 |

## 运行环境要求

- Flutter SDK: ^3.11.1
- Dart SDK: ^3.11.1
- Android: API 21+ (Android 5.0+)
- iOS: iOS 12.0+

## 安装与运行

### 1. 克隆项目

```bash
cd flutter_application_1
```

### 2. 安装依赖

```bash
flutter pub get
```

### 3. 运行应用

```bash
# 运行在 Chrome 浏览器
flutter run -d chrome

# 运行在 Android 模拟器
flutter run

# 运行在 iOS 模拟器 (仅限 macOS)
flutter run -d ios

# 查看可用设备
flutter devices
```

### 4. 构建发布版本

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS (仅限 macOS)
flutter build ios --release
```

## 主要依赖

| 依赖包 | 用途 |
|--------|------|
| `provider` | 状态管理 |
| `image_picker` | 图片选择（拍照/相册） |
| `cached_network_image` | 网络图片缓存 |
| `dio` | HTTP 网络请求 |
| `http` | HTTP 客户端 |
| `path_provider` | 文件路径获取 |

## 核心功能说明

### 姿势浏览
- 使用 `PoseService` 获取姿势列表
- 支持按分类筛选和关键词搜索
- 采用 staggered grid 实现错落有致的卡片布局

### 分类筛选
- 分类 ID 与姿势的 category 字段关联
- 支持多选切换（点击取消选中）
- 与搜索功能组合使用

### 状态管理
- 使用 `Provider` 进行全局状态管理
- `NavigationProvider` 管理底部导航栏选中状态

## 已修复的问题

1. **类别筛选功能修复**：将 `mock_poses.dart` 中的 `category` 字段从中文改为英文 ID（如 `standing`、`sitting`），与 `mock_categories.dart` 中的分类 ID 匹配。

2. **删除重复文件**：移除了未使用的 `lib/widgets/search_bar.dart`，保留 `custom_search_bar.dart`。

3. **布局错误修复**：将 `StaggeredGrid` 替换为 `GridView.builder`，解决了 `RenderBox was not laid out` 的布局错误。

4. **依赖清理**：从 `pubspec.yaml` 中移除了不再使用的 `flutter_staggered_grid_view` 依赖。

## 后续开发建议

1. **后端集成**：替换 mock 数据，接入真实 API
2. **本地存储**：实现收藏和历史记录的持久化
3. **AI 分析**：接入真实的图像分析模型
4. **用户系统**：实现登录注册功能
5. **图片资源**：添加更多姿势图片资源

## 许可证

本项目仅供学习参考使用。
