part of 'quran_detail_bloc.dart';

abstract class QuranDetailState extends Equatable {
  const QuranDetailState();

  @override
  List<Object> get props => [];
}

class QuranEmpty extends QuranDetailState {}

class QuranLoading extends QuranDetailState {}

class QuranHasData extends QuranDetailState {
  final QuranDetail quran;

  const QuranHasData(this.quran);

  @override
  List<Object> get props => [quran];
}

class QuranError extends QuranDetailState {
  final String message;

  const QuranError(this.message);

  @override
  List<Object> get props => [message];
}
