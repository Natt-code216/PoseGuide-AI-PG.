# 灵感快门 (PoseGuide AI)

一个使用 Flutter 开发的摄影姿势指南应用，采用 Material 3 设计风格，帮助用户找到合适的拍照姿势并提供 AI 分析功能。

## 项目概览

| 项目信息 | 详情 |
|----------|------|
| **应用名称** | 灵感快门 (PoseGuide AI) |
| **技术栈** | Flutter + Dart |
| **状态管理** | Provider |
| **SDK 版本** | Flutter ^3.11.1 / Dart ^3.11.1 |
| **支持平台** | Android 5.0+, iOS 12.0+, Web |

## 目录结构总览

```
flutter_application_1/
├── lib/                          # 源代码目录
│   ├── main.dart                 # 应用入口和认证包装器
│   ├── data/                     # 模拟数据层
│   │   ├── mock_poses.dart       # 姿势数据
│   │   ├── mock_categories.dart  # 分类数据
│   │   └── mock_analysis.dart    # AI 分析结果数据
│   ├── models/                   # 数据模型
│   │   ├── pose_model.dart       # 姿势模型
│   │   ├── pose_category.dart    # 分类模型
│   │   ├── analysis_result.dart  # 分析结果模型
│   │   └── user_model.dart       # 用户模型
│   ├── providers/                # 状态管理 (Provider 模式)
│   │   ├── navigation_provider.dart  # 底部导航栏状态
│   │   └── auth_provider.dart    # 认证状态管理
│   ├── screens/                  # 页面/屏幕
│   │   ├── home_screen.dart          # 首页 (姿势列表)
│   │   ├── analysis_screen.dart      # AI 分析页
│   │   ├── user_profile_screen.dart  # 个人中心
│   │   ├── pose_detail_screen.dart   # 姿势详情页
│   │   ├── search_match_screen.dart  # 搜索匹配页
│   │   ├── ai_search_screen.dart     # AI 搜索页
│   │   ├── login_screen.dart         # 登录页
│   │   ├── register_screen.dart      # 注册页
│   │   ├── edit_profile_screen.dart  # 编辑资料页
│   │   ├── settings_screen.dart      # 设置页
│   │   ├── membership_screen.dart    # 会员页
│   │   ├── notification_settings_screen.dart  # 通知设置页
│   │   ├── privacy_policy_screen.dart        # 隐私政策页
│   │   ├── about_us_screen.dart              # 关于我们页
│   │   └── contact_us_screen.dart            # 联系我们页
│   ├── services/                 # 业务逻辑层
│   │   └── pose_service.dart     # 姿势服务 (查询/筛选/搜索)
│   ├── utils/                    # 工具函数
│   │   ├── constants.dart        # 常量定义
│   │   └── helpers.dart          # 辅助函数
│   └── widgets/                  # 可复用组件
│       ├── bottom_nav_bar.dart       # 底部导航栏 (胶囊样式)
│       ├── category_filter.dart      # 分类筛选器
│       ├── custom_search_bar.dart    # 自定义搜索栏
│       ├── pose_card.dart            # 姿势卡片
│       ├── image_upload.dart         # 图片上传组件
│       └── analysis_result_card.dart # 分析结果卡片
├── assets/                       # 静态资源
│   └── images/                   # 图片资源
│       ├── h.jpg
│       ├── 003.png
│       └── 222.png
├── android/                      # Android 平台配置
├── ios/                          # iOS 平台配置
├── web/                          # Web 平台配置
├── windows/                      # Windows 平台配置
├── linux/                        # Linux 平台配置
├── macos/                        # macOS 平台配置
├── test/                         # 测试文件
│   └── widget_test.dart
├── pubspec.yaml                  # 项目配置和依赖
├── analysis_options.yaml         # 代码分析配置
└── README.md                     # 项目文档
```

## 核心功能模块

### 1. 认证系统 (Authentication)
**入口**: `main.dart` → `AuthWrapper`

| 文件 | 功能 |
|------|------|
| `providers/auth_provider.dart` | 认证状态管理，处理登录/注册/登出 |
| `screens/login_screen.dart` | 用户登录页面 |
| `screens/register_screen.dart` | 用户注册页面 |

**流程**: 应用启动时检查登录状态，未登录显示登录页，已登录显示主界面。

### 2. 主界面框架 (Main Screen)
**入口**: `main.dart` → `MainScreen`

采用 `IndexedStack` + 底部导航栏结构：
- 首页 (`HomeScreen`)
- AI 分析 (`AnalysisScreen`)
- 个人中心 (`UserProfileScreen`)

### 3. 首页模块 (Home)
**文件**: `screens/home_screen.dart`

| 功能 | 实现 |
|------|------|
| 姿势展示 | `widgets/pose_card.dart` - 毛玻璃效果卡片 |
| 分类筛选 | `widgets/category_filter.dart` - 支持多选 |
| 搜索功能 | `widgets/custom_search_bar.dart` - 关键词搜索 |
| 数据服务 | `services/pose_service.dart` - 查询/筛选/搜索 |
| 布局样式 | `GridView.builder` - 双瀑布信息流 |

