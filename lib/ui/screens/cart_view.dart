import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jbk_task/data/cubits/charity_cubit/charity_cubit.dart';
import 'package:jbk_task/data/models/charity_model.dart';
import 'package:jbk_task/repositories/cart_repository.dart';
import 'package:jbk_task/utils/utils.dart';

import '../../data/cubits/cart_cubit/cart_cubit.dart';
import '../widgets/custom_appbar.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  static const routeName = '/cart-view';

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final _innerScrollController = ScrollController();

  final _outerScrollController = ScrollController();

  Widget createRichText(String key, String value) {
    return key.richText(
        12.semiBoldStyle.copyWith(fontFamily: 'Exo', color: Colors.white),
        [TextSpan(text: value)],
        textAlign: TextAlign.start);
  }

  List<Map<String, dynamic>> getNumberOfTickets(
      Charity charity, CartState cartState) {
    return cartState.cartItems
        .where((element) => element['id'] == charity.id)
        .toList();
  }

  ClipRRect _buildImage(Charity charity) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          height: 70,
          width: 70,
          child: Image.asset(
            charity.image,
            fit: BoxFit.contain,
          )),
    );
  }

  Container _buildJackpotContainer() {
    return Container(
      padding: const EdgeInsets.all(4),
      color: const Color.fromARGB(255, 56, 129, 165),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          createRichText('Jackpot: ', '1,000,000,000\$'),
          8.sizedBoxWidth(),
          createRichText('Next Draw: ', 'Jan 21 10:00PM'),
        ],
      ),
    );
  }

  Row _buildCharityImageAndName(
      Charity charity, CartState state, int numberOfTickets) {
    return Row(
      // crossAxisAlignment:
      //     CrossAxisAlignment.center,
      children: [
        _buildImage(charity),
        10.sizedBoxWidth(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              charity.name,
              maxLines: 2,
              style: 16.mediumStyle.copyWith(
                  color: Colors.black, overflow: TextOverflow.ellipsis),
            ),
            10.sizedBoxHeight(),
            'Entries: '.richText(
                12.mediumStyle.copyWith(fontFamily: 'Exo', color: Colors.grey),
                [TextSpan(text: numberOfTickets.toString())],
                textAlign: TextAlign.start),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CartRepository(),
      child: BlocProvider(
        create: (context) =>
            CartCubit(repository: context.read<CartRepository>()),
        child: Scaffold(
          appBar: const CustomAppbar(title: 'Order Summary'),
          body: Column(
            children: [
              _buildJackpotContainer(),
              Expanded(
                child: BlocBuilder<CharityCubit, CharityState>(
                  builder: (context, charityState) {
                    return BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return state.cartItems.isEmpty
                            ? const Center(
                                child: Text('No Items Found!'),
                              )
                            : Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        context.read<CartCubit>().deleteCart();
                                      },
                                      icon: const Icon(Icons.reset_tv)),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Scrollbar(
                                        controller: _outerScrollController,
                                        thumbVisibility:
                                            state.cartItemIds.length >= 3
                                                ? true
                                                : false,
                                        child: ListView.builder(
                                          // controller: _outerScrollController,
                                          itemCount: state.cartItemIds.length,
                                          itemBuilder: (context, index) {
                                            final charity = charityState
                                                .charities
                                                .firstWhere(
                                              (element) =>
                                                  element.id ==
                                                  state.cartItemIds[index],
                                            );

                                            final numberOfTickets =
                                                getNumberOfTickets(
                                                    charity, state);

                                            return Card(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxHeight: context.mediaQuery
                                                          .size.height *
                                                      .3,
                                                ),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                          'Charity Donation'),
                                                      const Divider(),
                                                      _buildCharityImageAndName(
                                                          charity,
                                                          state,
                                                          numberOfTickets
                                                              .length),
                                                      10.sizedBoxHeight(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              'Your Tickets: ${numberOfTickets.length}'),
                                                          TextButton(
                                                            onPressed: () {},
                                                            style: TextButton.styleFrom(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(0)),
                                                            child: const Text(
                                                                'Add Ticket+'),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        thickness: 2,
                                                        height: 2,
                                                        color: Colors
                                                            .grey.shade200,
                                                      ),
                                                      10.sizedBoxHeight(),
                                                      Expanded(
                                                        child: Scrollbar(
                                                          controller:
                                                              _innerScrollController,
                                                          thumbVisibility:
                                                              numberOfTickets
                                                                          .length >
                                                                      2
                                                                  ? true
                                                                  : false,
                                                          child: ListView
                                                              .separated(
                                                            // controller:
                                                            // _innerScrollController,
                                                            itemCount:
                                                                numberOfTickets
                                                                    .length,
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final ticketSet =
                                                                  numberOfTickets[
                                                                      index];

                                                              print(ticketSet);
                                                              return Row(
                                                                children: [
                                                                  Text(
                                                                    (index + 1)
                                                                        .toString(),
                                                                    style: 16
                                                                        .semiBoldStyle
                                                                        .copyWith(
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                  ),
                                                                  12.sizedBoxWidth(),
                                                                  Expanded(
                                                                    child: Row(
                                                                      children: ticketSet[
                                                                              'ticketNumbers']
                                                                          .map<Widget>((e) =>
                                                                              _buildWhiteNumberBox(e))
                                                                          .toList(),
                                                                    ),
                                                                  ),
                                                                  const Icon(
                                                                    Icons
                                                                        .shuffle_rounded,
                                                                    color: Colors
                                                                        .blue,
                                                                    size: 30,
                                                                  ),
                                                                  const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .blue,
                                                                    size: 30,
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                            separatorBuilder:
                                                                (context,
                                                                        index) =>
                                                                    10.sizedBoxHeight(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildWhiteNumberBox(String e) {
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -1),
                blurRadius: 3,
                blurStyle: BlurStyle.outer,
                spreadRadius: 1)
          ]),
      // padding: const EdgeInsets.all(12),
      child: Center(child: Text(e)),
    );
  }

  @override
  void dispose() {
    _innerScrollController.dispose();
    _outerScrollController.dispose();
    super.dispose();
  }
}
