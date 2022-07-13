class ball {
  Body b;
  Box2DProcessing world;
  PVector pos, vel;
  float r;
  color c;
  ball(PVector _pos, float _r, Box2DProcessing _world, color _c) {
    pos = _pos;
    r = _r;
    world = _world;
    c = _c;
    makebody();
  }
  void makebody() {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position = world.coordPixelsToWorld(pos.x, pos.y);
    b = world.world.createBody(bd);
    CircleShape cs = new CircleShape();
    cs.m_radius = world.scalarPixelsToWorld(r);
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1;
    fd.friction = 0;
    fd.restitution = 0.9;
    b.createFixture(fd);
    b.setLinearDamping(0.45);
  }
  void display() {
    if (bestmode) {
      fill(c);
    } else {
      fill(c, 100);
    }
    noStroke();
    ellipse(pos.x, pos.y, r*2, r*2);
  }
  void update() {
    Vec2 position = world.getBodyPixelCoord(b);
    Vec2 velx = b.getLinearVelocity(); 
    vel = new PVector(velx.x, velx.y);
    pos = new PVector(position.x, position.y);
    applyFriction();
  }
  void applyFriction() {//called every step to simulate friction between the table and ball
    Vec2 vel = b.getLinearVelocity(); 
    if (vel.length() < 0.4) {
      vel.mulLocal(0);
    }
  }
  boolean inhole(hole[] h) {
    for (hole hx : h) {
      if (dist(pos.x, pos.y, hx.pos.x, hx.pos.y) <= hx.r/divFactor) {
        return true;
      }
    }
    return false;
  }
  boolean killbody() {
    world.destroyBody(b);
    return true;
  }
}
