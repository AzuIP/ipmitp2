PImage[] imagenes = new PImage[3];
String[] textos = {
  "Five Nights at Freddy's\nun juego de terror único de una pizzería \nsiendo el guardia de seguridad...",
  "Durante la noche \ntenés que vigilar cámaras de seguridad \npara evitar que los animatrónicos te encuentren...",
  "No todos los animatrónicos se anuncian... \nalgunos solo aparecen"
};



PFont fuente;
int pantalla = 0;
int tiempoCambio;
int duracionPantalla = 6000; // 1o seg por pantalla

float textoX, textoY;       // posición del texto
float velocidadX, velocidadY; // velocidad para el texto

float textoTamaño = 24;     // tamaño del texo





void setup() {
  size(640, 480);
  
  imagenes[0] = loadImage("fnaf3badending.jpg"); //  (aparecen las cabezas de los 5 animatronicos, freddy, bonnie, golden freddy, etc)
  imagenes[1] = loadImage("personajes.jpg"); // (Estan Freddy, Chica, Bonnie, Foxy)
  imagenes[2] = loadImage("goldenfreddy.jpg"); // (mi personaje fav)

  for (int i = 0; i < imagenes.length; i++) {
    imagenes[i].resize(640, 480);
  }

  fuente = createFont("Arial", 24);
  textFont(fuente);
  textAlign(CENTER, CENTER);
  fill(255);

  tiempoCambio = millis();
  
  iniciarAnimacionPantalla();
}




void draw() {
  background(0);
  
  if (pantalla < imagenes.length && imagenes[pantalla] != null) {
    image(imagenes[pantalla], 0, 0);
    
    textSize(textoTamaño);
    text(textos[pantalla], textoX, textoY);
    
    moverTexto();
  }
  
  // Cambiar pantalla automáticamente cada duracionPantalla (10 seg)
  if (millis() - tiempoCambio > duracionPantalla) {
    pantalla++;
    tiempoCambio = millis();
    iniciarAnimacionPantalla();
  }
  
  if (pantalla >= imagenes.length) {
    mostrarBoton();
  }
}

void iniciarAnimacionPantalla() {
  switch(pantalla) {
    case 0:
      // Primera  imagen: texto se mueve horizontalmente en la línea media vertical
      textoX = 0;            // Empieza en la izquierda
      textoY = height/2;     // Línea media vertical
      velocidadX = 1.5;      // Velocidad horizontal
      velocidadY = 0;
      break;
    case 1:
      // Segunda imagen: texto se mueve verticalmente en la línea media horizontal
      textoX = width/2;      // Línea media horizontal
      textoY = 0;            // Empieza arriba
      velocidadX = 0;
      velocidadY = 1.2;      // Velocidad vertical
      break;
    case 2:
      // Tercera imagen: texto se mueve en diagonal desde arriba-izquierda a abajo-derecha
      textoX = 0;
      textoY = 0;
      velocidadX = 1.0;
      velocidadY = 0.75;
      break;
    default:
      velocidadX = 0;
      velocidadY = 0;
      break;
  }
}

void moverTexto() {
  textoX += velocidadX;
  textoY += velocidadY;
  
  // Limitar el movimiento para que vuelva o reinicie según la pantalla
  
  if (pantalla == 0) {
    // Mueve de izquierda a derecha. Cuando pasa del ancho, vuelve a la izquierda
    if (textoX > width) {
      textoX = 0;
    }
  } else if (pantalla == 1) {
    // Mueve de arriba a abajo. Cuando pasa del alto, vuelve arriba
    if (textoY > height) {
      textoY = 0;
    }
  } else if (pantalla == 2) {
    // Mueve en diagonal. Cuando se pasa por cualquier lado, vuelve a la esquina superior izquierda
    if (textoX > width || textoY > height) {
      textoX = 0;
      textoY = 0;
    }
  }
}

void mostrarBoton() {
  background(0);
  fill(255);
  textSize(30);
  text("ESTAS ACA POR TU CUENTA...\n¿SEGURO DE QUE QUERES ESTO?", width/2, height/2 - 60);
  
  rectMode(CENTER);
  fill(100);
  rect(width/2, height/2, 200, 50);
  
  fill(255);
  textSize(22);
  text("REINICIAR", width/2, height/2 + 5);
}

void mousePressed() {
  if (pantalla >= imagenes.length) {
    if (mouseX > width/2 - 100 && mouseX < width/2 + 100 &&
        mouseY > height/2 - 25 && mouseY < height/2 + 25) {
      pantalla = 0;
      tiempoCambio = millis();
      iniciarAnimacionPantalla();
    }
  }
}
