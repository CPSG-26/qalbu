import 'package:equatable/equatable.dart';
import 'package:qalbu/domain/entities/date.dart';
import 'package:qalbu/domain/entities/timings.dart';

class Datum extends Equatable {
  const Datum({
    required this.timings,
    required this.date,
  });

  final Timings timings;
  final Date date;

  @override
  List<Object?> get props => [timings, date];
}
