

import org.jmol.adapter.smarter.*;

AtomSetCollection asc;
int select = -1;

// flip through the files
void nextMol() {
  String[] molFiles = { 
    "jmol",    
    "ala", "arg", "asn", "asp", "cys", "gln", "glu",
    "gly", "his", "ile", "leu", "lys", "met", "phe",
    "pro", "ser", "thr", "trp", "tyr", "val",
    "kaolinite_small"
  };
  String s = molFiles[++select % molFiles.length];
  asc = readAtoms(s +".mol", "Mol");
  reset = true;
}

// read atoms from a file
AtomSetCollection readAtoms(String name, String type) {
  return (AtomSetCollection) (new SmarterJmolAdapter()).getAtomSetCollectionFromReader(name, type, createReader(name), new Hashtable());
}

