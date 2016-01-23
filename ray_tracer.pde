///////////////////////////////////////////////////////////////////////
//
//  Ray Tracing Shell
//
///////////////////////////////////////////////////////////////////////

int screen_width = 300;
int screen_height = 300;

float fov;
PVector bgcolor = new PVector();
PVector screenPos = new PVector();
// Store latest reflectance constants
PVector ka = new PVector(0,0,0);
PVector kd = new PVector(0,0,0);
// Arrays to store properties of objects and lights
Sphere[] objects = new Sphere[20];
PtLight[] lights = new PtLight[10];
int numLights=0, numObjects=0;

// global matrix values
PMatrix3D global_mat;
float[] gmat = new float[16];  // global matrix values

// Some initializations for the scene.

void setup() {
  size (300, 300, P3D);  // use P3D environment so that matrix commands work properly
  noStroke();
  colorMode (RGB, 1.0);
  background (0, 0, 0);
  
  // grab the global matrix values (to use later when drawing pixels)
  PMatrix3D global_mat = (PMatrix3D) getMatrix();
  global_mat.get(gmat);  
  printMatrix();
  //resetMatrix();    // you may want to reset the matrix here

  interpreter("rect_test.cli");
}

// Press key 1 to 9 and 0 to run different test cases.

void keyPressed() {
  switch(key) {
    case '1':  interpreter("t01.cli"); break;
    case '2':  interpreter("t02.cli"); break;
    case '3':  interpreter("t03.cli"); break;
    case '4':  interpreter("t04.cli"); break;
    case '5':  interpreter("t05.cli"); break;
    case '6':  interpreter("t06.cli"); break;
    case '7':  interpreter("t07.cli"); break;
    case '8':  interpreter("t08.cli"); break;
    case '9':  interpreter("t09.cli"); break;
    case '0':  interpreter("t10.cli"); break;
    case 'q':  exit(); break;
  }
}

//  Parser core. It parses the CLI file and processes it based on each 
//  token. Only "color", "rect", and "write" tokens are implemented. 
//  You should start from here and add more functionalities for your
//  ray tracer.
//
//  Note: Function "splitToken()" is only available in processing 1.25 or higher.

void interpreter(String filename) {
  
  String str[] = loadStrings(filename);
  if (str == null) println("Error! Failed to read the file.");
  for (int i=0; i<str.length; i++) {
    
    String[] token = splitTokens(str[i], " "); // Get a line and parse tokens.
    if (token.length == 0) continue; // Skip blank line.
    
    if (token[0].equals("fov")) {
      // TODO
      fov = float(token[1]);
      screenPos.set(0,0,-screen_width/tan(fov/2));
    }
    else if (token[0].equals("background")) {
      // TODO
      float r = float(token[1]);
      float g = float(token[2]);
      float b = float(token[3]);
      bgcolor.set(r,g,b);
      //background(r,g,b);
      
    }
    else if (token[0].equals("point_light")) {
      // TODO
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      float r = float(token[4]);
      float g = float(token[5]);
      float b = float(token[6]);
      
      PVector p = new PVector(x,y,z);
      PVector c = new PVector(r,g,b);
      
      lights[numLights] = new PtLight(p,c);
      numLights++;
            
      //pointLight(r,g,b,x,y,z);
    }
    else if (token[0].equals("diffuse")) {
      // TODO
      kd.set(float(token[1]),float(token[2]),float(token[3]));
      ka.set(float(token[4]),float(token[5]),float(token[6]));
    }    
    else if (token[0].equals("sphere")) {
      // TODO
      float r = float(token[1]);
      PVector p = new PVector(float(token[1]),float(token[2]),float(token[3]));
      
      objects[numObjects] = new Sphere(p,r,ka,kd);
      numObjects++;
    }
    else if (token[0].equals("read")) {  // reads input from another file
      interpreter (token[1]);
    }
    else if (token[0].equals("color")) {  // example command -- not part of ray tracer
      float r = float(token[1]);
      float g = float(token[2]);
      float b = float(token[3]);
      fill(r, g, b);
    }
    else if (token[0].equals("rect")) {  // example command -- not part of ray tracer
      float x0 = float(token[1]);
      float y0 = float(token[2]);
      float x1 = float(token[3]);
      float y1 = float(token[4]);
      rect(x0, screen_height-y1, x1-x0, y1-y0);
    }
    else if (token[0].equals("write")) {
      // save the current image to a .png file
      save(token[1]);  
    }
  }
}

//  Draw frames.  Should be left empty.
void draw() {
}

// when mouse is pressed, print the cursor location
void mousePressed() {
  println ("mouse: " + mouseX + " " + mouseY);
}