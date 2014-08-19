import 'dart:html';
import 'dart:math';
import 'package:pixi_dart/pixi.dart' as pixi;

class StripDemo {
  pixi.Stage stage;
  pixi.Renderer renderer;
  List<pixi.Point<num>> points = new List<pixi.Point<num>>();
  double count = 0.0;

  StripDemo() {
    // Create an new instance of a pixi stage.
    stage = new pixi.Stage(new pixi.Color(0xace455));

    // Create a renderer instance.
    //renderer = new pixi.CanvasRenderer(width: window.innerWidth, height:
    //    window.innerHeight);
    //renderer = new pixi.WebGLRenderer(width: window.innerWidth, height:
    //    window.innerHeight);
    renderer = new pixi.Renderer.autoDetect(width: window.innerWidth, height:
        window.innerHeight);
    renderer.view.className = 'rendererView';

    // Add the renderer view element to the DOM.
    document.body.append(renderer.view);

    // Build a rope!
    double length = 918 / 20;

    for (int i = 0; i < 20; i++) {
      points.add(new pixi.Point<num>(i * length, 0));
    }

    var strip = new pixi.Rope(new pixi.Texture.fromImage('snake.png'), points);
    strip.x = -918 / 2;

    var snakeContainer = new pixi.DisplayObjectContainer();
    snakeContainer.position.x = window.innerWidth / 2;
    snakeContainer.position.y = window.innerHeight / 2;

    snakeContainer.scale.x = window.innerWidth / 1100;
    snakeContainer.scale.y = window.innerWidth / 1100;
    stage.addChild(snakeContainer);

    snakeContainer.addChild(strip);

    // Start animating.
    window.animationFrame.then(animate);
  }

  void animate(num value) {
    count += 0.1;

    double length = 918 / 20;

    for (int i = 0; i < points.length; i++) {
      points[i].y = sin(i * 0.5 + count) * 30;
      points[i].x = i * length + cos(i * 0.3 + count) * 20;
    }

    // Render the stage.
    renderer.render(stage);

    window.animationFrame.then(animate);
  }
}

void main() {
  new StripDemo();
}
