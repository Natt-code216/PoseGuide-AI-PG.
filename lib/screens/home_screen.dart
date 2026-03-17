import 'package:flutter/material.dart';
import '../models/pose_model.dart';
import '../models/pose_category.dart';
import '../services/pose_service.dart';
import '../widgets/pose_card.dart';
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
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'PG. ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                      fontStyle: FontStyle.italic,
                      letterSpacing: -0.5,
                    ),
                  ),
                  TextSpan(
                    text: '灵感快门',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
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
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE1BEE7), Color(0xFFCE93D8)],
                ),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 20,
                  color: Colors.black87,
                ),
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
      backgroundColor: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
      ).colors[0],
      body: Column(
        children: [
          _buildHeader(),
          CustomSearchBar(
            controller: _searchController,
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
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sentiment_dissatisfied,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '没有找到相关姿势',
                              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadInitialData,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: _poses.length,
                            itemBuilder: (context, index) {
                              return PoseCard(pose: _poses[index]);
                            },
                          ),
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
