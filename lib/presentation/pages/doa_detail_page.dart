import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalbu/domain/entities/doa.dart';
import 'package:qalbu/presentation/bloc/doa_detail/doa_detail_bloc.dart';
import 'package:qalbu/presentation/bloc/favorite_doa/favorite_doa_bloc.dart';

class DoaDetailPage extends StatefulWidget {
  static const routeName = '/doa-detail-page';

  final String id;

  const DoaDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DoaDetailPage> createState() => _DoaDetailPageState();
}

class _DoaDetailPageState extends State<DoaDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DoaDetailBloc>().add(GetDoaDetailEvent(widget.id));
      context.read<FavoriteDoaBloc>().add(GetStatusDoaEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kumpulan Doa'),
      ),
      body: BlocListener<FavoriteDoaBloc, FavoriteDoaState>(
        listener: (_, state) {
          if (state is FavoriteDoaSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            context.read<FavoriteDoaBloc>().add(GetStatusDoaEvent(widget.id));
          }
        },
        child: BlocBuilder<DoaDetailBloc, DoaDetailState>(
          builder: (context, state) {
            if (state is DoaDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DoaDetailLoaded) {
              final doa = state.result;
              bool isAddedToFavorite = (context.watch<FavoriteDoaBloc>().state is FavoriteDoaStatusLoaded) ? (context.read<FavoriteDoaBloc>().state as FavoriteDoaStatusLoaded).result : false;
              return SafeArea(
                child: DetailContent(
                  doa,
                  isAddedToFavorite
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'No Data',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final Doa doa;
  final bool isAddedFavorite;

  const DetailContent(this.doa, this.isAddedFavorite, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                doa.doa ?? '-',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                doa.ayat ?? '-',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  doa.latin ?? '-',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 10),
                Text(
                  doa.artinya ?? '-',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                onPressed: () async {
                  if (!isAddedFavorite) {
                    BlocProvider.of<FavoriteDoaBloc>(context).add(AddItemDoaEvent(doa));
                  } else {
                    BlocProvider.of<FavoriteDoaBloc>(context).add(RemoveItemDoaEvent(doa));
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isAddedFavorite
                        ? const Icon(Icons.bookmark)
                        : const Icon(Icons.bookmark_border),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
