import 'dart:html';
import 'dart:math';
import 'package:pixi_dart/pixi.dart' as pixi;

class SpineDemo {
  pixi.Stage stage;
  pixi.Renderer renderer;
  pixi.Spine goblin;
  pixi.Text help;
  String atlasUrl = 'data/goblins/goblins.atlas';

  SpineDemo() {
    // Create a list of assets to load.
    var assetsToLoad = [atlasUrl];

    // Create a new loader.
    var loader = new pixi.AssetLoader(assetsToLoad);

    // Use callback.
    loader.onComplete.listen(onAssetsLoaded);

    // Begin load.
    loader.load();

    // Create an new instance of a pixi stage.
    stage = new pixi.Stage(pixi.Color.dimGray);

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
    // Create a goblin.
    goblin = new pixi.Spine(atlasUrl);

    // Create a help text.
    var textStyle = new pixi.TextStyle()..font = 'bold 12pt Arial';
    help = new pixi.Text('Click to change skin.', textStyle);
    help.anchor.x = 0.5;

    resize();

    // Set current skin.
    goblin.skeleton.setSkinByName('goblin');
    goblin.skeleton.setSlotsToSetupPose();

    // Play animation.
    goblin.state.setAnimationByName(0, 'walk', true);

    // Add the goblin to the stage.
    stage.addChild(goblin);

    // Add the help text to the stage.
    stage.addChild(help);

    stage.onClick.listen((event) {
      // Change current skin.
      var currentSkinName = goblin.skeleton.skin.name;
      var newSkinName = (currentSkinName == 'goblin' ? 'goblingirl' : 'goblin');

      goblin.skeleton.setSkinByName(newSkinName);
      goblin.skeleton.setSlotsToSetupPose();
    });

    stage.onTap.listen((event) {
      // Change current skin.
      var currentSkinName = goblin.skeleton.skin.name;
      var newSkinName = (currentSkinName == 'goblin' ? 'goblingirl' : 'goblin');

      goblin.skeleton.setSkinByName(newSkinName);
      goblin.skeleton.setSlotsToSetupPose();
    });
  }

  void resize([Event event]) {
    if (goblin != null) {
      // Keep aspect ratio.
      double scale = min(window.innerWidth / 320, window.innerHeight / 420);

      // Set goblin position.
      goblin.position.x = window.innerWidth / 2;
      goblin.position.y = window.innerHeight - (window.innerHeight / 12);

      // Set the goblin scale.
      goblin.scale.x = goblin.scale.y = scale;

      // Set the help text position.
      help.position.x = window.innerWidth / 2;
      help.position.y = window.innerHeight - (window.innerHeight / 17);

      // Set the help text scale.
      help.scale.x = help.scale.y = scale;
    }

    renderer.resize(window.innerWidth, window.innerHeight);
  }

  void animate(num value) {
    window.animationFrame.then(animate);

    // Render the stage.
    renderer.render(stage);
  }
}

void main() {
  var demo = new SpineDemo();

  window.onResize.listen(demo.resize);
  window.onDeviceOrientation.listen(demo.resize);
}
