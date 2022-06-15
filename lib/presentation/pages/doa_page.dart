import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qalbu/presentation/bloc/doa_list/doa_list_bloc.dart';
import 'package:qalbu/presentation/pages/favorite_doa_page.dart';
import 'package:qalbu/presentation/widgets/doa_widget.dart';

class DoaPage extends StatefulWidget {
  static const routeName = '/doa-page';

  const DoaPage({Key? key}) : super(key: key);

  @override
  State<DoaPage> createState() => _DoaPageState();
}

class _DoaPageState extends State<DoaPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DoaListBloc>().add(GetDoaListEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kumpulan Doa'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoriteDoaPage()));
            },
            icon: const Icon(
              Icons.bookmark,
              size: 32,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<DoaListBloc, DoaListState>(
          builder: (context, state) {
            if (state is DoaListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DoaListLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final doa = state.result[index];
                  return DoaWidget(doa);
                },
                itemCount: state.result.length,
              );
            } else if (state is DoaListEmpty) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              );
            } else if (state is DoaListError) {
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
          },
        ),
      ),
    );
  }
}