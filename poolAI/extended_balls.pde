class MasterBall extends ball {
  MasterBall(PVector _pos, float _r, Box2DProcessing _world, color _c) {
    super(_pos, _r, _world, _c);
  }
  void applyForce(PVector _v) {
    Vec2 v = new Vec2(_v.x, _v.y);
    this.b.applyForce(v, this.b.getWorldCenter());
  }
}
class ball8 extends ball {
  ball8(PVector _pos, float _r, Box2DProcessing _world, color _c) {
    super(_pos, _r, _world, _c);
  }
}
