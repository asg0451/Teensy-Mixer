
const int readPin1 = 14;
const int readPin2 = 15;
const int readPin3 = 16;

// the setup() method runs once, when the sketch starts

void setup() {
  pinMode(13, OUTPUT);
  pinMode(readPin1, INPUT);
  pinMode(readPin2, INPUT);
  pinMode(readPin3, INPUT);
  Serial.begin(115200);
  digitalWrite(13, HIGH);
}

// the loop() methor runs over and over again,
// as long as the board has power

int val1, val2, val3;

void loop() {

  val1= analogRead(0); //A0 = pin 14
  val2= analogRead(1); //A1 = pin 15
  val3= analogRead(2); //A2 = pin 16
  Serial.print(val1);
  Serial.print(" ");
  Serial.print(val2);
  Serial.print(" ");
  Serial.println(val3);
  delay(1000);

}

