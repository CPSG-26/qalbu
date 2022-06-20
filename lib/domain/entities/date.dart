import 'package:equatable/equatable.dart';
import 'package:qalbu/domain/entities/gregorian.dart';

class Date extends Equatable {
  const Date({required this.readable, required this.gregorian});

  final String readable;
  final Gregorian gregorian;

  @override
  List<Object?> get props => [readable, gregorian];
}
