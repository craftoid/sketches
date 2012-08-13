
// elementary inversion operators

void invertRuleX() {
  rule ^= 0x55555555 ;   // flip all x bits ( binary  ...01010101)
}

void invertRuleY() {
  rule ^= 0xAAAAAAAA;    // flip all y bits ( binary ...10101010 )
}

void negateRule() {
  rule ^= 3;             // flip both x and y for the first iteration
}


// combined inversion operators

void invertRule() {
  invertRuleX(); invertRuleY();  // flip all bits
}

void flipRule() {
  invertRule(); negateRule(); 
}

