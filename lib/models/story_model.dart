import 'package:flutter/cupertino.dart';
import 'package:story_viewer_seminar/models/user_model.dart';

enum MediaType{
  image,                  // enum mediatype to identify whether a story is image or video
  video,
}

class Story{
  final String url;     // Each story needs direct url
  final MediaType media;   //mediatype
  final Duration duration;  // duration for each story
  final User user;          // user details

  const Story({
  required this.url,
  required this.media,
  required this.duration,
  required this.user,
});

}