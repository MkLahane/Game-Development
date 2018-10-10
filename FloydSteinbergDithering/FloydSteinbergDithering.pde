PImage dogImage;
void setup() {
  size(700,350);
  dogImage=loadImage("dog2.jpg");
  //dogImage.filter(GRAY);
  image(dogImage,0,0);
  //println(dogImage.pixels.length);
}

int getIndex(int x,int y) {
  return x+y*dogImage.width;
} 

void draw() {
  dogImage.loadPixels();
  for(int y=0;y<dogImage.height-1;y++) {
    for(int x=1;x<dogImage.width-1;x++) {
      color pix=dogImage.pixels[getIndex(x,y)]; 
      int factor=1;
      float r=red(pix);
      float g=green(pix);
      float b=blue(pix);
      int newr=round(factor*r/255)*(255/factor);
      int newg=round(factor*g/255)*(255/factor);
      int newb=round(factor*b/255)*(255/factor);
      
      dogImage.pixels[getIndex(x,y)]=color(newr,newg,newb);
      
      float errorR=r-newr;
      float errorG=g-newg;
      float errorB=b-newb;    
      
      
      int index=getIndex(x+1,y);
      color col=dogImage.pixels[index];
      float rd=red(col)+errorR*7/16.0;
      float gr=green(col)+errorG*7/16.0;
      float bl=blue(col)+errorB*7/16.0;
      dogImage.pixels[index]=color(rd,gr,bl);
      
      index=getIndex(x-1,y+1);
      col=dogImage.pixels[index];
      rd=red(col)+errorR*3/16.0;
      gr=green(col)+errorG*3/16.0;
      bl=blue(col)+errorB*3/16.0;
      dogImage.pixels[index]=color(rd,gr,bl);
      
      index=getIndex(x,y+1);
      col=dogImage.pixels[index];
      rd=red(col)+errorR*5/16.0;
      gr=green(col)+errorG*5/16.0;
      bl=blue(col)+errorB*5/16.0;
      dogImage.pixels[index]=color(rd,gr,bl);
      
      index=getIndex(x+1,y+1);
      col=dogImage.pixels[index];
      rd=red(col)+errorR*1/16.0;
      gr=green(col)+errorG*1/16.0;
      bl=blue(col)+errorB*1/16.0;
      dogImage.pixels[index]=color(rd,gr,bl);
    } 
  } 
  dogImage.updatePixels();
  image(dogImage,350,0);
} 