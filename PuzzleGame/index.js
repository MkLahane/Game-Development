let data=[];
let puzzleImage;
let puzzleData=[];
let spacing=100;
let emptySpot;
let imgH=500;
let imgW=500;
let winHtml;
function preload() {
    for(let i=1;i<=5;i++) {
        let img=loadImage('dog'+i+'.jpg');
        data.push(img);
    }
}
function setup() {
    createCanvas(1000,700);
    winHtml=createP('');
    for(let i=0;i<data.length;i++) {
        let img=data[i];
        //console.log(img);
        img.resize(imgH,imgW);
    }
    init();
}
function init() {
    puzzleImage=random(data);
    puzzleData=[];
    for(let y=0;y<puzzleImage.height;y+=spacing) {
        for(let x=0;x<puzzleImage.width;x+=spacing) {
            let img=puzzleImage.get(x,y,spacing,spacing);
            let imgData={};
            imgData.x=x;
            imgData.y=y;
            imgData.inVal=puzzleData.length;
            imgData.val=puzzleData.length;
            imgData.image=img;
            puzzleData.push(imgData);
        }
    }
    let emptyImage=puzzleData[0];
    let currentLen=puzzleData.length;
    while(currentLen>1) {
        let index=floor(random(0,1)*currentLen);
        currentLen--;
        let tempImg=puzzleData[currentLen].image;
        let tempVal=puzzleData[currentLen].image;
        puzzleData[currentLen].image=puzzleData[index].image;
        puzzleData[currentLen].val=puzzleData[index].val;
        puzzleData[index].val=tempVal;
        puzzleData[index].image=tempImg;
        
    }

    let img=emptyImage.image;
    img.loadPixels();
    for(let i=0;i<img.pixels.length;i++) {
        let index=i*4;
        //red
        img.pixels[index+0]=50;
        //green
        img.pixels[index+1]=50;
        //blue
        img.pixels[index+2]=50;
        //alpha
        img.pixels[index+3]=255;
    }
    img.updatePixels();
    emptySpot=emptyImage;
    puzzleImage.resize(300,300);
}
function draw() {
    background(0);
    image(puzzleImage,700,50);
    for(let i=0;i<puzzleData.length;i++) {
        let img=puzzleData[i];
        image(img.image,img.x*1.1+30,img.y*1.1+20,spacing,spacing);
    }
    stroke(0,255,0);
    strokeWeight(3);
    noFill();
    rect(emptySpot.x*1.1+30,emptySpot.y*1.1+20,spacing,spacing);

    if(checkWin()) {
        winHtml.html("You won the game");
    }
}

function checkWin() {
    let win=true;
    for(let i=1;i<puzzleData.length;i++) {
        if(puzzleData[i].val!=puzzleData[i].inVal) {
            win=false;
            break;
        }
    }
    return win;
}

function keyPressed() {
    let newSpot;
    if(keyCode==RIGHT_ARROW) {
        let aImgIndex=emptySpot.inVal;
        let bImgIndex=emptySpot.inVal+1;
        if(bImgIndex<puzzleData.length && puzzleData[aImgIndex].y==puzzleData[bImgIndex].y) {
            let tempImage=puzzleData[bImgIndex].image;
            puzzleData[bImgIndex].image=puzzleData[aImgIndex].image;
            puzzleData[aImgIndex].image=tempImage;
            emptySpot=puzzleData[bImgIndex];

        }
    }
    if(keyCode==LEFT_ARROW) {
        let aImgIndex=emptySpot.inVal;
        let bImgIndex=emptySpot.inVal-1;
        if(bImgIndex>=0 && puzzleData[aImgIndex].y==puzzleData[bImgIndex].y) {
            let tempImage=puzzleData[bImgIndex].image;
            puzzleData[bImgIndex].image=puzzleData[aImgIndex].image;
            puzzleData[aImgIndex].image=tempImage;
            emptySpot=puzzleData[bImgIndex];

        }
    }
    if(keyCode==DOWN_ARROW) {
        let aImgIndex=emptySpot.inVal;
        let rows=floor(imgH/spacing);
        let aImgR=floor(aImgIndex/rows);
        let aImgC=floor(aImgIndex%rows);
        let bImgR=aImgR+1;
        let bImgIndex=bImgR*rows+aImgC;
        if(bImgIndex<puzzleData.length && puzzleData[aImgIndex].x==puzzleData[bImgIndex].x) {
            let tempImage=puzzleData[bImgIndex].image;
            puzzleData[bImgIndex].image=puzzleData[aImgIndex].image;
            puzzleData[aImgIndex].image=tempImage;
            emptySpot=puzzleData[bImgIndex];

        }
    }
    if(keyCode==UP_ARROW) {
        let aImgIndex=emptySpot.inVal;
        let rows=floor(imgH/spacing);
        let aImgR=floor(aImgIndex/rows);
        let aImgC=floor(aImgIndex%rows);
        let bImgR=aImgR-1;
        let bImgIndex=bImgR*rows+aImgC;
        if(bImgIndex>=0 && puzzleData[aImgIndex].x==puzzleData[bImgIndex].x) {
            let tempImage=puzzleData[bImgIndex].image;
            puzzleData[bImgIndex].image=puzzleData[aImgIndex].image;
            puzzleData[aImgIndex].image=tempImage;
            emptySpot=puzzleData[bImgIndex];

        }
    }
    
}

