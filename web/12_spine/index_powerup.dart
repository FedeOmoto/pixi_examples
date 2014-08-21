import 'dart:html';
import 'package:pixi_dart/pixi.dart';

class PowerupDemo {
  Stage stage;
  Renderer renderer;
  Spine powerup;
  String atlasUrl = 'data/powerup/powerup.atlas';

  PowerupDemo() {
    // Create a list of assets to load.
    var assetsToLoad = [atlasUrl];

    // Create a new loader.
    var loader = new AssetLoader(assetsToLoad);

    // Use callback.
    loader.onComplete.listen(onAssetsLoaded);

    // Begin load.
    loader.load();

    // Create an new instance of a pixi stage.
    stage = new Stage(Color.white);

    // Create a renderer instance.
    //renderer = new CanvasRenderer();
    //renderer = new WebGLRenderer();
    renderer = new Renderer.autoDetect();

    // Set the canvas width and height to fill the screen.
    renderer.view.style.display = 'block';

    // Add the renderer view element to the DOM.
    document.body.append(renderer.view);

    window.animationFrame.then(animate);
  }

  void onAssetsLoaded(CustomEvent event) {
    // Create a powerup.
    powerup = new Spine(atlasUrl);

    resize();

    powerup.state.setAnimationByName(0, 'animation', true);

    // Add the powerup to the stage.
    stage.addChild(powerup);
  }

  void resize([Event event]) {
    if (powerup != null) {
      // Set the powerup position.
      powerup.position.x = window.innerWidth / 2;
      powerup.position.y = window.innerHeight.toDouble();

      // Set the powerup scale.
      powerup.scale.x = window.innerWidth / 520;
      powerup.scale.y = window.innerHeight / 400;
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
  var demo = new PowerupDemo();

  window.onResize.listen(demo.resize);
  window.onDeviceOrientation.listen(demo.resize);
}
