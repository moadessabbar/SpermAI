class Sperm {
 
  int size;
  Spermatozoid[] S;
  float fitnessSum;
  Spermatozoid bestSpermatozoid = new Spermatozoid();
  
  Sperm() {
    size = 200;
    S = new Spermatozoid[size];
    for( int i = 0; i < size; i++) {
      S[i] = new Spermatozoid();
    }
  }
  
  Sperm( int s) {
    size = s;
    S = new Spermatozoid[size];
    for( int i = 0; i < size; i++) {
      S[i] = new Spermatozoid();
    }
  }
  
  //Draw the Sperm on the screen
  void show() {
    for( int i = 1; i < size; i++) {
      S[i].show(255);
    }
    S[0].show(#00FF00);
  }
  
  //Move the Sperm
  void update( Egg E) {
    for( int i = 0; i < size; i++) {
      S[i].update(E);
    }
  }
  
  //if all Spermatozoids are dead
  boolean allSpermDead() {
    for( int i = 0; i < size; i++) {
      if( !(S[i].dead)) {
        return false;
      }
    }
    return true;
  }
  
  //Success rate : reaching the egg
  int successRate() {
    int successRate = 0;
    for( int i = 0; i < size; i++) {
      if( S[i].reachedEgg) {
        successRate++;
      }
    }
    return successRate;
  }
  
  //Calculate Fitness of every Spermatozoid
  void calculateFitness(Egg E) {
    float bestFitness = 0;
    for (int i = 0; i< size; i++) {
      S[i].calculateFitness(E);
      if ( S[i].fitness > bestFitness) {
        bestFitness = S[i].fitness;
        bestSpermatozoid = S[i];
      }
    }
  }
  
  //Self-explanatory
  void calculateFitnessSum() {
    fitnessSum = 0;
    for (int i = 0; i< size; i++) {
      fitnessSum = fitnessSum + S[i].fitness;
    }
  }

  /*chooses a spermatozoid from the population to return
  randomly(considering fitness) : this function
  works by randomly choosing a value between 0
  and the sum of all the fitnesses
  then goes through all the spermatozoids and adds
  their fitness to a running sum and if that
  sum is greater than the random value generated
  that spermatozoid is chosen. Since spermatozoids with a higher
  fitness function add more to the running sum
  they have a higher chance of being chosen*/
  Spermatozoid selectParent() {
    float rand = random(fitnessSum);
    float runningSum = 0;
    for (int i = 0; i < size; i++) {
      runningSum += S[i].fitness;
      if (runningSum > rand) {
        return S[i];
      }
    }
    //should never get to this point
    return null;
  }
  
  //Natural selection
  void naturalSelection(){
    calculateFitnessSum();
    Spermatozoid[] SNew = new Spermatozoid[size];
    for( int i = 0; i < size; i++) {
      SNew[i]   = new Spermatozoid();
      SNew[i].B = selectParent().B.clone();
    }
    S = SNew;
  }
  
  //Mutation
  void mutation( float mutationRate) {
    for( int i = 0; i < size; i++) {
      S[i].B.mutate(mutationRate);
    }
    //keep the brain of the best Spermatozoid
    //unchanged to avoid negative evolution
    S[0].B = bestSpermatozoid.B.clone();
  }

}
