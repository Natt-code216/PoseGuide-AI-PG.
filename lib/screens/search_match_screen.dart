import 'package:flutter/material.dart';
import '../models/pose_model.dart';
import '../services/pose_service.dart';
import '../widgets/pose_card.dart';
import '../widgets/custom_search_bar.dart';

class SearchMatchScreen extends StatefulWidget {
  const SearchMatchScreen({super.key});

  @override
  State<SearchMatchScreen> createState() => _SearchMatchScreenState();
}

class _SearchMatchScreenState extends State<SearchMatchScreen> {
  final PoseService _poseService = PoseService();
  final TextEditingController _searchController = TextEditingController();
  List<Pose> _searchResults = [];
  bool _isLoading = false;
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    if (_lastQuery == query) {
      // Same query, no need to search again
      return;
    }

    setState(() {
      _isLoading = true;
      _lastQuery = query;
    });

    try {
      final results = await _poseService.searchPoses(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error searching: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('搜索时发生错误')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('搜索姿势'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CustomSearchBar(
            controller: _searchController,
            hintText: '输入关键词搜索姿势...',
            onChanged: (value) {
              // 实现防抖搜索
              Future.delayed(const Duration(milliseconds: 500), () {
                if (_searchController.text == value) {
                  _performSearch(value);
                }
              });
            },
            onSubmitted: _performSearch,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _searchResults.isEmpty && _searchController.text.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 80,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 24),
                            Text(
                              '请输入关键词搜索姿势',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : _searchResults.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.sentiment_dissatisfied,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 24),
                                Text(
                                  '没有找到相关姿势',
                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () => _performSearch(_searchController.text),
                            child: GridView.builder(
                              padding: const EdgeInsets.all(8.0),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: _searchResults.length,
                              itemBuilder: (context, index) {
                                return PoseCard(pose: _searchResults[index]);
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