import '../models/pose_model.dart';
import '../models/pose_category.dart';
import '../data/mock_poses.dart';
import '../data/mock_categories.dart';

class PoseService {
  Future<List<Pose>> getAllPoses() async {
    // In a real app, this would fetch from an API or database
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    return mockPoses;
  }

  Future<List<Pose>> searchPoses(String query) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    return mockPoses
        .where((pose) =>
            pose.name.toLowerCase().contains(query.toLowerCase()) ||
            pose.description.toLowerCase().contains(query.toLowerCase()) ||
            pose.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase())) ||
            pose.category.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<Pose>> getPosesByCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    return mockPoses.where((pose) => pose.category == categoryId).toList();
  }

  Future<List<PoseCategory>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    return mockCategories;
  }

  Future<Pose> getPoseById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    return mockPoses.firstWhere((pose) => pose.id == id);
  }
}