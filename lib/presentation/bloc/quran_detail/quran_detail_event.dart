part of 'quran_detail_bloc.dart';

abstract class QuranDetailEvent extends Equatable {
  const QuranDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchQuranDetail extends QuranDetailEvent {
  final int id;

  const FetchQuranDetail(this.id);

  @override
  List<Object> get props => [id];
}
