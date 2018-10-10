class Armature {
  Bone bones[];
  PVector base;
  int len;
  Armature(int size,float x,float y,int _len) {
    bones=new Bone[size];
    len=_len;
    bones[0]=new Bone(new PVector(200,300),len);
    for(int i=1;i<bones.length;i++) {
      bones[i]=new Bone(bones[i-1],len);
    }
    base=new PVector(x,y);
  } 
  
  void update() {
    int end=bones.length-1;
    bones[end].follow(particle.loc);
    bones[end].update();
  
    for(int i=bones.length-2;i>=0;i--) {
      bones[i].follow(bones[i+1]);
      bones[i].update();
    } 
    bones[0].setA(base);
    for(int i=1;i<bones.length;i++) {
      bones[i].setA(bones[i-1].end);
    } 
     
    
  } 
  void show() {
    for(Bone bone:bones) {
      bone.show();
    }
    
  } 
  
  
} 