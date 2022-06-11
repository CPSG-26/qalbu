import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qalbu/presentation/bloc/quran_detail/quran_detail_bloc.dart';
import 'package:qalbu/presentation/widgets/ayat_card.dart';

class QuranDetailPage extends StatefulWidget {
  static const routeName = 'al-quran-detail';

  final int id;

  const QuranDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<QuranDetailPage> createState() => _QuranDetailPageState();
}

class _QuranDetailPageState extends State<QuranDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<QuranDetailBloc>().add(FetchQuranDetail(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<QuranDetailBloc, QuranDetailState>(
          builder: (context, state) {
        if (state is QuranLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is QuranHasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.quran.namaLatin),
            ),
            body: AyatCard(quranDetail: state.quran),
          );
        } else {
          return const Text('Failed');
        }
      }),
    );
  }
}
