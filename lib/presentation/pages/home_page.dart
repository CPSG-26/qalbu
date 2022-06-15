import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalbu/presentation/bloc/doa_list/doa_list_bloc.dart';
import 'package:qalbu/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:qalbu/presentation/widgets/doa_widget.dart';
import 'package:qalbu/presentation/widgets/menu_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: CustomScrollView(
        slivers: [
          const SliverPersistentHeader(
            delegate: CustomSliverAppBarDelegate(
              expandedHeight: 204
            ),
            pinned: true,
          ),
          buildSliver(context)
        ],
      ),
    );
  }

  Widget buildSliver(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 56, right: 8, bottom: 8, left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const MenuWidget(),
            const SizedBox(height: 4),
            Text(
              'Rekomendasi Doa',
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(height: 2),
            SizedBox(
              height: 600,
              child: buildDoaRecommendation(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDoaRecommendation(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DoaListBloc, DoaListState>(
        builder: (context, state) {
          if (state is DoaListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DoaListLoaded) {
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final doa = state.result[index];
                  return DoaWidget(doa);
                },
                itemCount: 10,
              ),
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
    );
  }
}
