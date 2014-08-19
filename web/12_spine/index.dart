import 'dart:html';
import 'dart:math';
import 'package:pixi_dart/pixi.dart' as pixi;

class SpineBoyDemo {
  pixi.Stage stage;
  pixi.Renderer renderer;
  pixi.Spine spineBoy;
  pixi.Text help;
  String atlasUrl = 'data/spineboy/spineboy.atlas';

  SpineBoyDemo() {
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
    // Create a spine boy.
    spineBoy = new pixi.Spine(atlasUrl);

    // Create a help text.
    var textStyle = new pixi.TextStyle()..font = 'bold 12pt Arial';
    help = new pixi.Text('Click to change animation.', textStyle);
    help.anchor.x = 0.5;

    resize();

    // Set up the mixes!
    spineBoy.stateData.setMixByName('walk', 'jump', 0.2);
    spineBoy.stateData.setMixByName('jump', 'walk', 0.2);

    // Play animation.
    spineBoy.state.setAnimationByName(0, 'walk', true);

    // Add the spine boy to the stage.
    stage.addChild(spineBoy);

    // Add the help text to the stage.
    stage.addChild(help);

    stage.onClick.listen((event) {
      spineBoy.state.setAnimationByName(0, 'jump', false);
      spineBoy.state.addAnimationByName(0, 'walk', true, 0.0);
    });

    stage.onTap.listen((event) {
      spineBoy.state.setAnimationByName(0, 'jump', false);
      spineBoy.state.addAnimationByName(0, 'walk', true, 0.0);
    });
  }

  void resize([Event event]) {
    if (spineBoy != null) {
      // Keep aspect ratio.
      double scale = min(window.innerWidth / 360, window.innerHeight / 480);

      // Set the spine boy position.
      spineBoy.position.x = window.innerWidth / 2;
      spineBoy.position.y = window.innerHeight - (window.innerHeight / 12);

      // Set the spine boy scale.
      spineBoy.scale.x = spineBoy.scale.y = scale;

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
  var demo = new SpineBoyDemo();

  window.onResize.listen(demo.resize);
  window.onDeviceOrientation.listen(demo.resize);
}
