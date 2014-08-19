import 'dart:html';
import 'package:pixi_dart/pixi.dart';

class SpinosaurusDemo {
  Stage stage;
  Renderer renderer;
  Spine spinosaurus;
  String atlasUrl = 'data/spinosaurus/spinosaurus.atlas';

  SpinosaurusDemo() {
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
    // Create a spinosaurus.
    spinosaurus = new Spine(atlasUrl);

    resize();

    spinosaurus.state.setAnimationByName(0, 'animation', true);

    // Add the spinosaurus to the stage.
    stage.addChild(spinosaurus);
  }

  void resize([Event event]) {
    if (spinosaurus != null) {
      // Set the spinosaurus position.
      spinosaurus.position.x = window.innerWidth / 2;
      spinosaurus.position.y = window.innerHeight / 2;

      // Set the spinosaurus scale.
      spinosaurus.scale.x = window.innerWidth / 1680;
      spinosaurus.scale.y = window.innerHeight / 1050;
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
  var demo = new SpinosaurusDemo();

  window.onResize.listen(demo.resize);
  window.onDeviceOrientation.listen(demo.resize);
}
