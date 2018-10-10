class DNA {
  int genes[];
  float fit=0;
  DNA(int size) {
    genes=new int[size];
    for(int i=0;i<genes.length;i++) {
      genes[i]=int(random(0,10));
      
      
    } 
    
    
  } 
 void mutation(float m) {
   for(int i=0;i<genes.length;i++) {
     if(random(1)<m) {
       genes[i]=int(random(0,10));
       
     } 
     
   } 
   
 } 
 DNA crossover(DNA a,int size) {
   DNA child=new DNA(size);
   int mid=int(random(0,genes.length));
   for(int i=0;i<genes.length;i++) {
     if(i>mid) {
       child.genes[i]=genes[i];
       
     } 
     else {
       child.genes[i]=a.genes[i];
       
     } 
     
   }
   return child;
   
 } 
 void calcFitness() {
   int count=0;
   for(int i=0;i<genes.length;i++) {
     if(genes[i]==target[i]) {
       count++;
       
     }
     fit=(float)count/(float)genes.length;
     fit=pow(fit,2);
    
     
   } 
  
 }  
 int[] getTheArray() {
   
   return genes;
   
 } 
  
  
} 