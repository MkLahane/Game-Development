function Cell(i,j,l) {
    this.i=i;
    this.j=j;
    this.x=j*l;
    this.y=i*l;
    this.l=l;
    this.numberMines=0;
    this.revealed=false;
    this.mine=false;
    
    
    this.show=function() {
        noFill();
        stroke(0);
        
        
        
        rect(this.x,this.y,this.l,this.l);
        
        if(this.revealed) {
            
            if(this.mine) {
                fill(255,0,0);
                
                ellipse(this.x+this.l*0.5,this.y+this.l*0.5,this.l*0.5);
                
            }
        
            
            else {
                fill(200);
                rect(this.x,this.y,this.l,this.l);
                if(this.numberMines>0) {
                    textAlign(CENTER);
                    fill(0);
                    text(this.numberMines,this.x+this.l*0.5,this.y+this.l*0.5);
                }
            } 
        }
        
    }
    
   
    
    
    
    
    this.contains=function(x,y) {
        return ((x>this.x && x<this.x+this.l) && (y>this.y && y<this.y+this.l));
        
    }
    
    this.countMines=function() {
        
        if(this.mine) { 
           this.numberMines=-1;
        }
        var total=0;
        
        for(var yoff=-1;yoff<=1;yoff++) {
            
            for(var xoff=-1;xoff<=1;xoff++) {
                
                var i=this.i+yoff;
                var j=this.j+xoff;
                
                if(i>-1 && i<rows && j>-1 && j<cols) {
                
                    var neighbor=grid[i][j];
                    if(neighbor.mine) {
                        total++;
                    }
                }
            }
            
        }
      
        
        this.numberMines=total;
    }


    
    
    
    this.reveal=function() {
        
        
        
        this.revealed=true;
        
        if(this.numberMines===0) {
            //flood fill
            
            this.floodFill();
        }
        
        
    }
    
    
    
    
    
}




 Cell.prototype.floodFill=function() {
         
        for(var yoff=-1;yoff<=1;yoff++) {
            
            for(var xoff=-1;xoff<=1;xoff++) {
                
                var i=this.i+yoff;
                var j=this.j+xoff;
                if(i>-1 && i<rows && j>-1 && j<cols) {
                    
                    var neighbor=grid[i][j];
                    if(!neighbor.mine && !neighbor.revealed) {
                        neighbor.reveal();
                        
                }
            }
                
        }
            
    }
        
        
}


