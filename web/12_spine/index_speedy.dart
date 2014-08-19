import 'dart:html';
import 'dart:math';
import 'package:pixi_dart/pixi.dart' as pixi;

class SpeedyDemo {
  pixi.Stage stage;
  pixi.Renderer renderer;
  pixi.Spine speedy;
  pixi.Text help;
  String atlasUrl = 'data/speedy/speedy.atlas';

  int animationIndex = 0;
  List<String> animations = ['run-rough', 'run', 'run-linear'];

  SpeedyDemo() {
    // Create a list of assets to load.
    var assetsToLoad = [atlasUrl];

    // Create a new loader.
    var loader = new pixi.AssetLoader(assetsToLoad);

    // Use callback.
    loader.onComplete.listen(onAssetsLoaded);

    // Begin load.
    loader.load();

    // Create an new instance of a pixi stage.
    stage = new pixi.Stage(pixi.Color.darkOliveGreen);

    // Create a renderer instance.
    //renderer = new pixi.CanvasRenderer();
    //renderer = new pixi.WebGLRenderer();
    renderer = new pixi.Renderer.autoDetect();

    // Set the canvas width and height to fill the screen.
    renderer.view.style.display = 'block';

    // Add the renderer view element to the DOM.
    document.body.append(renderer.view);

    window.animationFrame.then(animate);
  }

  void onAssetsLoaded(CustomEvent event) {
    // Create a speedy guy.
    speedy = new pixi.Spine(atlasUrl);

    // Create a help text.
    var textStyle = new pixi.TextStyle()..font = 'bold 12pt Arial';
    help = new pixi.Text('Click to change animation.', textStyle);
    help.anchor.x = 0.5;

    resize();

    // Set up the mixes!
    speedy.stateData.setMixByName('run-linear', 'run-rough', 0.2);
    speedy.stateData.setMixByName('run-rough', 'run', 0.2);
    speedy.stateData.setMixByName('run', 'run-linear', 0.2);

    // Play animation.
    speedy.state.setAnimationByName(0, animations.last, true);

    // Add the speedy guy to the stage.
    stage.addChild(speedy);

    // Add the help text to the stage.
    stage.addChild(help);

    stage.onClick.listen((event) {
      // Change animation.
      animationIndex %= animations.length;
      speedy.state.setAnimationByName(0, animations[animationIndex++], true);
    });

    stage.onTap.listen((event) {
      // Change animation.
      animationIndex %= animations.length;
      speedy.state.setAnimationByName(0, animations[animationIndex++], true);
    });
  }

  void resize([Event event]) {
    if (speedy != null) {
      // Keep aspect ratio.
      double scale = min(window.innerWidth / 300, window.innerHeight / 400);

      // Set the speedy guy position.
      speedy.position.x = window.innerWidth / 2;
      speedy.position.y = window.innerHeight - (window.innerHeight / 12);

      // Set the speedy guy scale.
      speedy.scale.x = speedy.scale.y = scale;

      // Set the help text position.
      help.position.x = window.innerWidth / 2;
      help.position.y = window.innerHeight - (window.innerHeight / 17);

      // Set the help text scale.
      help.scale.x = help.scale.y = scale;
    }

    renderer.resize(window.innerWidth, window.innerHeight);
  }

  void animate(num value) {
    // Render the stage.
    renderer.render(stage);

    window.animationFrame.then(animate);
  }
}

void main() {
  var demo = new SpeedyDemo();

  window.onResize.listen(demo.resize);
  window.onDeviceOrientation.listen(demo.resize);
}
