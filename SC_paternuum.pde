
import supercollider.*;
import oscP5.*;

ArrayList instruments;
Synth live;

float baseFreq = 1.0 ;//523.25/4.0;

boolean listen = false;


float tuning[] = {
  55, 61.735, 65.406, 73.416, 82.407, 87.307, 97.999, 110, 123.471, 130.813, 146.832, 
  164.814, 174.614, 195.998, 220, 233.082, 246.942, 261.626, 293.665, 329.628, 349.228, 391.995, 440.0, 493.883, 523.251, 587.33,
};

String synthD = "sin";

int caret = 0;

int tick = 15;
int time = 0;
int al = 0;

boolean first = false;

String input = "";

void setup() {
  size(800, 400, P2D); 
  textFont(loadFont("Monospaced.plain-10.vlw"));
  textMode(SCREEN);
  frameRate(60);

  instruments = new ArrayList();
  live = new Synth("sin");
}

void draw() {
  timer();
  background(0);

fill(255,al);
  rect((caret)*6+10, 20+instruments.size()*10-9, 6, 10);
  
  fill(255);
  text(input, 10, 20+instruments.size()*10);

  


  grid();


  for (int i = 0;i<instruments.size();i++) {
    Instrument tmp = (Instrument)instruments.get(i);
    tmp.trigger();
    tmp.draw();
  }

  panel();
}

void panel() {
  int cnt = 0;
  for (char c = 'a';c<='z';c++) {
    if (cnt%2==0)
      fill(255);
    else
      fill(#ffcc00);

    cnt++;
    text(c, cnt*8, height-10);
  }


  text("tempo => "+(60.0/(tick+0.0))*60, width-100, height-10);

  if (first)
    al = 220;

  if (al>0)
    al-=20;

  fill(#ffcc00, al);
  rect(width-110, height-15, 5, 5);
}

void grid() {
  stroke(255, 90);

  for (int i = 10+5*6;i<width;i+=(4*6)) {
    line(i, 10, i, instruments.size()*10+20);
  }

  noStroke();
}

void timer() {

  first = false;

  if (frameCount%tick==0) {
    time++;
    first =  true;
  }
}





void keyPressed() {
  if (key>='a'&&key<='z'||key==' '||key=='>'||key=='='||key=='!'||(key>='0'&&key<='9')) {
    if (listen && (key>='a'&&key<='z')) {
      float harmonics = tuning[(int)key-97] * baseFreq;//(pow(3.0, (freq)/12.0+1.0 )) * baseFreq + baseFreq;

      live.set("freq", harmonics);
      live.set("amp", random(3, 10)*0.02);
      live.set("dur", 0.5);
      live.create();
    }

    input = input.substring(0, caret)+key+input.substring(caret, input.length());
    caret++;
  }
  else if (keyCode==ENTER) {
    addInstrument();
    caret = constrain(caret, 0, input.length());
  }
  else if (keyCode==BACKSPACE) {
    if (input.length()>0){
      input =  input.substring(0, caret-1)+input.substring(caret,input.length());
      caret--;
    caret = constrain(caret, 0, input.length());
    }
  }
  else if (keyCode==DELETE) {
    if (instruments.size()-1>0);
    instruments.remove(instruments.size()-1);
  }
  else if (keyCode==UP) {
    tick--;
    tick=constrain(tick, 1, 200);
  }
  else if (keyCode==DOWN) {
    tick++;
    tick=constrain(tick, 1, 200);
  }
  else if (key=='`') {
    listen=!listen;
  }
  else if (keyCode==LEFT) {
    caret--;
    caret = constrain(caret, 0, input.length());
  }
  else if (keyCode==RIGHT) {
    caret++; 

    caret = constrain(caret, 0, input.length());
  }
}

void addInstrument() {

  instruments.add(new Instrument(instruments.size(), synthD, input));
  input = "";
}

void exit() {
  for (int i = 0;i<instruments.size();i++) {
    Instrument tmp = (Instrument)instruments.get(i);
    tmp.free();
  }
  super.exit();
}

