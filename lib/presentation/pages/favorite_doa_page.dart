import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qalbu/common/utils.dart';
import 'package:qalbu/presentation/bloc/favorite_doa/favorite_doa_bloc.dart';
import 'package:qalbu/presentation/widgets/doa_widget.dart';

class FavoriteDoaPage extends StatefulWidget {
  static const routeName = '/favorite-doa-page';

  const FavoriteDoaPage({Key? key}) : super(key: key);

  @override
  _FavoriteDoaPageState createState() => _FavoriteDoaPageState();
}

class _FavoriteDoaPageState extends State<FavoriteDoaPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<FavoriteDoaBloc>().add(GetListEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<FavoriteDoaBloc>().add(GetListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disimpan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<FavoriteDoaBloc, FavoriteDoaState>(
          builder: (context, state) {
            if (state is FavoriteDoaLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FavoriteDoaLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final doa = state.result[index];
                  return DoaWidget(doa);
                },
                itemCount: state.result.length,
              );
            } else if (state is FavoriteDoaEmpty) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              );
            } else if (state is FavoriteDoaError) {
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
