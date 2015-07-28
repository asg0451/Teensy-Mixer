const int readPin1 = 23; // A9
const int readPin2 = 20; // A6
const int readPin3 = 18; // A4
const int readPin4 = 16; // A2
const int readPin5 = 14; // A0
const int led1 = 5;
const int led2 = 7;
const int sw1 = 9;
const int sw2 = 11;

void setup() {
  pinMode(13, OUTPUT);
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(sw1, INPUT_PULLUP);
  pinMode(sw2, INPUT_PULLUP);
  pinMode(readPin1, INPUT);
  pinMode(readPin2, INPUT);
  pinMode(readPin3, INPUT);
  pinMode(readPin4, INPUT);
  pinMode(readPin5, INPUT);
  
  Serial.begin(115200);
  
  digitalWrite(13, HIGH);
  digitalWrite(led1, HIGH);
  digitalWrite(led2, HIGH);
}

// the loop() methor runs over and over again,
// as long as the board has power

int val1, val2, val3, val4, val5, sw1_status, sw2_status;

void loop() {
//  sw_status = digitalRead(sw1);
  val1= analogRead(9);
  val2= analogRead(6);
  val3= analogRead(4);
  val4= analogRead(2);
  val5= analogRead(0);

  Serial.print(val1);
  Serial.print(" ");
  Serial.print(val2);
  Serial.print(" ");
  Serial.print(val3);
  Serial.print(" ");
  Serial.print(val4);
  Serial.print(" ");
  Serial.println(val5);

  /* Serial.print(" "); */
  /* Serial.println(sw_status); */
  delay(250);

}
