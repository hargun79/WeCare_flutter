import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FightBack extends StatefulWidget {
  @override
  _FightBackState createState() => _FightBackState();
}

class _FightBackState extends State<FightBack> {
  VideoPlayerController _controller1;
  VideoPlayerController _controller2;
  VideoPlayerController _controller3;
  VideoPlayerController _controller4;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller1 = VideoPlayerController.network(
        "https://thumbs.gfycat.com/FluffyFlashyCockroach-mobile.mp4");
    //_controller = VideoPlayerController.asset("assets/videos/ltfb1.mp4");
    _initializeVideoPlayerFuture = _controller1.initialize();
    _controller1.setLooping(true);
    _controller1.setVolume(1.0);
    _controller2 = VideoPlayerController.network(
        "https://thumbs.gfycat.com/MetallicBoilingGermanshorthairedpointer-mobile.mp4");
    //_controller = VideoPlayerController.asset("assets/videos/ltfb1.mp4");
    _initializeVideoPlayerFuture = _controller2.initialize();
    _controller2.setLooping(true);
    _controller2.setVolume(1.0);
    _controller3 = VideoPlayerController.network(
        "https://thumbs.gfycat.com/InnocentImpassionedBrocketdeer-mobile.mp4");
    //_controller = VideoPlayerController.asset("assets/videos/ltfb1.mp4");
    _initializeVideoPlayerFuture = _controller3.initialize();
    _controller3.setLooping(true);
    _controller3.setVolume(1.0);
    _controller4 = VideoPlayerController.network(
        "https://thumbs.gfycat.com/FrenchFatGalapagosmockingbird-mobile.mp4");
    //_controller = VideoPlayerController.asset("assets/videos/ltfb1.mp4");
    _initializeVideoPlayerFuture = _controller4.initialize();
    _controller4.setLooping(true);
    _controller4.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Learn to fight back',
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
              width: 20,
            ),
            Text(
              'Learn how to defend yourself in dangerous situations :',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
              width: 20,
            ),
            Text(
              '1. Using your car keys is one of the easiest ways to defend yourself.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
              width: 10,
            ),
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: AspectRatio(
                      aspectRatio: _controller1.value.aspectRatio,
                      child: VideoPlayer(_controller1),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            FlatButton(
              child: Text('Play/Pause'),
              color: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.blue)),
              onPressed: () {
                setState(() {
                  if (_controller1.value.isPlaying) {
                    _controller1.pause();
                  } else {
                    _controller1.play();
                  }
                });
              },
            ),
            SizedBox(
              height: 10,
              width: 10,
            ),
            Text(
              '2. If someone is coming at you from the front, a groin kick may deliver enough force to paralyze your attacker, making your escape possible.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
              width: 10,
            ),
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: AspectRatio(
                      aspectRatio: _controller2.value.aspectRatio,
                      child: VideoPlayer(_controller2),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            FlatButton(
              child: Text('Play/Pause'),
              color: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.blue)),
              onPressed: () {
                setState(() {
                  if (_controller2.value.isPlaying) {
                    _controller2.pause();
                  } else {
                    _controller2.play();
                  }
                });
              },
            ),
            SizedBox(
              height: 10,
              width: 10,
            ),
            Text(
              '3. This move can cause damage to the nose or throat. To execute, get in front of your attacker as much as is possible.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
              width: 10,
            ),
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: AspectRatio(
                      aspectRatio: _controller3.value.aspectRatio,
                      child: VideoPlayer(_controller3),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            FlatButton(
              child: Text('Play/Pause'),
              color: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.blue)),
              onPressed: () {
                setState(() {
                  if (_controller3.value.isPlaying) {
                    _controller3.pause();
                  } else {
                    _controller3.play();
                  }
                });
              },
            ),
            SizedBox(
              height: 10,
              width: 10,
            ),
            Text(
              '4. If your attacker is in close range and you’re unable to get enough momentum to throw a strong punch or kick, use your elbows.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
              width: 10,
            ),
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: AspectRatio(
                      aspectRatio: _controller4.value.aspectRatio,
                      child: VideoPlayer(_controller4),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            FlatButton(
              child: Text('Play/Pause'),
              color: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.blue)),
              onPressed: () {
                setState(() {
                  if (_controller4.value.isPlaying) {
                    _controller4.pause();
                  } else {
                    _controller4.play();
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
