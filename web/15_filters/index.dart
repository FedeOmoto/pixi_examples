import 'dart:html';
import 'dart:math';
import 'dart:typed_data';
import 'package:pixi_dart/pixi.dart' as pixi;

class ColorMatrixDemo {
  pixi.Stage stage;
  pixi.Renderer renderer;
  pixi.Sprite bg, bgFront, light1, light2, panda;
  pixi.ColorMatrixFilter filter;
  Float32List colorMatrix;
  bool switchy = false;
  double count = 0.0;

  ColorMatrixDemo() {
    // Create an new instance of a pixi stage.
    stage = new pixi.Stage(pixi.Color.white);

    bg = new pixi.Sprite.fromImage('BGrotate.jpg');
    bg.anchor.x = 0.5;
    bg.anchor.y = 0.5;

    bg.position.x = 620 / 2;
    bg.position.y = 380 / 2;

    filter = new pixi.ColorMatrixFilter();

    colorMatrix = filter.matrix;

    var container = new pixi.DisplayObjectContainer();
    container.position.x = 620 / 2;
    container.position.y = 380 / 2;

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
    renderer = new pixi.WebGLRenderer(width: 620, height: 380);
    renderer.view.style.position = 'absolute';
    renderer.view.style.width = '${window.innerWidth}px';
    renderer.view.style.height = '${window.innerHeight}px';
    renderer.view.style.display = 'block';

    // Add the renderer view element to the DOM.
    document.body.append(renderer.view);

    stage.filters = [filter];

    stage.onClick.listen(switchFilter);
    stage.onTap.listen(switchFilter);

    // Add a pixi Logo!
    var logo = new pixi.Sprite.fromImage('pixi.png');
    stage.addChild(logo);

    logo.anchor.x = 1.0;
    logo.position.x = 620;
    logo.scale.x = logo.scale.y = 0.5;
    logo.position.y = 320;
    logo.interactive = true;
    logo.buttonMode = true;

    logo.onClick.listen((event) {
      window.open('https://github.com/FedeOmoto/pixi/', '_blank');
    });

    logo.onTap.listen((event) {
      window.open('https://github.com/FedeOmoto/pixi/', '_blank');
    });

    var textStyle = new pixi.TextStyle()..font = 'bold 12pt Arial';
    var help = new pixi.Text('Click to turn filters on / off.', textStyle);
    help.position.y = 350;
    help.position.x = 10;
    stage.addChild(help);

    window.animationFrame.then(animate);
  }

  void switchFilter(pixi.InteractionData event) {
    switchy = !switchy;

    if (!switchy) {
      stage.filters = [filter];
    } else {
      stage.filters = null;
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

    colorMatrix[1] = sin(count) * 3;
    colorMatrix[2] = cos(count);
    colorMatrix[3] = cos(count) * 1.5;
    colorMatrix[4] = sin(count / 3) * 2;
    colorMatrix[5] = sin(count / 2);
    colorMatrix[6] = sin(count / 4);

    // Render the stage.
    renderer.render(stage);

    window.animationFrame.then(animate);

  }
}

void main() {
  new ColorMatrixDemo();
}
