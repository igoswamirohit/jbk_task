import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jbk_task/data/cubits/charity_cubit/charity_cubit.dart';
import 'package:jbk_task/ui/screens/cart_view.dart';

import '../widgets/charities_list_view.dart';
import '../widgets/custom_appbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  static const routeName = '/';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context.read<CharityCubit>().getCharities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromRGBO(242, 244, 249, 1),
      appBar: CustomAppbar(title: 'Charities', actions: [
        IconButton(
            onPressed: () => Navigator.pushNamed(context, CartView.routeName),
            icon: const Icon(
              Icons.shopping_cart,
            ))
      ]),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CharitiesListView(),
      ),
    );
  }
}
