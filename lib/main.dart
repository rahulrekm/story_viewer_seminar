import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:story_viewer_seminar/animated_bar.dart';
import 'package:story_viewer_seminar/userInfo.dart';
import 'package:video_player/video_player.dart';

import 'input_data/data.dart';
import 'models/story_model.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home:  StoryScreen(stories: stories,),
    );
  }
}

class StoryScreen extends StatefulWidget {
  final List<Story> stories;
  const StoryScreen({super.key, required this.stories, });

  @override
  State<StoryScreen> createState() => _StoryScreenState();



}

class _StoryScreenState extends State<StoryScreen> with SingleTickerProviderStateMixin {

  late PageController _pageController;
  late VideoPlayerController _videoPlayerController;
  late AnimationController _animationController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(vsync: this);

    final Story firstStory = widget.stories.first;
    _loadStory(story: firstStory,animatedPage: false);

    _videoPlayerController = VideoPlayerController.network(widget.stories[1].url)
      ..initialize().then((_) => setState((){}));
    _videoPlayerController.play();

    _animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _animationController.stop();
        _animationController.reset();
        setState(() {
          if(_currentIndex + 1 < widget.stories.length){
            _currentIndex += 1;
            _loadStory(story: widget.stories[_currentIndex]);
          } else {
            _currentIndex = 0;
            _loadStory(story: widget.stories[_currentIndex]);
          }
        });
      }

    });

  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Story story = widget.stories[_currentIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details,story),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemCount: widget.stories.length,
              itemBuilder: (context,i) {
                switch(story.media){
                  case MediaType.image: return CachedNetworkImage(
                imageUrl: story.url,
                fit: BoxFit.cover,
                );
                  case MediaType.video:
                    if(_videoPlayerController != null &&
                    _videoPlayerController.value.isInitialized) {
                      return FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _videoPlayerController.value.size.width,
                          height: _videoPlayerController.value.size.height,
                          child: VideoPlayer(_videoPlayerController),
                        ),
                      );
                    }
                }
                return SizedBox.shrink();
              }),
            Positioned(
                top: 40.0,
                left: 10.0,
                right: 10.0,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: widget.stories
                          .asMap()
                                .map((i, e) {
                                  return MapEntry(
                                      i,
                                      Animated_Bar(
                                        animationController: _animationController,
                                        position: i,
                                        currentIndex: _currentIndex,
                                      ),);
                      }).values.toList(),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 1.5,vertical: 10.0),
                      child: UserInfo(user: story.user,),)
                  ],
                )
            ),
        ],
          
        ),
      ),

    );
  }

  _onTapDown(TapDownDetails details, story) {
   double screenwidth = MediaQuery.of(context).size.width;
   double dx = details.globalPosition.dx;

   if(dx < screenwidth / 3){
     setState(() {
       if(_currentIndex - 1 >= 0){
         _currentIndex -= 1;
          _loadStory(story: widget.stories[_currentIndex]);
       }
     });
   } else if (dx > 2 * screenwidth / 3){
     setState(() {
       if(_currentIndex + 1 < widget.stories.length){
         _currentIndex += 1;
          _loadStory(story: widget.stories[_currentIndex]);
       } else {
         _currentIndex = 0;
         _loadStory(story: widget.stories[_currentIndex]);
       }
     });
   } else {
     if(story.media == MediaType.video){
       if(_videoPlayerController.value.isPlaying){
         _videoPlayerController.pause();
         _animationController.stop();
       } else {
         _videoPlayerController.play();
         _animationController.forward();
       }
     }
   }
  }

  void _loadStory({ required Story story,  bool animatedPage = true}){
    _animationController.stop();
    _animationController.reset();

    switch (story.media){
      case MediaType.image :
        _animationController.duration = story.duration;
        _animationController.forward();
        break;

      case MediaType.video :
        _videoPlayerController != null;
        _videoPlayerController?.dispose();
        _videoPlayerController = VideoPlayerController.network(story.url)
                                  ..initialize().then((_) {
                                    setState(() { });
                                    if(_videoPlayerController.value.isInitialized){
                                      _animationController.duration = _videoPlayerController.value.duration;
                                      _videoPlayerController.play();
                                      _animationController.forward();
                                    }
                                  });
        break;
    }
    if(animatedPage){
      _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 1),
          curve: Curves.easeInOut);
    }
  }

}
