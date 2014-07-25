import 'dart:html';
import 'dart:math';
import 'package:pixi_dart/pixi.dart' as pixi;

class MaskingDemo {
  pixi.Stage stage;
  pixi.Renderer renderer;
  pixi.Sprite bg, bgFront, light1, light2, panda;
  pixi.DisplayObjectContainer container;
  pixi.Graphics thing;
  double count = 0.0;

  MaskingDemo() {
    // Create an new instance of a pixi stage.
    stage = new pixi.Stage(pixi.Color.white);

    bg = new pixi.Sprite.fromImage('BGrotate.jpg');
    bg.anchor.x = 0.5;
    bg.anchor.y = 0.5;

    bg.position.x = 620 ~/ 2;
    bg.position.y = 380 ~/ 2;

    stage.addChild(bg);

    container = new pixi.DisplayObjectContainer();
    container.position.x = 620 ~/ 2;
    container.position.y = 380 ~/ 2;

    bgFront = new pixi.Sprite.fromImage('SceneRotate.jpg');
    bgFront.anchor.x = 0.5;
    bgFront.anchor.y = 0.5;

    container.addChild(bgFront);

    light2 = new pixi.Sprite.fromImage('LightRotate2.png');
    light2.anchor.x = 0.5;
    light2.anchor.y = 0.5;
    container.addChild(light2);

    light1 = new pixi.Sprite.fromImage('LightRotate1.png');
    light1.anchor.x = 0.5;
    light1.anchor.y = 0.5;
    container.addChild(light1);

    panda = new pixi.Sprite.fromImage('panda.png');
    panda.anchor.x = 0.5;
    panda.anchor.y = 0.5;

    container.addChild(panda);

    stage.addChild(container);

    // Create a renderer instance.
    //renderer = new pixi.CanvasRenderer(width: 620, height: 380);
    //renderer = new pixi.WebGLRenderer(width: 620, height: 380);
    renderer = new pixi.Renderer.autoDetect(width: 620, height: 380);

    renderer.view.style.position = 'absolute';
    renderer.view.style.marginLeft = '-310px';
    renderer.view.style.marginTop = '-190px';
    renderer.view.style.top = '50%';
    renderer.view.style.left = '50%';
    renderer.view.style.display = 'block';

    // Add the renderer view element to the DOM.
    document.body.append(renderer.view);

    // Let's create a moving shape.
    thing = new pixi.Graphics();
    stage.addChild(thing);
    thing.position.x = 620 ~/ 2;
    thing.position.y = 380 ~/ 2;
    thing.lineStyle(0);

    container.mask = thing;

    stage.onClick.listen(swapMask);
    stage.onTap.listen(swapMask);

    var style = new pixi.TextStyle()..font = 'bold 12pt Arial';
    var help = new pixi.Text('Click to turn masking on / off.', style);
    help.position.y = 350;
    help.position.x = 10;
    stage.addChild(help);

    window.animationFrame.then(animate);
  }

  void swapMask(pixi.InteractionData event) {
    if (container.mask == null) {
      container.mask = thing;
    } else {
      container.mask = null;
    }
  }

  void animate(num value) {
    bg.rotation += 0.01;
    bgFront.rotation -= 0.01;

    light1.rotation += 0.02;
    light2.rotation += 0.01;

    panda.scale.x = 1 + sin(count) * 0.04;
    panda.scale.y = 1 + cos(count) * 0.04;

    count += 0.1;

    thing.clear();

    thing.beginFill(new pixi.Color(0x8bc5ff), 0.4);
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
  new MaskingDemo();
}
