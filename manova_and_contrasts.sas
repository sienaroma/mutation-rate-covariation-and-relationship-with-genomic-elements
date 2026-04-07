/*Box’s Test*/
options ls=78;
title "Box's Test - Genome Mutations by State";

data mutations;
infile "\Users\siena\OneDrive\Documents\STAT580\humanAR_1mbData.csv" firstobs=2 delimiter=",";
input chr $ start end state $ GC CpG nCGm LINE SINE NLp insStd delStd subStd microsatStd;
run;

proc discrim data=mutations pool=test SLPOOL=0.05;
  class state;
  var insStd delStd subStd microsatStd;
  run;


/*MANOVA, Individual ANOVAs, and Box and Whisker Plots*/
proc glm data=mutations alpha=0.05;
  class state;
  model insStd delStd subStd microsatStd = state;
  contrast '1 vs 6' state  1 0 0 0 0 -1;
  estimate '1 vs 6' state  1 0 0 0 0 -1;
  lsmeans state;
  lsmeans state / stderr;
  manova h=state / printe printh;
  run;
