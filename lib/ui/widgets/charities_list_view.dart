import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jbk_task/ui/screens/detail_view.dart';

import '../../data/cubits/charity_cubit/charity_cubit.dart';
import '../../data/models/charity_model.dart';
import '../../utils/extensions.dart';
import '../../utils/utility_functions.dart';
import 'custom_trackshape.dart';

class CharitiesListView extends StatelessWidget {
  const CharitiesListView({Key? key}) : super(key: key);

  getColor(Charity charity) {
    switch (charity.id) {
      case 1:
        return Colors.orange.shade300;
      case 2:
        return Colors.purple.shade300;
      case 3:
        return Colors.green.shade300;
      case 4:
        return Colors.red.shade300;
    }
  }

  Column _buildKeyValueColumn({required String label, required String value}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: 12.regularStyle.copyWith(color: Colors.white),
        ),
        2.sizedBoxHeight(),
        Text(
          value,
          style: 14.mediumStyle.copyWith(
                color: Colors.white,
              ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: BlocBuilder<CharityCubit, CharityState>(
        builder: (context, state) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final charity = state.charities[index];
              final percentage = calculatePercentage(
                  charity.raised.toDouble(), charity.goals.toDouble());
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, DetailView.routeName,
                    arguments: charity),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      color: getColor(charity),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                height: 70,
                                width: 70,
                                child: Image.asset(
                                  charity.image,
                                  fit: BoxFit.contain,
                                )),
                          ),
                          12.sizedBoxWidth(),
                          Expanded(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  charity.name,
                                  maxLines: 1,
                                  style: 16.mediumStyle.copyWith(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                14.sizedBoxHeight(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _buildKeyValueColumn(
                                        label: 'Goals',
                                        value: '\$${charity.goals.toString()}'),
                                    (context.mediaQuery.size.width * .1)
                                        .sizedBoxWidth(),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      width: 1,
                                      height: 30,
                                      color: Colors.white,
                                    ),
                                    _buildKeyValueColumn(
                                        label: 'Raised',
                                        value:
                                            '\$${charity.raised.toString()}'),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      16.sizedBoxHeight(),
                      Row(
                        children: [
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                  trackShape: CustomTrackShape(),
                                  thumbShape: CustomSliderThumbShape(),
                                  overlayShape: SliderComponentShape.noOverlay),
                              child: Slider(
                                value: percentage / 100,
                                onChanged: (_) {},
                                inactiveColor: Colors.white,
                              ),
                            ),
                          ),
                          10.sizedBoxWidth(),
                          Text(
                            '${percentage.toInt()}%',
                            style:
                                14.regularStyle.copyWith(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => 8.sizedBoxHeight(),
            itemCount: state.charities.length,
          );
        },
      ),
    );
  }
}
