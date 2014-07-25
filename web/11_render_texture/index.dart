import 'dart:html';
import 'dart:math';
import 'package:pixi_dart/pixi.dart' as pixi;

class RenderTextureDemo {
  pixi.Stage stage;
  pixi.Renderer renderer;
  pixi.RenderTexture renderTexture;
  pixi.RenderTexture renderTexture2;
  pixi.Sprite outputSprite;
  pixi.DisplayObjectContainer stuffContainer;

  // Create a list of items.
  List<pixi.Sprite> items = new List<pixi.Sprite>();

  // Used for spinning!
  double count = 0.0;

  RenderTextureDemo() {
    // Create an new instance of a pixi stage.
    stage = new pixi.Stage(pixi.Color.black);

    // Create a renderer instance.
    //renderer = new pixi.CanvasRenderer();
    //renderer = new pixi.WebGLRenderer();
    renderer = new pixi.Renderer.autoDetect();

    // Set the canvas width and height to fill the screen.
    renderer.view.style.width = '${window.innerWidth}px';
    renderer.view.style.height = '${window.innerHeight}px';
    renderer.view.style.display = 'block';

    // Add the renderer view element to the DOM.
    document.body.append(renderer.view);

    // OOH! SHINY!
    // Create two render textures. These dynamic textures will be used to draw
    // the scene into itself.
    renderTexture = new pixi.RenderTexture(800, 600);
    renderTexture2 = new pixi.RenderTexture(800, 600);

    // Create a new sprite that uses the render texture we created above.
    outputSprite = new pixi.Sprite(renderTexture);

    // Align the sprite.
    outputSprite.position.x = 800 ~/ 2;
    outputSprite.position.y = 600 ~/ 2;
    outputSprite.anchor.x = 0.5;
    outputSprite.anchor.y = 0.5;

    // Add to stage.
    stage.addChild(outputSprite);

    stuffContainer = new pixi.DisplayObjectContainer();

    stuffContainer.position.x = 800 ~/ 2;
    stuffContainer.position.y = 600 ~/ 2;

    stage.addChild(stuffContainer);

    // Create an array of image ids.
    var fruits = ['spinObj_01.png', 'spinObj_02.png', 'spinObj_03.png',
        'spinObj_04.png', 'spinObj_05.png', 'spinObj_06.png', 'spinObj_07.png',
        'spinObj_08.png'];

    var random = new Random();

    // Now create some items and randomly position them in the stuff container.
    for (int i = 0; i < 20; i++) {
      var item = new pixi.Sprite.fromImage(fruits[i % fruits.length]);
      item.position.x = random.nextInt(400) - 200;
      item.position.y = random.nextInt(400) - 200;

      item.anchor.x = 0.5;
      item.anchor.y = 0.5;

      stuffContainer.addChild(item);

      items.add(item);
    }

    window.animationFrame.then(animate);
  }

  void animate(num value) {
    window.animationFrame.then(animate);

    items.forEach((item) => item.rotation += 0.1);

    count += 0.01;

    // Swap the buffers.
    var temp = renderTexture;
    renderTexture = renderTexture2;
    renderTexture2 = temp;

    // Set the new texture.
    outputSprite.setTexture(renderTexture);

    // Twist this up!
    stuffContainer.rotation -= 0.01;
    outputSprite.scale.x = outputSprite.scale.y = 1 + sin(count) * 0.2;

    // Render the stage to the texture.
    // The true clears the texture before content is rendered.
    renderTexture2.render(stage, new pixi.Point(0, 0), true);

    // And finally render the stage.
    renderer.render(stage);
  }
}

void main() {
  new RenderTextureDemo();
}
