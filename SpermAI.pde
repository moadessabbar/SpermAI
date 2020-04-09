Egg   E;
Sperm S;
int size     = 500;
int gen      = 0;
int textSize = 14;
int successRate = 0;
int minSteps = 0;

void setup() {
  size(500, 800);
  E = new Egg();
  S = new Sperm(size);
  background(0);
  textSize(textSize);
  E.show();
  S.show();
}

void draw() { 
  if ( S.allSpermDead() ) {
    successRate = S.successRate()*100/size;
    minSteps = S.bestSpermatozoid.step;
    gen++;
    //Genetic Algorithm
    S.calculateFitness(E);
    S.naturalSelection();
    S.mutation(0.02);
  }
  
  background(0);
  //draw obstacle(s)
  fill(0, 0, 255);
  noStroke();
  rect(0, 400, 350, 10);
  //rect(400, 800, 670, 30);
  E.show();
  S.update(E);
  S.show();
  fill(255);
  text("Gen " + gen, 0, textSize);
  text("Success rate : " + successRate + "%", 0, 2*textSize);
  text("Min. steps : " + minSteps, 0, 3*textSize);
}
