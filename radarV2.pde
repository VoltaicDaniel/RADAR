import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial Puerto;

String distancia = "";
String angulo = "";
String datos = "";
int indice1 = 0;
int indice2 = 0;
int Angulo2, Distancia2;
float pixeles;
PImage img;

void setup(){
  size(1240, 720);
  smooth(4);
  Puerto = new Serial(this, "COM3", 9600);
  Puerto.bufferUntil('~');
  //img = loadImage("igames.jpg");
}

void draw(){
 background(250,0,150);  
 fill(10, 10, 10);
 noStroke();
 radar();
 linea();
 objetoD();
 texto();
}

void serialEvent(Serial Puerto){
  datos = Puerto.readStringUntil('~');
  datos = datos.substring(0,datos.length()-1);
  indice1 = datos.indexOf(";");
  angulo = datos.substring(0, indice1);
  distancia = datos.substring(indice1+1, datos.length());
  Angulo2 = int(angulo);
  Distancia2 = int(distancia);
  
}

void radar(){
   pushMatrix();
   translate(620, 720);
   noFill();
   strokeWeight(4);
   stroke(0);
   arc(0, 0, 1200, 1200, PI, TWO_PI);
   arc(0, 0, 1000, 1000, PI, TWO_PI);
   arc(0, 0, 800, 800, PI, TWO_PI);
   arc(0, 0, 600, 600, PI, TWO_PI);
   line(0, 0, -620*cos(radians(0)), -620*sin(radians(0)));
   line(0, 0, -620*cos(radians(30)), -620*sin(radians(30)));
   line(0, 0, -620*cos(radians(60)), -620*sin(radians(60)));
   line(0, 0, -620*cos(radians(90)), -620*sin(radians(90)));
   line(0, 0, -620*cos(radians(120)), -620*sin(radians(120)));
   line(0, 0, -620*cos(radians(150)), -620*sin(radians(150)));
   line(-620*cos(radians(30)), 0, 620, 0);
   popMatrix();
}  


void linea(){
  pushMatrix();
  strokeWeight(7);
  stroke(30, 250, 60);
  translate(620, 720);
  line(0,0, 610*cos(radians(Angulo2)), -950*sin(radians(Angulo2)));
  popMatrix();
}

void objeto(){
  pushMatrix();
  translate(620,720);
  strokeWeight(4);
  stroke(255,10,10);
  pixeles = Distancia2*22.5;
  if(Distancia2 < 40){
    line(pixeles*cos(radians(Angulo2)),-pixeles*sin(radians(Angulo2)),950*cos(radians(Angulo2)),-950*sin(radians(Angulo2)));
  }
  popMatrix();
}

void texto(){
pushMatrix();
  if(Distancia2 > 40){
    objeto = "No hay objetos";
  }
  else{
    objeto = "Objeto detectado";
  }
  fill(0,0,0);
  noStroke();
  rect(0, 0, width, 600);
  fill(98,245,31);
  textSize(25);
  text("10cm",1180,990);
  text("20cm",1380,990);
  text("30cm",1580,990);
  text("40cm",1780,990);
  textSize(40);
  text("Objeto: " + objeto, 100, 650);
  text("Angulo: " + Angulo2 +" °", 300, 650);
  text("Distancia: ", 600, 650);
  if(Distancia2 < 40) {
    text("        " + Distancia2 +" cm", 620, 650);
  }
  textSize(25);
  fill(98,245,60);
  translate(621+620*cos(radians(30)),642-620*sin(radians(30)));
  rotate(-radians(-60));
  text("30°",0,0);
  resetMatrix();
  translate(614+620*cos(radians(60)),644-620*sin(radians(60)));
  rotate(-radians(-30));
  text("60°",0,0);
  resetMatrix();
  translate(605+620*cos(radians(90)),650-620*sin(radians(90)));
  rotate(radians(0));
  text("90°",0,0);
  resetMatrix();
  translate(595+620*cos(radians(120)),663-620*sin(radians(120)));
  rotate(radians(-30));
  text("120°",0,0);
  resetMatrix();
  translate(600+620*cos(radians(150)),678-620*sin(radians(150)));
  rotate(radians(-60));
  text("150°",0,0);
  popMatrix(); 
}
