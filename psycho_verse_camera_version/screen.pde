//Start screen
SoundFile musics;

void setup_screen(){
musics = new SoundFile(this, "voix_loise.aiff");

}

void draw_screen(){
  background(0);
 
  if(musics.isPlaying() == false){
      musics.play();
  }
}
