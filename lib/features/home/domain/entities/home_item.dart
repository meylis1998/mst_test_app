import 'package:equatable/equatable.dart';

class HomeItem extends Equatable {
  const HomeItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconData,
    required this.color,
  });

  final String id;
  final String title;
  final String subtitle;
  final int iconData;
  final int color;

  @override
  List<Object?> get props => [id, title, subtitle, iconData, color];
}
