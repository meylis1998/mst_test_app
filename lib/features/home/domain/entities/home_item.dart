import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class HomeItem extends Equatable {
  const HomeItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final int color;

  @override
  List<Object?> get props => [id, title, subtitle, icon, color];
}
