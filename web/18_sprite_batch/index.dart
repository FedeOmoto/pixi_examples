import 'dart:html';
import 'dart:math';
import 'package:pixi_dart/pixi.dart' as pixi;

class Dude extends pixi.Sprite {
  double direction;
  double turningSpeed;
  double speed;
  int offset;

  Dude(pixi.Texture texture) : super(texture);

  factory Dude.fromImage(String imageId, [bool crossorigin, pixi.ScaleModes<int>
      scaleMode = pixi.ScaleModes.DEFAULT]) {
    var texture = new pixi.Texture.fromImage(imageId, crossorigin, scaleMode);
    return new Dude(texture);
  }
}

class SpriteBatchDemo {
  pixi.Stage stage;
  pixi.Renderer renderer;
  List<pixi.Sprite> dudes;
  pixi.Rectangle<int> dudeBounds;
  double tick = 0.0;

  SpriteBatchDemo() {
    int viewWidth = 800;
    int viewHeight = 600;

    // Create a renderer instance.
    //renderer = new pixi.CanvasRenderer(width: viewWidth, height: viewHeight);
    //renderer = new pixi.WebGLRenderer(width: viewWidth, height: viewHeight);
    renderer = new pixi.Renderer.autoDetect(width: viewWidth, height: viewHeight
        );
    renderer.view.className = 'rendererView';

    // Add the renderer view element to the DOM.
    document.body.append(renderer.view);

    // Create an new instance of a pixi stage.
    stage = new pixi.Stage(pixi.Color.white);

    var sprites = new pixi.SpriteBatch();
    stage.addChild(sprites);

    var random = new Random();

    int totalDudes = renderer.type == pixi.Renderer.WEBGL_RENDERER ? 10000 :
        100;
    dudes = new List<pixi.Sprite>(totalDudes);

    for (int i = 0; i < dudes.length; i++) {
      // Create a new Sprite that uses the image name that we just generated as
      // its source.
      var dude = new Dude.fromImage('tinyMaggot.png');

      // Set the anchor point so the the dude texture is centerd on the sprite.
      dude.anchor.x = dude.anchor.y = 0.5;

      // Set a random scale for the dude, no point them all being the same size!
      dude.scale.x = dude.scale.y = 0.8 + random.nextDouble() * 0.3;

      // Finally let's set the dude to be a random position.
      dude.x = random.nextInt(viewWidth);
      dude.y = random.nextInt(viewHeight);

      //dude.tint = new pixi.Color(random.nextInt(0x808080));

      // Create some extra properties that will control movement.
      // Create a random direction in radians. This is a number between 0 and
      // PI*2 which is the equivalent of 0 - 360 degrees.
      dude.direction = random.nextDouble() * PI * 2;

      // This number will be used to modify the direction of the dude over time.
      dude.turningSpeed = random.nextDouble() - 0.8;

      // Create a random speed for the dude.
      dude.speed = (2 + random.nextInt(2)) * 0.2;

      dude.offset = random.nextInt(100);

      // Finally we push the dude into the dudeArray so it it can be easily
      // accessed later.
      dudes[i] = dude;

      sprites.addChild(dude);
    }

    // Create a bounding box box for the little dudes.
    int dudeBoundsPadding = 100;

    dudeBounds = new pixi.Rectangle<int>(-dudeBoundsPadding, -dudeBoundsPadding,
        viewWidth + dudeBoundsPadding * 2, viewHeight + dudeBoundsPadding * 2);

    window.animationFrame.then(animate);
  }

  void animate(num value) {
    // Iterate through the dudes and update the positions.
    dudes.forEach((dude) {
      dude.scale.y = 0.95 + sin(tick + dude.offset) * 0.05;
      dude.direction += dude.turningSpeed * 0.01;
      dude.position.x += sin(dude.direction) * (dude.speed * dude.scale.y);
      dude.position.y += cos(dude.direction) * (dude.speed * dude.scale.y);
      dude.rotation = -dude.direction + PI;

      // Wrap the dudes by testing there bounds.
      if (dude.position.x < dudeBounds.left) {
        dude.position.x += dudeBounds.width;
      } else if (dude.position.x > dudeBounds.left + dudeBounds.width) {
        dude.position.x -= dudeBounds.width;
      }

      if (dude.position.y < dudeBounds.top) {
        dude.position.y += dudeBounds.height;
      } else if (dude.position.y > dudeBounds.top + dudeBounds.height) {
        dude.position.y -= dudeBounds.height;
      }
    });

    // Increment the ticker.
    tick += 0.1;

    // Time to render the stage!
    renderer.render(stage);

    // Request another animation frame.
    window.animationFrame.then(animate);
  }
}

void main() {
  new SpriteBatchDemo();
}
