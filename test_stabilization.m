%Test1
[errors_nostab,solutions_nostab,femregion_nostab,Dati_nostab,Peclet_1]=C_main2D('Test3',4,0);
title("Test1/ mu=1e-2");

figure;

[errors_nostab,solutions_nostab,femregion_nostab,Dati_nostab,Peclet_nostab]=C_main2D('Test1',4,0);
title("Test1/ mu=1e-9");
figure;

[errors_stab,solutions_stab,femregion_stab,Dati_stab,Peclet_stab]=C_main2D('Test1',4,1);
figure;

Peclet1_mu1=median(Peclet_1)
Peclet1_mu2=median(Peclet_nostab)
title("Test1-Stabilized/ mu=1-9");

%Test2
[errors_nostab2,solutions_nostab2,femregion_nostab2,Dati_nostab2,Peclet_nostab2]=C_main2D('Test4',4,0);
figure;

title("Test2/ mu=1-3");
[errors_stab,solutions_stab,femregion_stab,Dati_stab,Peclet_stab]=C_main2D('Test4',4,1);
title("Test2-Stabilized/ mu=1-3");

Peclet2=median(Peclet_nostab2)