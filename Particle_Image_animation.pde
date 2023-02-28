boolean flee_mouse = false;
float maxSpeed = 5;
float maxForce = 3;
int start_mode = 4; //0 = random - particles start randomly across screen
                    //1 = randomer - particles start with random pos and vel
                    //2 = dot - paricles start at singularity in centre
                    //3 = corner- particles start at singularity in NW corner
                    //4 = circle - particles explode from centre in circle
                    
PImage bg;
ArrayList<Particle> balls;

void setup(){
  size(400,400,P2D);
  //fullScreen(P2D);
  colorMode(HSB);
  bg = loadImage("image.jpg");
  bg.resize(width,height);

  balls = new ArrayList<Particle>();
  for (int x = 0; x < bg.width; x++){
     for (int y = 0; y < bg.height; y++){
        int loc = x + (y*bg.width);

        color col = bg.pixels[loc];
          
        PVector target = new PVector(x,y);
        PVector pos;
        PVector vel;
        if(start_mode == 1){ //randomer
          pos = new PVector(random(width),random(height));
          vel = PVector.random2D();
          vel.mult(random(100));
          
        }else if(start_mode == 2){ //dot
          pos = new PVector(width/2,height/2);
          vel = new PVector(0,0);
          
        }else if(start_mode == 3){ //corner
          pos = new PVector(0,0);
          vel = new PVector(0,0);
          
        }else if(start_mode == 4){ //circle
          pos = new PVector(width/2,height/2);
          vel = PVector.random2D();
          vel.mult(30);
          
        }else{ //default to 0 = random mode
          pos = new PVector(random(width),random(height));
          vel = new PVector(0,0);
        }
        
        Particle ball = new Particle(target, pos, vel, col);
        balls.add(ball);
     }
  }
}

void keyPressed(){
  if(key==' '){
    for (Particle p : balls){
      p.mode = false;
    }
  }
}

void draw(){
  stroke(255);
  background(0);
  for (Particle p : balls){
    p.behaviours();
    p.update();
    p.show();
  }

}
