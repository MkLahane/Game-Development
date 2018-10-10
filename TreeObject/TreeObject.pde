ArrayList<Branch> tree=new ArrayList<Branch>();
ArrayList<PVector> leaves=new ArrayList<PVector>();
void setup() {
  size(600,600);
  PVector a=new PVector(width/2,height);
  PVector b=new PVector(width/2,height-200);
  tree.add(new Branch(a,b));
 
} 

void mousePressed() {
  for(int  i=tree.size()-1;i>=0;i--) {
    if(!tree.get(i).branched) {
      Branch right=tree.get(i).branchRight();
      Branch left=tree.get(i).branchLeft();
      tree.add(right);
      tree.add(left);
      leaves.add(right.end);
      leaves.add(left.end);
    }
    tree.get(i).branched=true;
  } 
} 


void draw() {
  background(0);
  for(int i=0;i<tree.size();i++) {
    tree.get(i).show();
  }
 
  for(int i=0;i<leaves.size();i++) {
    fill(0,255,0);
    ellipse(leaves.get(i).x,leaves.get(i).y,10,10);
  } 

  
} 