int leftmotor1Pin1 = 8;    
int leftmotor1Pin2 = 9;    
int rightmotor1Pin1 = 3;    
int rightmotor1Pin2 = 4;
int surve= 5;
int enable1=10;//right
int enable2=11;//left
int val11=255;
int val22=255;
int ser=0,e1=0,e0=0,intp1=0,intp0=0,intp=0,der=0,x=0,i=0;
int kp=2.6;//3.18;
int kd=0.01;
int ki=0.001;
void setup()
{
  pinMode(leftmotor1Pin1, OUTPUT);
  pinMode(leftmotor1Pin2, OUTPUT);
  pinMode(rightmotor1Pin1, OUTPUT);
  pinMode(rightmotor1Pin2, OUTPUT);
  Serial.begin(9600);
}

void errorgen()
{
  e1=ser;
  if(e1>80)
    {
      e1=e1-80;
    }
  else
    {
      e1=80-e1;
    }
  der=e1-e0;
  intp1=(e1+e0)/2;
  intp=intp1+intp0;
  x=e1*kp+kd*der+ki*intp;
  intp0=intp1;
  e0=e1;  
}
void induce_delay()
{
  delay(1000);
  delay(1000);
  delay(1000);
}
void forward()
{
void loop() 
{

  if (Serial.available() > 0)
  {
    ser=Serial.read();
  }

  if(ser>80&&(ser!=0)&&(ser!=1)&&(ser!=2)&&(ser!=3)&&(ser!=4)&&(ser!=5))//turn rig
  {
    errorgen();
    val22=x/2;
    val11=x;
    analogWrite(enable1, val11);
    analogWrite(enable2, val22);
    digitalWrite(leftmotor1Pin1, LOW);  
    digitalWrite(leftmotor1Pin2, HIGH);
    digitalWrite(rightmotor1Pin1, LOW);  
    digitalWrite(rightmotor1Pin2, HIGH); 
  }
  if (Serial.available() > 0)
  {
    ser=Serial.read();
  }
  if(ser<=80&&(ser!=0)&&(ser!=1)&&(ser!=2)&&(ser!=3)&&(ser!=4)&&(ser!=5))//left
  {
    errorgen();
    val11=x/2;
    val22=x;
    analogWrite(enable1, val11);
    analogWrite(enable2, val22);
    digitalWrite(leftmotor1Pin1, LOW);  
    digitalWrite(leftmotor1Pin2, HIGH);
    digitalWrite(rightmotor1Pin1, LOW);  
    digitalWrite(rightmotor1Pin2, HIGH); 
  }
  if (Serial.available() > 0)
  {
    ser=Serial.read();
  }
  if(ser==0)
  {
    digitalWrite(leftmotor1Pin1, LOW);  
    digitalWrite(leftmotor1Pin2, LOW);
    digitalWrite(rightmotor1Pin1, LOW);  
    digitalWrite(rightmotor1Pin2, LOW);   
  }
  if (Serial.available() > 0)
  {
    ser=Serial.read();
  }
  if(ser==1)
  {
    val11=140;
    val22=140;
    analogWrite(enable1, val11);
    analogWrite(enable2, val22);
    digitalWrite(leftmotor1Pin1, LOW);  
    digitalWrite(leftmotor1Pin2, HIGH);
    digitalWrite(rightmotor1Pin1, LOW);  
    digitalWrite(rightmotor1Pin2, HIGH);   
  }
   
   if(ser==1)//turn left
  {
    analogWrite(enable1, val11);
    analogWrite(enable2, val22);
    digitalWrite(leftmotor1Pin1, HIGH); 
    digitalWrite(leftmotor1Pin2, LOW);
    digitalWrite(rightmotor1Pin1, LOW);  
    digitalWrite(rightmotor1Pin2, HIGH);
  }
     if(ser==2)//turn right
  {
    analogWrite(enable1, val11);
    analogWrite(enable2, val22);//pr
    digitalWrite(leftmotor1Pin1, LOW); 
    digitalWrite(leftmotor1Pin2, HIGH);
    digitalWrite(rightmotor1Pin1, HIGH);  
    digitalWrite(rightmotor1Pin2, LOW);
  }
      if(ser==3)//go back
  {
    analogWrite(enable1, val11);
    analogWrite(enable2, val22);//pr
    digitalWrite(leftmotor1Pin1, HIGH); 
    digitalWrite(leftmotor1Pin2, LOW);
    digitalWrite(rightmotor1Pin1, HIGH);  
    digitalWrite(rightmotor1Pin2, LOW);
  }
      if(ser==4)//survell
  {
    if(ser==5)
    {
      i=0;
      while(ser!=5)
      {
        analogWrite(surve, i);
        i++;
        delay(100);
        if(i==255)
        {
          i=0;
        }
      }
    }
  }
      if(ser==6)//go back
  {
    val11=140;
    val22=140;
    while(ser!=6)
    
    {
    analogWrite(enable1, val11);
    analogWrite(enable2, val22);
    digitalWrite(leftmotor1Pin1, LOW);  
    digitalWrite(leftmotor1Pin2, HIGH);
    digitalWrite(rightmotor1Pin1, LOW);  
    digitalWrite(rightmotor1Pin2, HIGH);  
    induce_delay();
    
  }
}



