import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qalbu/presentation/bloc/quran/quran_bloc.dart';
import 'package:qalbu/presentation/widgets/quran_list.dart';

class QuranPage extends StatefulWidget {
  static const routeName = 'al-quran';

  const QuranPage({Key? key}) : super(key: key);

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<QuranBloc>().add(FetchQuranList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Al-Quran'),
        ),
        body: BlocBuilder<QuranBloc, QuranState>(builder: (context, state) {
          if (state is QuranLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuranHasData) {
            return QuranList(quranList: state.quranList);
          } else if (state is QuranError) {
            return Center(
              key: const Key('error_message'),
              child: Text(
                state.message,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
