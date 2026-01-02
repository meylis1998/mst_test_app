import 'package:flutter/material.dart';
import 'package:mst_test_app/features/home/domain/entities/home_item.dart';

abstract class HomeLocalDatasource {
  Future<List<HomeItem>> getItems();

  Future<List<HomeItem>> refreshItems();
}

class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  HomeLocalDatasourceImpl();

  final List<HomeItem> _mockItems = const [
    HomeItem(
      id: '1',
      title: 'Getting Started',
      subtitle: 'Learn the basics of our app',
      icon: Icons.rocket_launch,
      color: 0xFF6200EE,
    ),
    HomeItem(
      id: '2',
      title: 'Your Profile',
      subtitle: 'Manage your account settings',
      icon: Icons.person,
      color: 0xFF03DAC6,
    ),
    HomeItem(
      id: '3',
      title: 'Notifications',
      subtitle: 'Stay updated with alerts',
      icon: Icons.notifications,
      color: 0xFFFF9800,
    ),
    HomeItem(
      id: '4',
      title: 'Analytics',
      subtitle: 'Track your progress',
      icon: Icons.analytics,
      color: 0xFF2196F3,
    ),
    HomeItem(
      id: '5',
      title: 'Documents',
      subtitle: 'Access your files',
      icon: Icons.folder,
      color: 0xFF4CAF50,
    ),
    HomeItem(
      id: '6',
      title: 'Messages',
      subtitle: 'Chat with your team',
      icon: Icons.chat,
      color: 0xFFE91E63,
    ),
    HomeItem(
      id: '7',
      title: 'Calendar',
      subtitle: 'Schedule your events',
      icon: Icons.calendar_month,
      color: 0xFF9C27B0,
    ),
    HomeItem(
      id: '8',
      title: 'Tasks',
      subtitle: 'Manage your to-do list',
      icon: Icons.checklist,
      color: 0xFF00BCD4,
    ),
    HomeItem(
      id: '9',
      title: 'Reports',
      subtitle: 'View detailed insights',
      icon: Icons.bar_chart,
      color: 0xFFFF5722,
    ),
    HomeItem(
      id: '10',
      title: 'Settings',
      subtitle: 'Customize your experience',
      icon: Icons.settings,
      color: 0xFF607D8B,
    ),
    HomeItem(
      id: '11',
      title: 'Help Center',
      subtitle: 'Get support when you need it',
      icon: Icons.help,
      color: 0xFF795548,
    ),
    HomeItem(
      id: '12',
      title: 'Premium Features',
      subtitle: 'Explore exclusive content',
      icon: Icons.workspace_premium,
      color: 0xFFFFD700,
    ),
  ];

  @override
  Future<List<HomeItem>> getItems() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return _mockItems;
  }

  @override
  Future<List<HomeItem>> refreshItems() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return _mockItems;
  }
}
