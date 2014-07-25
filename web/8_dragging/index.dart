import 'dart:html';
import 'dart:math';
import 'package:pixi_dart/pixi.dart';

class Bunny extends Sprite {
  InteractionData data;
  bool dragging = false;

  Bunny(Texture texture) : super(texture);
}

class DraggingDemo {
  Stage stage;
  Renderer renderer;
  Texture texture;

  DraggingDemo() {
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
    document.body.append(renderer.view);
    renderer.view.style.position = 'absolute';
    renderer.view.style.top = '0px';
    renderer.view.style.left = '0px';

    window.animationFrame.then(animate);

    // Create a texture from an image path.
    texture = new Texture.fromImage('bunny.png');

    var random = new Random();

    for (int i = 0; i < 10; i++) {
      createBunny(random.nextInt(window.innerWidth), random.nextInt(
          window.innerHeight));
    }
  }

  void createBunny(int x, int y) {
    // Create our little bunny friend.
    var bunny = new Bunny(texture);

    // Enable the bunny to be interactive. This will allow it to respond to
    // mouse and touch events.
    bunny.interactive = true;

    // This button mode will mean the hand cursor appears when you rollover the
    // bunny with your mouse.
    bunny.buttonMode = true;

    // Center the bunny's anchor point.
    bunny.anchor.x = 0.5;
    bunny.anchor.y = 0.5;

    // Make it a bit bigger, so its easier to touch.
    bunny.scale.x = bunny.scale.y = 3.0;

    // Set the mousedown and touchstart listeners.
    bunny.onMouseDown.listen(startDragging);
    bunny.onTouchStart.listen(startDragging);

    // Set the listeners for when the mouse is released or a touch is released.
    bunny.onMouseUp.listen(stopDragging);
    bunny.onTouchEnd.listen(stopDragging);
    bunny.onTouchEndOutside.listen(stopDragging);

    // Set the listeners for when the mouse or a touch moves.
    bunny.onMouseMove.listen(drag);
    bunny.onTouchMove.listen(drag);

    // Move the sprite to its designated position.
    bunny.position.x = x;
    bunny.position.y = y;

    // Add it to the stage.
    stage.addChild(bunny);
  }

  void startDragging(InteractionData event) {
    var bunny = event.target as Bunny;

    // Stop the default event.
    event.originalEvent.preventDefault();

    // Store a reference to the data.
    // The reason for this is because of multitouch.
    // We want to track the movement of this particular touch.
    bunny.data = event;
    bunny.alpha = 0.9;
    bunny.dragging = true;
  }

  void stopDragging(InteractionData event) {
    var bunny = event.target as Bunny;

    bunny.alpha = 1.0;
    bunny.dragging = false;

    // Set the interaction data to null.
    bunny.data = null;
  }

  void drag(InteractionData event) {
    var bunny = event.target as Bunny;

    if (bunny.dragging) {
      var newPosition = bunny.data.getLocalPosition(bunny.parent);
      bunny.position.x = newPosition.x;
      bunny.position.y = newPosition.y;
    }
  }

  void animate(num value) {
    window.animationFrame.then(animate);

    // Render the stage.
    renderer.render(stage);
  }
}

void main() {
  new DraggingDemo();
}
