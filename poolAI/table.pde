class table {
  hole[] ho;
  boundary[] bo;
  Box2DProcessing world;
  PVector pos;
  float w, h;
  table(PVector _pos, float _w, float _h, Box2DProcessing _world) {
    world = _world;
    w = _w;
    h = _h;
    pos = _pos;
    ho = new hole[6];
    ho[0] = new hole(new PVector(pos.x - w/2 + 40, pos.y - h/2 + 40), 25);
    ho[1] = new hole(new PVector(pos.x - w/2 + 40, pos.y), 25);
    ho[2] = new hole(new PVector(pos.x - w/2 + 40, pos.y + h/2 - 40), 25);
    ho[3] = new hole(new PVector(pos.x + w/2 - 40, pos.y - h/2 + 40), 25);
    ho[4] = new hole(new PVector(pos.x + w/2 - 40, pos.y), 25);
    ho[5] = new hole(new PVector(pos.x + w/2 - 40, pos.y + h/2 - 40), 25);
    bo = new boundary[6];
    Vec2[] vec = new Vec2[4];
    vec[0] = new Vec2(0, 0);
    vec[1] = new Vec2(0, 50);
    vec[2] = new Vec2(4, 50-5);
    vec[3] = new Vec2(4, 5);
    bo[0] = new boundary(vec, new PVector(pos.x -w/2, pos.y + h/2-35), world);
    bo[1] = new boundary(vec, new PVector(pos.x -w/2, pos.y + 5), world);
    vec[0] = new Vec2(0, 0);
    vec[1] = new Vec2(0, 50);
    vec[2] = new Vec2(-4, 50-5);
    vec[3] = new Vec2(-4, 5);
    bo[2] = new boundary(vec, new PVector(pos.x + w/2, pos.y + h/2-35), world);
    bo[3] = new boundary(vec, new PVector(pos.x + w/2, pos.y + 5), world);
    vec[0] = new Vec2(0, 0);
    vec[1] = new Vec2(53, 0);
    vec[2] = new Vec2(53 -5, -4);
    vec[3] = new Vec2(5, -4);
    bo[4] = new boundary(vec, new PVector(pos.x - w/2 + 34, pos.y - h/2), world);
    vec[0] = new Vec2(0, 0);
    vec[1] = new Vec2(53, 0);
    vec[2] = new Vec2(53 -5, 4);
    vec[3] = new Vec2(5, 4);
    bo[5] = new boundary(vec, new PVector(pos.x - w/2 + 34, pos.y + h/2), world);
  }
  void show() {
    fill(0, 84, 0);
    push();
    rect(pos.x - w/2, pos.y - h/2, w, h);
    for (hole hx : ho) {
      hx.display();
    }
    for (boundary bx : bo) {
      bx.display();
    }
    noStroke();
    rect(pos.x, pos.y - h/2+5, w, 10);
    rect(pos.x, pos.y + h/2-5, w, 10);
    rect(pos.x-w/2 + 5, pos.y, 10, h);
    rect(pos.x+w/2 - 5, pos.y, 10, h);
    pop();
  }
  void killall() {
    for (boundary bx : bo) {
      bx.killbody();
    }
  }
}
