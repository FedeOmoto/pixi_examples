import 'dart:html';
import 'dart:math';
import 'package:pixi_dart/pixi.dart';

class SpriteSheetDemo {
  // Holder to store aliens.
  List<Sprite> aliens = new List<Sprite>();
  List<String> alienFrames = ['eggHead.png', 'flowerTop.png', 'helmlok.png',
      'skully.png'];

  double count = 0.0;

  Stage stage;
  Renderer renderer;
  DisplayObjectContainer alienContainer;

  SpriteSheetDemo() {
    // Create a list of assets to load.
    var assetsToLoad = ['SpriteSheet.json'];

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

    // Add the renderer view element to the DOM.
    document.body.append(renderer.view);

    // Create an empty container.
    alienContainer = new DisplayObjectContainer();
    alienContainer.position.x = 400;
    alienContainer.position.y = 300;

    stage.addChild(alienContainer);
  }

  void onAssetsLoaded(CustomEvent event) {
    var random = new Random();

    // Add a bunch of aliens with textures from image paths.
    for (int i = 0; i < 100; i++) {
      var frameName = alienFrames[i % 4];

      // Create an alien using the frame name.
      var alien = new Sprite.fromFrame(frameName);

      /*
       * Fun fact for the day :)
       * Another way of doing the above would be:
       * var texture = new Texture.fromFrame(frameName);
       * var alien = new Sprite(texture);
       */
      alien.position.x = random.nextInt(800) - 400;
      alien.position.y = random.nextInt(600) - 300;
      alien.anchor.x = 0.5;
      alien.anchor.y = 0.5;
      aliens.add(alien);
      alienContainer.addChild(alien);
    }

    // Start animating.
    window.animationFrame.then(animate);
  }

  void animate(num value) {
    // Just for fun, lets rotate the aliens a little.
    aliens.forEach((alien) => alien.rotation += 0.1);

    count += 0.01;
    alienContainer.scale.x = sin(count);
    alienContainer.scale.y = sin(count);

    alienContainer.rotation += 0.01;

    // Render the stage.
    renderer.render(stage);

    window.animationFrame.then(animate);
  }
}

void main() {
  new SpriteSheetDemo();
}
