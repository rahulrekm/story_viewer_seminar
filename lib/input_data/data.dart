import '../models/story_model.dart';
import '../models/user_model.dart';

final User user = User(
  name         : "Rahul",
  profileImage : "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg",
);

final List<Story> stories = [
  Story(
      url: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/cute-photos-of-cats-cuddling-1593203046.jpg",
      media: MediaType.image,
      duration: Duration(seconds: 5),
      user: user),

  Story(
      url: "https://vod-progressive.akamaized.net/exp=1666346397~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F4158%2F15%2F395792539%2F1682524664.mp4~hmac=a212056926cf703215eb452f36e87d8963e4c0e7946c2c512be36cb20c1def8a/vimeo-prod-skyfire-std-us/01/4158/15/395792539/1682524664.mp4",
      media: MediaType.video,
      duration: Duration(seconds: 5),
      user: user),

  Story(
      url: "https://oshiprint.in/image/data/poster/new/mqp1024.jpeg",
      media: MediaType.image,
      duration: Duration(seconds: 5),
      user: user),

  Story(
      url: "https://vod-progressive.akamaized.net/exp=1666332875~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F2674%2F20%2F513373860%2F2375645356.mp4~hmac=cc610234ebeaae7d2a4d71296bc993351977c218bcbd67fc494d937f0e6ebe0b/vimeo-prod-skyfire-std-us/01/2674/20/513373860/2375645356.mp4",
      media: MediaType.video,
      duration: Duration(seconds: 5),
      user: user),

  Story(
      url: "https://www.teahub.io/photos/full/18-183181_1080x1920-19-photos-of-wallpapers-puppy-awesome-cute.jpg",
      media: MediaType.image,
      duration: Duration(seconds: 5),
      user: user),
];