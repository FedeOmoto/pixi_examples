import 'dart:html';
import 'dart:math';
import 'package:pixi_dart/pixi.dart';

class GraphicsDemo {
  Stage stage;
  Renderer renderer;
  Graphics graphics;
  Graphics thing;
  double count = 0.0;
  Random random = new Random();

  GraphicsDemo() {
    // Create an new instance of a pixi stage.
    stage = new Stage(Color.white);

    // Create a renderer instance.
    //renderer = new CanvasRenderer(width: 620, height: 380);
    //renderer = new WebGLRenderer(width: 620, height: 380);
    renderer = new Renderer.autoDetect(width: 620, height: 380);

    renderer.view.style.display = 'block';

    // Add the renderer view element to the DOM.
    document.body.append(renderer.view);

    graphics = new Graphics();

    // Set a fill and line style.
    graphics.beginFill(new Color(0xFF3300));
    graphics.lineStyle(10, new Color(0xffd900), 1.0);

    // Draw a shape.
    graphics.moveTo(50, 50);
    graphics.lineTo(250, 50);
    graphics.lineTo(100, 100);
    graphics.lineTo(250, 220);
    graphics.lineTo(50, 220);
    graphics.lineTo(50, 50);
    graphics.endFill();

    // Set a fill and line style again.
    graphics.lineStyle(10, Color.red, 0.8);
    graphics.beginFill(new Color(0xFF700B), 1.0);

    // Draw a second shape.
    graphics.moveTo(210, 300);
    graphics.lineTo(450, 320);
    graphics.lineTo(570, 350);
    graphics.lineTo(580, 20);
    graphics.lineTo(330, 120);
    graphics.lineTo(410, 200);
    graphics.lineTo(210, 300);
    graphics.endFill();

    // Draw a rectangle.
    graphics.lineStyle(2, Color.blue, 1.0);
    graphics.drawRect(50, 250, 100, 100);

    // Draw a circle.
    graphics.lineStyle(0);
    graphics.beginFill(new Color(0xFFFF0B), 0.5);
    graphics.drawCircle(470, 200, 100);

    graphics.lineStyle(20, new Color(0x33FF00));
    graphics.moveTo(30, 30);
    graphics.lineTo(600, 300);

    stage.addChild(graphics);

    // Let's create a moving shape.
    thing = new Graphics();
    stage.addChild(thing);
    thing.position.x = 620 ~/ 2;
    thing.position.y = 380 ~/ 2;

    stage.onClick.listen(drawLine);
    stage.onTap.listen(drawLine);

    // Run the render loop.
    window.animationFrame.then(animate);
  }

  void drawLine(InteractionData event) {
    graphics.lineStyle(random.nextInt(30), new Color(random.nextInt(0xFFFFFF)),
        1.0);
    graphics.moveTo(random.nextInt(620), random.nextInt(380));
    graphics.lineTo(random.nextInt(620), random.nextInt(380));
  }

  void animate(num value) {
    thing.clear();

    count += 0.1;

    thing.clear();
    thing.lineStyle(30, Color.red, 1.0);
    thing.beginFill(Color.yellow, 0.5);

    thing.moveTo((-120 + sin(count) * 20).round(), (-100 + cos(count) *
        20).round());
    thing.lineTo((120 + cos(count) * 20).round(), (-100 + sin(count) *
        20).round());
    thing.lineTo((120 + sin(count) * 20).round(), (100 + cos(count) * 20).round(
        ));
    thing.lineTo((-120 + cos(count) * 20).round(), (100 + sin(count) *
        20).round());
    thing.lineTo((-120 + sin(count) * 20).round(), (-100 + cos(count) *
        20).round());

    thing.rotation = count * 0.1;
    renderer.render(stage);
    window.animationFrame.then(animate);
  }
}

void main() {
  new GraphicsDemo();
}
