class boundary {
  Body b;
  Vec2 pos;
  Vec2[] vertex;
  Box2DProcessing world;
  boundary(Vec2[] _vertex, PVector _pos, Box2DProcessing _world) {
    vertex = _vertex;
    pos = new Vec2(_pos.x, _pos.y);
    world = _world;
    makeBody();
  }
  void makeBody() {
    PolygonShape sd = new PolygonShape();
    sd.set(vertex, vertex.length);
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(world.coordPixelsToWorld(pos));
    b = world.createBody(bd);
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 1;
    fd.friction = 0;
    fd.restitution = 0.9;
    b.createFixture(fd);
  }
  void display() {
    Fixture f = b.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();
    pushMatrix();
    rectMode(CENTER);
    translate(pos.x, pos.y);
    fill(56, 28, 0);
    noStroke();
    beginShape();
    for (int i = 0; i < ps.getVertexCount(); i++) {
      Vec2 v = world.vectorWorldToPixels(ps.getVertex(i));
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    popMatrix();
  }
  boolean killbody() {
    world.destroyBody(b);
    return true;
  }
}
