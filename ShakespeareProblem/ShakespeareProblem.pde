int target[]={2,6,3,8,9,7,4,6,9,9};
ArrayList<Integer> best=new ArrayList<Integer>();
Population pop;
int gen=0;
void setup() {
  size(600,600);
  pop=new Population(300,0.01,10);
  
} 

void draw() {
  background(255);
  //pop.show();
  int[] best=pop.getBest();
  for(int i=0;i<best.length;i++) {
    print(best[i]+" ");
  } 
  println();
  pop.fitness();
  pop.selection();
  pop.check();
  //if(pop.done()) {
  //  noLoop();
    
  //} 
  gen++;
  println("Number of generation:"+gen);
  
} 