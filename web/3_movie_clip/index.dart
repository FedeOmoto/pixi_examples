import 'dart:html';
import 'dart:math';
import 'package:pixi_dart/pixi.dart';

class MovieClipDemo {
  Stage stage;
  Renderer renderer;

  MovieClipDemo() {
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
    var container = new DisplayObjectContainer();
    container.position.x = 400;
    container.position.y = 300;

    stage.addChild(container);
  }

  void onAssetsLoaded(CustomEvent event) {
    // Create a list to store the textures.
    var explosionTextures = new List<Texture>();

    for (int i = 0; i < 26; i++) {
      var texture = new Texture.fromFrame('Explosion_Sequence_A ${i+1}.png');
      explosionTextures.add(texture);
    }

    var random = new Random();

    for (int i = 0; i < 50; i++) {
      // Create an explosion MovieClip.
      var explosion = new MovieClip(explosionTextures);

      explosion.position.x = random.nextInt(800);
      explosion.position.y = random.nextInt(600);
      explosion.anchor.x = 0.5;
      explosion.anchor.y = 0.5;

      explosion.rotation = random.nextDouble() * PI;
      explosion.scale.x = explosion.scale.y = 0.75 + random.nextDouble() * 0.5;

      explosion.gotoAndPlay(random.nextInt(27));

      stage.addChild(explosion);
    }

    // Start animating.
    window.animationFrame.then(animate);
  }

  void animate(num value) {
    // Render the stage.
    renderer.render(stage);

    window.animationFrame.then(animate);
  }
}

void main() {
  new MovieClipDemo();
}
