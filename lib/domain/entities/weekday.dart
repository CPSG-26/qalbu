import 'package:equatable/equatable.dart';

class Weekday extends Equatable {
  const Weekday({
    required this.en,
  });

  final String en;

  @override
  List<Object?> get props => [en];
}
