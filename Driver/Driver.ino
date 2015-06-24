const int readPin1 = 22;
const int readPin2 = 20;
const int readPin3 = 18;
const int led1 = 12;
const int led2 = 10;
const int sw1 = 8;

// the setup() method runs once, when the sketch starts

void setup() {
  pinMode(13, OUTPUT);
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(sw1, INPUT_PULLUP);
  pinMode(readPin1, INPUT);
  pinMode(readPin2, INPUT);
  pinMode(readPin3, INPUT);
  Serial.begin(115200);
  digitalWrite(13, HIGH);
  digitalWrite(led1, HIGH);
  digitalWrite(led2, HIGH);
}

// the loop() methor runs over and over again,
// as long as the board has power

int val1, val2, val3, sw_status;

void loop() {
//  sw_status = digitalRead(sw1);
  val1= analogRead(8); //A0 = pin 14
  val2= analogRead(6); //A1 = pin 15
  val3= analogRead(4); //A2 = pin 16

  Serial.print(val1);
  Serial.print(" ");
  Serial.print(val2);
  Serial.print(" ");
  Serial.println(val3);
  /* Serial.print(" "); */
  /* Serial.println(sw_status); */
  delay(250);

}
