import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/cubits/charity_cubit/charity_cubit.dart';
import 'repositories/charity_repository.dart';
import 'utils/utils.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => CharityRepository(),
        ),
        // RepositoryProvider(
        //   create: (context) => CartRepository(),
        // ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  CharityCubit(repository: context.read<CharityRepository>()),
            ),
            //  BlocProvider(
            //   create: (context) =>
            //       CartCubit(repository: context.read<CartRepository>()),
            // ),
          ],
          child: MaterialApp(
            restorationScopeId: 'app',
            onGenerateRoute: RouteManager.onGenerateRoute,
            theme: ThemeData(
              fontFamily: 'Exo',
            ),
          )),
    );
  }
}
