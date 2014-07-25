import 'dart:html';
import 'dart:math';
import 'package:pixi_dart/pixi.dart';

class TilingTextureDemo {
  Stage stage;
  Renderer renderer;
  TilingSprite tilingSprite;
  double count = 0.0;

  TilingTextureDemo() {
    // Create an new instance of a pixi stage.
    stage = new Stage(new Color(0x97C56E));

    // Create a renderer instance.
    //renderer = new CanvasRenderer(width: window.innerWidth, height:
    //    window.innerHeight);
    //renderer = new WebGLRenderer(width: window.innerWidth, height:
    //    window.innerHeight);
    renderer = new Renderer.autoDetect(width: window.innerWidth, height:
        window.innerHeight);

    // Add the renderer view element to the DOM.
    renderer.view.style.position = 'absolute';
    renderer.view.style.top = '0px';
    renderer.view.style.left = '0px';
    document.body.append(renderer.view);

    // Create a texture from an image path.
    var texture = new Texture.fromImage('p2.jpeg');

    // Create a tiling sprite...
    // Requires a texture, width and height.
    // To work in webGL the texture size must be a power of two.
    tilingSprite = new TilingSprite(texture, window.innerWidth,
        window.innerHeight);

    stage.addChild(tilingSprite);

    window.animationFrame.then(animate);
  }

  void animate(num value) {
    count += 0.005;

    tilingSprite.tileScale.x = 2 + sin(count);
    tilingSprite.tileScale.y = 2 + cos(count);

    tilingSprite.tilePosition.x += 1;
    tilingSprite.tilePosition.y += 1;

    // Render the stage.
    renderer.render(stage);

    window.animationFrame.then(animate);
  }
}

void main() {
  new TilingTextureDemo();
}
