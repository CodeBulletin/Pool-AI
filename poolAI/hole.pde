class hole {
  PVector pos;
  float r;
  hole(PVector _pos, float _r) {
    pos = _pos;
    r = _r;
  }
  void display() {
    fill(0);
    ellipse(pos.x, pos.y, r*2, r*2);
  }
}
