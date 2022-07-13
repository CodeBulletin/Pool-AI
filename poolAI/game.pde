class game {
  ArrayList<ball> balls, rlist;
  MasterBall mainball;
  ball8 gameball;
  Box2DProcessing world;
  table t;
  PVector pos;
  float w, h, score;
  boolean isout, is8in, isvalid, isdone;
  game(PVector _pos, float _w, float _h, Box2DProcessing _world) {
    world = _world;
    isout = false;
    is8in = false;
    isvalid = true;
    isdone = false;
    score = 0;
    w = _w;
    h = _h;
    pos = _pos;
    t = new table(_pos, _w, _h, _world);
    rlist = new ArrayList<ball>();
    mainball = new MasterBall(new PVector(pos.x, pos.y+h/4+50), 20, world, color(255, 255, 255));
    gameball = new ball8(new PVector(pos.x, pos.y-h/4+30), 20, world, color(0, 0, 0));
    balls = new ArrayList<ball>();
    balls.add(new ball(new PVector(pos.x, pos.y-h/4+100), 20, world, color(255, 255, 0)));
    balls.add(new ball(new PVector(pos.x+20, pos.y-h/4+65), 20, world, color(245, 183, 179)));
    balls.add(new ball(new PVector(pos.x-20, pos.y-h/4+65), 20, world, color(173, 240, 188)));
    balls.add(new ball(new PVector(pos.x+40, pos.y-h/4+30), 20, world, color(255, 0, 0)));
    balls.add(new ball(new PVector(pos.x-40, pos.y-h/4+30), 20, world, color(0, 0, 255)));
    balls.add(new ball(new PVector(pos.x+60, pos.y-h/4-5), 20, world, color(105, 60, 23)));
    balls.add(new ball(new PVector(pos.x+20, pos.y-h/4-5), 20, world, color(171, 87, 255)));
    balls.add(new ball(new PVector(pos.x-20, pos.y-h/4-5), 20, world, color(165, 42, 42)));
    balls.add(new ball(new PVector(pos.x-60, pos.y-h/4-5), 20, world, color(107, 28, 2)));
    balls.add(new ball(new PVector(pos.x+80, pos.y-h/4-40), 20, world, color(58, 89, 107)));
    balls.add(new ball(new PVector(pos.x+40, pos.y-h/4-40), 20, world, color(0, 255, 0)));
    balls.add(new ball(new PVector(pos.x, pos.y-h/4-40), 20, world, color(94, 94, 1)));
    balls.add(new ball(new PVector(pos.x-40, pos.y-h/4-40), 20, world, color(255, 0, 255)));
    balls.add(new ball(new PVector(pos.x-80, pos.y-h/4-40), 20, world, color(255, 115, 0)));
  }
  void show() {
    push();
    if (!isout) {
      mainball.display();
    } 
    if (!is8in) {
      gameball.display();
    }
    for (ball bg : balls) {
      bg.display();
    }
    pop();
  }
  void show_table() {
    push();
    t.show();
    pop();
  }
  void update() {
    world.step();
    if (!isout) {
      mainball.update();
    } 
    if (!is8in) {
      gameball.update();
    }
    for (ball bg : balls) {
      bg.update();
    }
    rlist = new ArrayList<ball>();
    if (!isout) {
      if (mainball.inhole(t.ho)) {
        mainball.killbody();
        mainball = null;
        isout = true;
      }
    }
    if (!is8in) {
      if (gameball.inhole(t.ho)) {
        gameball.killbody();
        gameball = null;
        is8in = true;
      }
    }
    for (ball bg : balls) {
      Boolean eval = bg.inhole(t.ho);
      if (eval) {
        rlist.add(bg);
        score += 1;
      }
    }
    for (ball bog : rlist) {
      bog.killbody();
      balls.remove(bog);
    }
    if (isdone == false) {
      isdone = done();
      if (isdone) {
        isvalid = isvalidmov();
      }
    }
  }
  void hit(PVector dir) {
    PVector force = dir.copy();
    force.setMag(100000);
    mainball.applyForce(force);
    score = 0;
    isdone = false;
  }
  Boolean isvalidmov() {
    if (isout) {
      return false;
    } else if (is8in && balls.size() > 0) {
      return false;
    } else if (is8in && balls.size() == 0) {
      return true;
    }
    return true;
  }
  Boolean done() {
    if (!isout) {
      Vec2 vel = mainball.b.getLinearVelocity();
      if (!(vel.length() == 0)) {
        return false;
      }
    }
    if (!is8in) {
      Vec2 vel = gameball.b.getLinearVelocity();
      if (!(vel.length() == 0)) {
        return false;
      }
    }
    for (ball b : balls) {
      Vec2 vel = b.b.getLinearVelocity();
      if (!(vel.length() == 0)) {
        return false;
      }
    }
    return true;
  }
  void killall() {
    if (!isout) {
      mainball.killbody();
    } 
    if (!is8in) {
      gameball.killbody();
    }
    t.killall();
    for (ball b : balls) {
      b.killbody();
    }
  }
}
