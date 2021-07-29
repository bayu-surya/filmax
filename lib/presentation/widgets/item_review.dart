import 'package:filmax/api_service.dart';
import 'package:filmax/domain/entities/review.dart';
import 'package:flutter/material.dart';

class ItemReview extends StatelessWidget {
  final Review review;

  const ItemReview({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        review.authorDetails != null && review.authorDetails!.avatarPath != null
            ? CircleAvatar(
                radius: 10,
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    ApiService.baseUrlImage + review.authorDetails!.avatarPath!,
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : CircleAvatar(
                radius: 10,
                backgroundColor: Colors.white,
              ),
        Container(
          width: 150,
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                review.createdAt.toString(),
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Text(
                review.author ?? "",
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Text(
                review.content ?? "",
                maxLines: 2,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
