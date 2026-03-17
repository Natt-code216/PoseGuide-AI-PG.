import 'package:flutter/material.dart';
import '../models/pose_model.dart';
import '../models/pose_category.dart';
import '../services/pose_service.dart';
import '../widgets/pose_grid_item.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/category_filter.dart';
import 'user_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PoseService _poseService = PoseService();
  final TextEditingController _searchController = TextEditingController();
  List<Pose> _poses = [];
  List<PoseCategory> _categories = [];
  String? _selectedCategoryId;
  String _searchQuery = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      final posesFuture = _poseService.getAllPoses();
      final categoriesFuture = _poseService.getCategories();

      final poses = await posesFuture;
      final categories = await categoriesFuture;

      setState(() {
        _poses = poses;
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading data: $e');
    }
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty && _selectedCategoryId == null) {
      _loadInitialData();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      List<Pose> results = [];

      if (_selectedCategoryId != null) {
        final categoryPoses = await _poseService.getPosesByCategory(_selectedCategoryId!);
        if (query.isNotEmpty) {
          results = categoryPoses.where((pose) =>
            pose.name.toLowerCase().contains(query.toLowerCase()) ||
            pose.description.toLowerCase().contains(query.toLowerCase()) ||
            pose.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()))
          ).toList();
        } else {
          results = categoryPoses;
        }
      } else if (query.isNotEmpty) {
        results = await _poseService.searchPoses(query);
      }

      setState(() {
        _poses = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error searching: $e');
    }
  }

  void _onCategorySelected(String? categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
    });
    _performSearch(_searchQuery);
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      child: Row(
        children: [
          // Logo
          Expanded(
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'PG. ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  TextSpan(
                    text: '灵感快门',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // User Avatar
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserProfileScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                size: 24,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          CustomSearchBar(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
              // 添加防抖机制，避免频繁搜索
              Future.delayed(const Duration(milliseconds: 500), () {
                if (_searchQuery == value) {
                  _performSearch(value);
                }
              });
            },
          ),
          CategoryFilter(
            categories: _categories,
            selectedCategoryId: _selectedCategoryId,
            onCategorySelected: _onCategorySelected,
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _poses.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sentiment_dissatisfied,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              '没有找到相关姿势',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadInitialData,
                        child: GridView.builder(
                          padding: const EdgeInsets.all(8.0),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: _poses.length,
                          itemBuilder: (context, index) {
                            return PoseGridItem(pose: _poses[index]);
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}