class Population {
  DNA dna[];
  ArrayList<DNA> matingPool;
  float rate;
  int gnSize;
  boolean over;
  int perfectScore;
  Population(int size,float rate,int gnSize) {
    this.rate=rate;
    dna=new DNA[size];
    this.gnSize=gnSize;
    matingPool=new ArrayList<DNA>();
    
    for(int i=0;i<dna.length;i++) {
      dna[i]=new DNA(gnSize);
      
    } 
    fitness();
    over=false;
    perfectScore=int(pow(2,target.length));
    
  } 
  void fitness() {
    matingPool.clear();
    for(int i=0;i<dna.length;i++) {
      dna[i].calcFitness();    
        
    }
    float maxfitness=0;
    for(int i=0;i<dna.length;i++) {
      if(maxfitness<dna[i].fit) {
        maxfitness=dna[i].fit;
        
      } 
      
    } 
    for(int i=0;i<dna.length;i++) {
      float fitness=map(dna[i].fit,0,maxfitness,0,1);
      int n=int(dna[i].fit*100);
      for(int j=0;j<n;j++) {
        matingPool.add(dna[i]);
        
      } 
    } 
    
    
  }
  void check() {
    for(int i=0;i<dna.length;i++) {
      int count=0;
      for(int j=0;j<gnSize;j++) {
        if(dna[i].genes[j]==target[j]) {
          count++;
          
        } 
        
          
          
        }
        if(count>=gnSize) {
          noLoop();
          over=true;
          for(int k=0;k<gnSize;k++) {
            best.add(dna[i].genes[k]);
            
          }
          break;
      } 
      
      
    }
    if(over) {
      println("Decoded the secret series using genetic algorithm and the series is\n----"+best);
      
    } 
    
    
  } 
  
  int[] getBest() {
    float worldRecord=0.0f;
    int index=0;
    for(int i=0;i<dna.length;i++) {
      if(dna[i].fit>worldRecord) {
        index=i;
        worldRecord=dna[i].fit;
        
      } 
      
    } 
    if(worldRecord==perfectScore) {
      over=true;
      
    } 
    return dna[index].getTheArray();
    
  } 
  boolean done() {
    return over;
    
  } 
  void selection() {
    for(int i=0;i<dna.length;i++) {
      int a=int(random(0,matingPool.size()));
      int b=int(random(0,matingPool.size()));
      DNA Mom=matingPool.get(a);
      DNA Dad=matingPool.get(b);
      DNA child=Mom.crossover(Dad,gnSize);
      child.mutation(rate);
      dna[i]=child;
      
    } 
    
  } 
  void show() {
    for(int i=0;i<dna.length;i++) {
      for(int j=0;j<gnSize;j++) {
        print(dna[i].genes[j]);
        
      }
      println();
    } 
    
  } 
  
  
} 