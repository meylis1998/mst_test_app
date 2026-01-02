import 'package:flutter/material.dart';
import 'package:mst_test_app/features/home/domain/entities/home_item.dart';

abstract class HomeLocalDatasource {
  Future<List<HomeItem>> getItems();

  Future<List<HomeItem>> refreshItems();
}

class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  HomeLocalDatasourceImpl();

  final List<HomeItem> _mockItems = [
    HomeItem(
      id: '1',
      title: 'Getting Started',
      subtitle: 'Learn the basics of our app',
      iconData: Icons.rocket_launch.codePoint,
      color: 0xFF6200EE,
    ),
    HomeItem(
      id: '2',
      title: 'Your Profile',
      subtitle: 'Manage your account settings',
      iconData: Icons.person.codePoint,
      color: 0xFF03DAC6,
    ),
    HomeItem(
      id: '3',
      title: 'Notifications',
      subtitle: 'Stay updated with alerts',
      iconData: Icons.notifications.codePoint,
      color: 0xFFFF9800,
    ),
    HomeItem(
      id: '4',
      title: 'Analytics',
      subtitle: 'Track your progress',
      iconData: Icons.analytics.codePoint,
      color: 0xFF2196F3,
    ),
    HomeItem(
      id: '5',
      title: 'Documents',
      subtitle: 'Access your files',
      iconData: Icons.folder.codePoint,
      color: 0xFF4CAF50,
    ),
    HomeItem(
      id: '6',
      title: 'Messages',
      subtitle: 'Chat with your team',
      iconData: Icons.chat.codePoint,
      color: 0xFFE91E63,
    ),
    HomeItem(
      id: '7',
      title: 'Calendar',
      subtitle: 'Schedule your events',
      iconData: Icons.calendar_month.codePoint,
      color: 0xFF9C27B0,
    ),
    HomeItem(
      id: '8',
      title: 'Tasks',
      subtitle: 'Manage your to-do list',
      iconData: Icons.checklist.codePoint,
      color: 0xFF00BCD4,
    ),
    HomeItem(
      id: '9',
      title: 'Reports',
      subtitle: 'View detailed insights',
      iconData: Icons.bar_chart.codePoint,
      color: 0xFFFF5722,
    ),
    HomeItem(
      id: '10',
      title: 'Settings',
      subtitle: 'Customize your experience',
      iconData: Icons.settings.codePoint,
      color: 0xFF607D8B,
    ),
    HomeItem(
      id: '11',
      title: 'Help Center',
      subtitle: 'Get support when you need it',
      iconData: Icons.help.codePoint,
      color: 0xFF795548,
    ),
    HomeItem(
      id: '12',
      title: 'Premium Features',
      subtitle: 'Explore exclusive content',
      iconData: Icons.workspace_premium.codePoint,
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
