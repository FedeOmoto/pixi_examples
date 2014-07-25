import 'dart:html';
import 'package:pixi_dart/pixi.dart';

class TransparentBackgroundDemo {
  Stage stage;
  Renderer renderer;
  Sprite bunny;

  TransparentBackgroundDemo() {
    // Create an new instance of a pixi stage.
    stage = new Stage(new Color(0x66FF99));

    // Create a renderer instance.
    //renderer = new CanvasRenderer(width: 400, height: 300, transparent: true);
    //renderer = new WebGLRenderer(width: 400, height: 300, transparent: true);
    renderer = new Renderer.autoDetect(width: 400, height: 300, transparent:
        true);

    // Add the renderer view element to the DOM.
    document.body.append(renderer.view);
    renderer.view.style.position = 'absolute';
    renderer.view.style.top = '0px';
    renderer.view.style.left = '0px';

    // Create a texture from an image path.
    var texture = new Texture.fromImage('bunny.png');

    // Create a new Sprite using the texture.
    bunny = new Sprite(texture);

    // Center the sprites anchor point.
    bunny.anchor.x = 0.5;
    bunny.anchor.y = 0.5;

    // Move the sprite to the center of the screen.
    bunny.position.x = 200;
    bunny.position.y = 150;

    stage.addChild(bunny);

    window.animationFrame.then(animate);
  }

  void animate(num value) {
    window.animationFrame.then(animate);

    // Just for fun, let's rotate mr rabbit a little.
    bunny.rotation += 0.1;

    // Render the stage.
    renderer.render(stage);
  }
}

void main() {
  new TransparentBackgroundDemo();
}
