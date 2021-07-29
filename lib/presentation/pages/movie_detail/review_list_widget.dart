import 'package:filmax/presentation/bloc/review/review_bloc.dart' as review;
import 'package:filmax/presentation/widgets/item_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewListWidget extends StatelessWidget {
  const ReviewListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.7,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocBuilder<review.ReviewBloc, review.ReviewState>(
          builder: (context, stateReview) {
            if (stateReview is review.Empty) {
              return Center(child: Text('empty'));
            } else if (stateReview is review.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (stateReview is review.Loaded) {
              return LimitedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 3.0),
                        itemCount: stateReview.data.length,
                        itemBuilder: (context, index) {
                          return ItemReview(
                            review: stateReview.data[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (stateReview is review.Error) {
              return Center(child: Text('error'));
            } else {
              return Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
