options ls=78;
title "Canonical Correlation Analysis";

data mutations;
infile "\Users\siena\OneDrive\Documents\STAT580\humanAR_1mbData.csv" firstobs=1 delimiter=",";
input chr $ start end state GC CpG nCGm LINE SINE NLp insStd delStd subStd microsatStd;
run;

proc cancorr data=mutations out=canout
vprefix=outMutations vname="Genome Mutations"
wprefix=inFeatures wname="Genome Features";
var GC CpG nCGm LINE SINE NLp state;
with insStd delStd subStd microsatStd;
run;
