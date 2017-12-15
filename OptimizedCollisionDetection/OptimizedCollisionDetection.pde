Circle circles[];
int rows=2;
int cols=2;
ArrayList<Group> groups;
ArrayList<Circle> first;
ArrayList<Circle> second;
ArrayList<Circle> third;
ArrayList<Circle> fourth;
void setup() {
  size(700,700);
  groups=new ArrayList<Group>();
  fourth=new ArrayList<Circle>();
  first=new ArrayList<Circle>();
  second=new ArrayList<Circle>();
  third=new ArrayList<Circle>();
  circles=new Circle[2000];
  for(int i=0;i<circles.length;i++) {
    circles[i]=new Circle(new PVector(random(width),random(height)),random(10,25));
  }
  for(int i=0;i<rows;i++) {
    for(int j=0;j<cols;j++) {
      groups.add(new Group(i,j,width/cols,height/rows));
    } 
  }
  groups.get(0).groupName="second";
  groups.get(1).groupName="first";
  groups.get(2).groupName="third";
  groups.get(3).groupName="fourth";
  
} 

void draw() {
  background(0);
  
  createGroups();
  addToGroups();
  
  /*for(int i=0;i<circles.length;i++) {
    circles[i].show();
    circles[i].update();
    boolean collided=false;
    for(int j=0;j<circles.length;j++) {
      if(j!=i && circles[i].collided(circles[j])) {
        collided=true;
      }
    } 
    if(collided) {
      circles[i].col=255;
    } else {
      circles[i].col=0;
    } 
  } */
  
  for(Circle circle:circles) {
    circle.show();
    circle.update();
    if(circle.group=="first") {
      checkCollisionWithGroup(circle,first);
    } else if(circle.group=="second") {
      checkCollisionWithGroup(circle,second);
    } else if(circle.group=="third") {
      checkCollisionWithGroup(circle,third); 
    }else if(circle.group=="fourth") {
      checkCollisionWithGroup(circle,fourth);
    } 
  } 
  
  for(Group group:groups) {
    group.show();
  } 
}

void checkCollisionWithGroup(Circle obj,ArrayList<Circle> group) {
  boolean collided=false;
  for(Circle circle:group) {
    if(circle!=obj) {
      if(circle.collided(obj)) {
        collided=true;
      } 
    } 
  }
  if(collided) {
    obj.col=255;
  } else {
    obj.col=0;
  } 
} 

void addToGroups() {
  for(Circle circle:circles) {
    if(circle.group=="first") {
      addToGroups(circle,first);
    } else if(circle.group=="second") {
      addToGroups(circle,second);
    } else if(circle.group=="third") {
      addToGroups(circle,third);
    } else if(circle.group=="fourth") {
      addToGroups(circle,fourth);
    } 
    
  } 
} 

void addToGroups(Circle circle,ArrayList<Circle> gr) {
  for(Circle g:gr) {
    if(g==circle) {
      return;
    } 
  } 
  gr.add(circle);
} 

void createGroups() {
  for(Circle circle:circles) {
    for(Group group:groups) {
      if(circle.loc.x>group.x && circle.loc.x+circle.r/2<group.x+group.w && circle.loc.y>group.y && circle.loc.y<group.y+group.h) {
        circle.group=group.groupName;
      } 
    } 
  } 
} 