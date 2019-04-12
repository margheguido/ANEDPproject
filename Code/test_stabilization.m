%Test1


[errors_nostab,solutions_nostab,femregion_nostab,Dati_nostab,Peclet_nostab]=C_main2D('Test1',4,0,1e-2);
title("Test1/ mu=1e-9");
figure;

[errors_stab,solutions_stab,femregion_stab,Dati_stab,Peclet_stab]=C_main2D('Test1',4,1,1e-9);
figure;

Peclet1_mu1=median(Peclet_1)
Peclet1_mu2=median(Peclet_nostab)
title("Test1-Stabilized/ mu=1-9");

