class Vehicle {
    constructor(brain) {
        this.numberOfRays = 5;
        if (brain) {
            this.brain = brain.copy();
        } else {
            this.brain = new NeuralNetwork(this.numberOfRays, [this.numberOfRays * this.numberOfRays], 2);
        }
        this.time = 1;
        if (startPoint == null) {
            this.pos = createVector(-100, -100);
        } else {
          this.pos = startPoint.copy();  
        } //startPoint.copy();//createVector(width / 2, height / 2);
        this.rays = [];
        this.r = 5;
        this.vel = p5.Vector.random2D().mult(2);
        this.acc = createVector(0, 0);
        this.dir = this.vel.heading();
        this.minViewAngle = -PI / 4;
        this.maxViewAngle = PI / 4;
        this.maxSpeed = 20;
        this.life = LIFESPAN;
        this.finished = false;
        this.dead = false;
        this.maxForce = 0.5;
        this.fitness = 0;
        this.index = 0;
        for (let i = 0; i < this.numberOfRays; i++) {
            let a = map(i, 0, this.numberOfRays, this.minViewAngle, this.maxViewAngle);
            this.rays.push(new Ray(this.pos, this.dir + a));
        } 
    }
    show() {
        let angle = this.dir + PI / 2;
        fill(255, 175);
        stroke(255);
        strokeWeight(2);
        push();
        translate(this.pos.x, this.pos.y);
        rotate(angle);
        beginShape();
        vertex(0, -this.r * 2);
        vertex(-this.r, this.r * 2);
        vertex(this.r, this.r * 2);
        endShape(CLOSE);
        pop();
        // for (let ray of this.rays) {
        //   ray.show();
        // }
    }
    decide(walls) {
        let inputs = [];
        for (let ray of this.rays) {
            let closestD = SIGHT;
            let point = null;            
            for (let wall of walls) {
              let result = ray.cast(wall);
              if (result.isCasting) {
                let d = p5.Vector.dist(this.pos, result.pos);
                if (d < closestD) {
                  closestD = d;
                  point = result.pos;
                }
              }
            }
            if (closestD < 13) {
              this.dead = true;
            }
            inputs.push(map(closestD, 0, SIGHT, 0, 1));
            // if (point != null) {
            //   stroke(255, 150);
            //   strokeWeight(2);
            //   line(this.pos.x, this.pos.y, point.x, point.y);
            // }
        }
        let outputs = this.brain.predict(inputs);
        let outputAngle = outputs[0];
        let outputSpeed = outputs[1];
        let offset = map(outputAngle, 0, 1, -PI, PI);
        offset += this.vel.heading();
        let steering = p5.Vector.fromAngle(offset);
        let speed = map(outputSpeed, 0, 1, 0, this.maxSpeed);
        steering.setMag(speed);
        steering.sub(this.vel);
        steering.limit(this.maxForce);
        this.applyForce(steering);

    }
    checkProgress(checkPoints) {
        let currentGoal = checkPoints[this.index];
        //stroke(255, 255, 0);
        //strokeWeight(2);
        //line(currentGoal.a.x, currentGoal.a.y, currentGoal.b.x, currentGoal.b.y);
        let d = p5.Vector.dist(this.pos, checkPoints[this.index]);//linePointDistance(currentGoal.a, currentGoal.b, this.pos);
        if (d < checkPointR) {
          this.index++;
          this.life = LIFESPAN;
          if (this.index === checkPoints.length) {
            //this.finished = true;
            this.index = 0;
            this.time = 0;
            //this.pos = startPoint.copy();
          }
        }
        // for (let i = 0; i < this.index; i++) {
        //   checkPoints[i].show();
        // }
    }
    update() {
        this.vel.add(this.acc);
        this.vel.limit(this.maxSpeed);
        this.pos.add(this.vel);
        this.acc.mult(0);
        this.dir = this.vel.heading();
        for (let i = 0; i < this.rays.length; i++) {
            let a = map(i, 0, this.rays.length, this.minViewAngle, this.maxViewAngle);
            this.rays[i].dir = p5.Vector.fromAngle(this.dir + a);
        }
        this.bounds();
        this.life--;
        this.time++;

        if (this.life <= 0) {
            this.dead = true;
        }
    }
    bounds() {
        if (this.pos.x < 0 || this.pos.y < 0 || this.pos.x > width || this.pos.y > height) {
          this.dead = true;
        }
    }
    applyForce(f) {
        this.acc.add(f);
    }
    calculateFitness() {
        this.fitness = pow(2, this.index);
        //this.fitness = pow(2, this.index / this.time);
    }
    mutate(r) {
        this.brain.mutate(r);
    }
      dispose() {
        this.brain.dispose();
    }
}

function linePointDistance(a, b, p) {
    let ab = p5.Vector.sub(b, a);
    let ap = p5.Vector.sub(p, a);
    ab.normalize();
    ab.mult(ab.dot(ap));
    let normal = p5.Vector.sub(ap, ab);
    return normal.mag();
}
  