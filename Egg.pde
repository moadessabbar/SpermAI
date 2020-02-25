class Egg {
  
  int size;
  PVector pos;
  
  Egg() {
    size = 30;
    pos  = new PVector( width/2, size);
  }
  
  Egg( int s ) {
    size = s;
    pos  = new PVector( width/2, size);
  }
   
  //Draw the Egg on the screen
  void show() {
    noStroke();
    fill(255, 0, 0);
    ellipse( pos.x, pos.y, size, size);
  }
}
