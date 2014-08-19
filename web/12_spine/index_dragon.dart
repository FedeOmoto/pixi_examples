import 'dart:html';
import 'dart:math';
import 'package:pixi_dart/pixi.dart' as pixi;

class SpineDemo {
  pixi.Stage stage;
  pixi.Renderer renderer;
  pixi.Spine dragon;
  String atlasUrl = 'data/dragon/dragon.atlas';

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
    stage = new pixi.Stage(pixi.Color.white);

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
    // Create a dragon.
    dragon = new pixi.Spine(atlasUrl);

    resize();

    // Play animation.
    dragon.state.setAnimationByName(0, 'flying', true);

    // Add the dragon to the stage.
    stage.addChild(dragon);
  }

  void resize([Event event]) {
    if (dragon != null) {
      // Keep aspect ratio.
      double scale = min(window.innerWidth / 900, window.innerHeight / 900);

      // Set the dragon position.
      dragon.position.x = window.innerWidth / 2;
      dragon.position.y = window.innerHeight / 2;

      // Set the dragon scale.
      dragon.scale.x = dragon.scale.y = scale;
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
  var demo = new SpineDemo();

  window.onResize.listen(demo.resize);
  window.onDeviceOrientation.listen(demo.resize);
}
