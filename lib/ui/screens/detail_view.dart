import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jbk_task/data/cubits/tickets_cubit/ticket_cubit.dart';
import 'package:jbk_task/ui/screens/cart_view.dart';
import 'package:jbk_task/ui/widgets/custom_appbar.dart';
import 'package:jbk_task/utils/extensions.dart';
import 'package:jbk_task/utils/utility_functions.dart';

import '../../data/models/charity_model.dart';
import '../../repositories/ticket_repository.dart';
import '../widgets/custom_btns.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  static const routeName = '/detail-view';

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  Container _buildNumberBox(TicketState state, int index) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: state.selectedTickets.contains((index + 1).toString())
            ? Colors.blue
            : const Color.fromRGBO(242, 244, 249, 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        (index + 1).toString(),
        style: 16.mediumStyle.copyWith(
              color: state.selectedTickets.contains((index + 1).toString())
                  ? Colors.white
                  : Colors.black,
            ),
      ),
    );
  }

  Container _buildWhiteNumberBox(String e) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
          child: Text(
        e,
        style: 16.mediumStyle,
      )),
    );
  }

  Dialog _buildDialog(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 39,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/invoice.png',
                    scale: 8,
                  ),
                  10.sizedBoxHeight(),
                  Text(
                    'Ticket added in your cart',
                    style: 16.semiBoldStyle,
                  ),
                  2.sizedBoxHeight(),
                  'You can check your ticket '.richText(
                      14
                          .mediumStyle
                          .copyWith(fontFamily: 'Exo', color: Colors.black),
                      [
                        TextSpan(
                          text: 'here',
                          style: 14.mediumStyle.copyWith(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  CartView.routeName,
                                  (route) => route.settings.name == '/');
                              // Navigator.pop(context);
                              // Navigator.pushReplacementNamed(
                              //     context, CartView.routeName);
                            },
                        )
                      ],
                      textAlign: TextAlign.left),
                  25.sizedBoxHeight(),
                  SizedBox(
                    width: double.infinity,
                    child: CustomOutlinedBtn(
                        onClick: () {}, label: 'Purchase another ticket'),
                  ),
                  4.sizedBoxHeight(),
                  SizedBox(
                    width: double.infinity,
                    child: CustomOutlinedBtn(onClick: () {}, label: 'Checkout'),
                  )
                ],
              )),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(242, 244, 249, 1),
              ),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Charity?;
    return RepositoryProvider(
      create: (context) => TicketRepository(),
      child: BlocProvider(
        create: (context) => TicketCubit(List.filled(5, ''),
            repository: context.read<TicketRepository>()),
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(242, 244, 249, 1),
          appBar: CustomAppbar(title: 'Play', actions: [
            IconButton(
                onPressed: () =>
                    Navigator.popAndPushNamed(context, CartView.routeName),
                icon: const Icon(
                  Icons.shopping_cart,
                ))
          ]),
          body:
              BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
            return Column(
              children: [
                SizedBox(
                  height: context.mediaQuery.size.height * .3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pick your 5 Numbers',
                        style: 16.semiBoldStyle.copyWith(color: Colors.black54),
                      ),
                      16.sizedBoxHeight(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...state.selectedTickets
                              .map<Widget>((e) => _buildWhiteNumberBox(e))
                              .toList(),
                          6.sizedBoxWidth(),
                          IconButton(
                            onPressed: () {
                              context.read<TicketCubit>().setRandomNumbers();
                            },
                            icon: const Icon(
                              Icons.shuffle_rounded,
                              color: Colors.blue,
                              size: 30,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            offset: const Offset(0, -10),
                            blurRadius: 20,
                            spreadRadius: 1,
                          )
                        ]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: CustomOutlinedBtn(
                              label: 'Clear',
                              onClick: () {
                                context.read<TicketCubit>().clear();
                              },
                            )),
                            12.sizedBoxWidth(),
                            Expanded(
                                child: CustomOutlinedBtn(
                              label: 'Add to Cart',
                              onClick: () async {
                                if (state.selectedTickets.contains('')) {
                                  showSnackbar(context,
                                      msg: 'Please select all 5 numbers');
                                  return;
                                }
                                await context
                                    .read<TicketCubit>()
                                    .addToCart(arguments?.id);
                                showDialog(
                                  context: context,
                                  builder: (context) => _buildDialog(context),
                                );
                              },
                            ))
                          ],
                        ),
                        16.sizedBoxHeight(),
                        Expanded(
                          child: GridView.builder(
                            itemCount: 36,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              childAspectRatio: 1.0,
                              mainAxisSpacing: 14,
                              crossAxisSpacing: 14,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  final response = context
                                      .read<TicketCubit>()
                                      .addNumber(index + 1);
                                  if (response != null) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(response),
                                      duration: 1.seconds,
                                    ));
                                  }
                                },
                                child: _buildNumberBox(state, index),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
