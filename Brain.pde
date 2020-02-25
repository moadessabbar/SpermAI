class Brain {
 
  PVector[] directions;
  int size;
  
  Brain() {
    size = 1000;
    directions = new PVector[size];
    randomize();
  }
  
  Brain( int s ) {
    size = s;
    directions = new PVector[size];
    randomize();
  }
  
  //Create random directions
  void randomize() {
    for ( int i = 0; i < size; i++) {
        directions[i] = PVector.random2D();
    }
  }
  
  //clone
  Brain clone() {
    Brain clone = new Brain(size);
    for ( int i = 0; i < size; i++) {
      clone.directions[i] = directions[i];
    }
    return clone;
  }
  
  //Mutate
  void mutate( float mutationRate) {
    for ( int i = 0; i < size; i++) {
      if ( random(1) < mutationRate) {
        directions[i] = PVector.random2D();
      }
    }
  }
  
  
}
