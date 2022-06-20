import 'package:equatable/equatable.dart';

class Month extends Equatable {
  const Month({
    required this.number,
    required this.en,
  });

  final int number;
  final String en;

  @override
  List<Object?> get props => [number, en];
}
