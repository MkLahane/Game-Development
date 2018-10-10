let points = [];

let convexHullPoints = [];

let temp = [];
let numOfPoints = 10;
let spacing;

function setup() {
  createCanvas(600, 600);
  spacing = width / numOfPoints
  for (let i = 0; i < numOfPoints; i++) {
    points.push(createVector(i * spacing + 50, random(height / 2 - 100, height - 50)));
  }
  points.sort((a, b) => {
    return (a.x == b.x) ? a.y - b.y : a.x - b.x;
  });
  let lowerConvexHullPoints = [];
  let upperConvexHullPoints = [];
  for (let i = 0; i < points.length; i++) {
    while (lowerConvexHullPoints.length >= 2 && getArea(lowerConvexHullPoints[lowerConvexHullPoints.length - 2],
        lowerConvexHullPoints[lowerConvexHullPoints.length - 1],
        points[i]) <= 0) {
      lowerConvexHullPoints.pop();
    }
    lowerConvexHullPoints.push(points[i]);
  }
  for (let i = points.length - 1; i >= 0; i--) {
    while (upperConvexHullPoints.length >= 2 && getArea(upperConvexHullPoints[upperConvexHullPoints.length - 2],
        upperConvexHullPoints[upperConvexHullPoints.length - 1],
        points[i]) <= 0) {
      upperConvexHullPoints.pop();
    }
    upperConvexHullPoints.push(points[i]);
  }
  lowerConvexHullPoints.pop();
  upperConvexHullPoints.pop();
  convexHullPoints = lowerConvexHullPoints.concat(upperConvexHullPoints);
}

function getArea(a, b, p) {
  return (a.x - p.x) * (b.y - p.y) - (a.y - p.y) * (b.x - p.x);
}

function draw() {
  background(0);
  noFill();
  stroke(0, 255, 0);
  strokeWeight(2);
  beginShape();
  for (let p of convexHullPoints) {
    vertex(p.x, p.y);
  }
  endShape(CLOSE);
  stroke(255);
  strokeWeight(8);
  for (let p of points) {
    point(p.x, p.y);
  }
}