### 4. AI 分析模块 (Analysis)
**文件**: `screens/analysis_screen.dart`

| 功能 | 实现 |
|------|------|
| 图片选择 | `widgets/image_upload.dart` - 支持拍照/相册 |
| 分析展示 | `widgets/analysis_result_card.dart` - 结果卡片 |
| 数据模拟 | `data/mock_analysis.dart` - 模拟 AI 分析结果 |

### 5. 个人中心模块 (Profile)
**文件**: `screens/user_profile_screen.dart`

| 子页面 | 文件 |
|--------|------|
| 编辑资料 | `screens/edit_profile_screen.dart` |
| 会员权益 | `screens/membership_screen.dart` |
| 设置 | `screens/settings_screen.dart` |
| 通知设置 | `screens/notification_settings_screen.dart` |
| 隐私政策 | `screens/privacy_policy_screen.dart` |
| 关于我们 | `screens/about_us_screen.dart` |
| 联系我们 | `screens/contact_us_screen.dart` |

### 6. 其他页面
| 页面 | 文件 | 功能 |
|------|------|------|
| 姿势详情 | `pose_detail_screen.dart` | 查看姿势详细信息 |
| 搜索匹配 | `search_match_screen.dart` | 搜索结果展示 |
| AI 搜索 | `ai_search_screen.dart` | AI 智能搜索 |

## 数据模型

### 核心 Model
```
models/
├── pose_model.dart          # Pose: 姿势数据结构
├── pose_category.dart       # PoseCategory: 分类数据结构
├── analysis_result.dart     # AnalysisResult: AI 分析结果结构
└── user_model.dart          # User: 用户数据结构
```

### 模拟数据
```
data/
├── mock_poses.dart          # 姿势数据列表
├── mock_categories.dart     # 分类数据列表
└── mock_analysis.dart       # AI 分析结果数据
```

## 状态管理 (Provider)

| Provider | 功能 | 使用位置 |
|----------|------|----------|
| `NavigationProvider` | 管理底部导航栏选中索引 | `main.dart`, `bottom_nav_bar.dart` |
| `AuthProvider` | 管理用户认证状态 | `main.dart`, 登录/注册页 |

## 主要依赖包

| 依赖包 | 版本 | 用途 |
|--------|------|------|
| `provider` | ^6.1.1 | 状态管理 |
| `image_picker` | ^1.0.4 | 图片选择（拍照/相册） |
| `cached_network_image` | ^3.3.0 | 网络图片缓存 |
| `dio` | ^5.4.0 | HTTP 网络请求 |
| `http` | ^1.1.0 | HTTP 客户端 |
| `path_provider` | ^2.1.1 | 文件路径获取 |
| `shared_preferences` | ^2.2.2 | 本地存储 |
| `url_launcher` | ^6.2.1 | 打开 URL |
| `cupertino_icons` | ^1.0.8 | iOS 风格图标 |

## 运行环境要求

| 平台 | 要求 |
|------|------|
| Flutter SDK | ^3.11.1 |
| Dart SDK | ^3.11.1 |
| Android | API 21+ (Android 5.0+) |
| iOS | iOS 12.0+ |
| Web | 现代浏览器 |

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

# 运行在 Android 模拟器/真机
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

## UI 设计特点

| 特性 | 描述 |
|------|------|
| **设计风格** | Material 3 |
| **底部导航** | 胶囊样式圆角导航栏 |
| **卡片效果** | 毛玻璃效果 + 渐变背景 |
| **布局方式** | GridView 双瀑布流 |
| **主题色** | deepPurple 种子色 |

## 已修复的问题

| 问题 | 解决方案 |
|------|----------|
| 类别筛选不生效 | 将 `mock_poses.dart` 中的 `category` 字段改为英文 ID |
| 布局渲染错误 | 将 `StaggeredGrid` 替换为 `GridView.builder` |
| 重复文件 | 删除未使用的 `search_bar.dart` |
| 无用依赖 | 移除 `flutter_staggered_grid_view` |

## 后续开发建议

1. **后端集成**: 替换 mock 数据，接入真实 RESTful API
2. **持久化存储**: 使用 `shared_preferences` 或 `hive` 实现收藏/历史记录本地存储
3. **AI 功能**: 接入真实图像识别模型 (如 Google ML Kit)
4. **图片资源**: 添加更多姿势图片至 `assets/images/`
5. **国际化**: 添加多语言支持 (`flutter_localizations`)
6. **主题切换**: 实现深色模式支持

## 调试与测试

```bash
# 代码分析
flutter analyze

# 运行测试
flutter test

# 清理构建缓存
flutter clean
flutter pub get

# 查看设备信息
flutter doctor -v
```

## 许可证

本项目仅供学习参考使用。
