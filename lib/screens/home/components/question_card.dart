import 'package:flutter/material.dart';
import 'package:question_maker_app/screens/home/services/question_service.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:like_button/like_button.dart';

class QuestionCard extends StatefulWidget {

  late String? id;
  late String? question;
  late String? username;
  late String? usernamePhotoUrl;
  late int? likeCount;
  late bool? isLiked;

  QuestionCard({
    super.key,
    required this.id,
    required this.question,
    required this.username,
    required this.usernamePhotoUrl,
    required this.likeCount,
    required this.isLiked
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  // bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: Theme.of(context).highlightColor,
          width: 3
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(7),
                    child: CircleAvatar(
                      maxRadius: 15,
                      child: widget.usernamePhotoUrl != null ? Image.network(widget.usernamePhotoUrl!) : RandomAvatar(widget.username ?? widget.id ?? ""),
                    ),
                  ),
                  Text(widget.username ?? "Anônimo")
                ],
              ),
              LikeButton(
                likeCount: widget.likeCount,
                likeBuilder: ((isLiked) => Icon(
                  Icons.thumb_up,
                  color: isLiked ? Colors.blue : Colors.grey,
                  size: 20,
                )),
                isLiked: widget.isLiked,
                onTap: (isLiked) async {
                  await QuestionService(context).handleLike(widget.id!);
                  return !isLiked;
                }
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.question ?? "..."),
          )
        ],
      )
    );
  }
}