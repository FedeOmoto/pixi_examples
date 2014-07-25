import 'dart:html';
import 'package:pixi_dart/pixi.dart';

class FighterDemo {
  Stage stage;
  Renderer renderer;
  MovieClip movie;

  FighterDemo() {
    // Create a list of assets to load.
    var assetsToLoad = ['fighter.json'];

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
    var frames = new List<Texture>();

    for (int i = 0; i < 30; i++) {
      var val = i < 10 ? '0$i' : i;
      frames.add(new Texture.fromFrame('rollSequence00$val.png'));
    }

    movie = new MovieClip(frames);

    movie.position.x = 300;
    movie.position.y = 300;

    movie.anchor.x = movie.anchor.y = 0.5;
    movie.play();
    movie.animationSpeed = 0.5;
    stage.addChild(movie);

    // Start animating.
    window.animationFrame.then(animate);
  }

  void animate(num value) {
    movie.rotation += 0.01;

    // Render the stage.
    renderer.render(stage);

    window.animationFrame.then(animate);
  }
}

void main() {
  new FighterDemo();
}
