import 'dart:html';
import 'dart:math';
import 'package:vector_math/vector_math.dart';
import 'package:three/three.dart';

class WebGL_Transparency  {
  Element container;

  PerspectiveCamera camera;
  Scene scene;
  WebGLRenderer renderer;

  void run() {
    init();
    animate(0);
  }

  void init() {

    container = new Element.tag('div');

    document.body.nodes.add( container );

    scene = new Scene();

    camera = new PerspectiveCamera( 70.0, window.innerWidth / window.innerHeight, 1.0, 1000.0 );
    camera.position.z = 400.0;

    scene.add(camera);

    // Init the lights
    AmbientLight ambient = new AmbientLight(0x202020);
    scene.add(ambient);

    DirectionalLight directionallight = new DirectionalLight(0xffffff, 1.5);
    directionallight.position.setValues(0.0, 0.0, 0.0);
    camera.add(directionallight);

    for (int i = 0; i < 50; i++) {

      SphereGeometry spheregeometry = new SphereGeometry(3.3, 10, 10);

      Material material1 = new MeshPhongMaterial(
          color       : 0x4d7399,
          ambient     : 0x4d7399,
          specular    : 0xffffff,
          shininess   : 300,
          reflectivity: 200,
          shading     : SmoothShading,
          side        : FrontSide
      );

      Mesh spheremesh1 = new Mesh(spheregeometry, material1);

      scene.add( spheremesh1 );

      Material material2 = new MeshPhongMaterial(
          color       : 0x87ff24,
          ambient     : 0x87ff24,
          specular    : 0xffffff,
          shininess   : 300,
          reflectivity: 200,
          shading     : SmoothShading,
          side        : FrontSide,
          opacity     : 0.5
      );

      SphereGeometry spheregeometry2 = new SphereGeometry(3.3, 10, 10);

      Mesh spheremesh2 = new Mesh(spheregeometry2, material2);

      spheremesh2.scale *= 1.6;

      scene.add( spheremesh2 );

      Random random = new Random();

      spheremesh1.position = new Vector3(-200.0 + random.nextDouble() * 400.0, -200.0 + random.nextDouble() * 400.0, 100.0);

      spheremesh2.position.setFrom(spheremesh1.position);
    }

    renderer = new WebGLRenderer();
    renderer.setSize( window.innerWidth, window.innerHeight );

    container.nodes.add( renderer.domElement );

    window.onResize.listen(onWindowResize);
  }

  onWindowResize(e) {

    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();

    renderer.setSize( window.innerWidth, window.innerHeight );

  }

  animate(num time) {

    window.requestAnimationFrame( animate );

    renderer.render( scene, camera );

  }

}

void main() {
  new WebGL_Transparency().run();
}
