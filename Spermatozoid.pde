class Spermatozoid {

  int size;
  PVector pos;
  PVector vel;
  PVector acc;
  Brain B;
  boolean dead = false;
  boolean reachedEgg = false;
  int step = 0;
  float fitness;
  
  Spermatozoid() {
    size= 5;
    pos = new PVector( width/2, height - size);
    vel = new PVector( 0, 0);
    acc = new PVector( 0, 0);
    B   = new Brain();
  }
  
  Spermatozoid( int s, int sB) {
    size = s;
    pos  = new PVector( width/2, height - size);
    vel  = new PVector( 0, 0);
    acc  = new PVector( 0, 0);
    B    = new Brain(sB);
  }
  
  //Draw the Spermatozoid on the screen
  void show(int col) {
    fill(col);
    ellipse(pos.x, pos.y, size, 2*size);
    stroke(col);
    line(pos.x, pos.y + size, pos.x, pos.y + 3*size);
    //ellipse(pos.x, pos.y, size, size);
  }
  
  //Moves the Spermatozoid and checks for collisions and stuff
  void update( Egg E) {
    int halfSize = size/2;
    //if near the edges of the window then kill it
    if (pos.x < halfSize|| pos.y < halfSize || pos.x > width - halfSize || pos.y > height - halfSize) {
        dead = true;
    }
    //if reached goal
    else if ( dist( pos.x, pos.y, E.pos.x, E.pos.y) < E.size/2 ) {
        reachedEgg = true;
        dead = true;
    }
    //if hits the obstacle
    else if (pos.x< 350 && pos.y < 410 && pos.x > 0 && pos.y > 400) {
        dead = true;
    }
    /*else if (pos.x< 1070 && pos.y < 830 && pos.x > 400 && pos.y > 800) {
        dead = true;
    }*/
    else {
      if ( step < B.directions.length ) {
        acc = B.directions[step];
        vel.add(acc);
        pos.add(vel);
        vel.limit(5);
        step++;
      }
      else {
        dead = true;
      }
    }
  }
   
  //Calculate Spermatozoid fitness
  //(the closer to the Egg the better and the least steps to reach the Egg the better)
  void calculateFitness( Egg E) {
    float distanceToEgg = dist( pos.x, pos.y, E.pos.x, E.pos.y);
    fitness = 1.0 / (distanceToEgg * distanceToEgg);
    if( reachedEgg) {
      fitness = 5.0 * fitness / (step*step); 
    }
    else {
      fitness = fitness / (B.size*B.size);
    }
  }
  
  //clone
  Spermatozoid clone() {
    Spermatozoid clone = new Spermatozoid();
    clone.B = B.clone();
    clone.step = step;
    return clone;
  }

}
