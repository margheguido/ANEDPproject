function [tau] = main_python(TestName,nRef,Stab,mu)

    [errors,solutions,femregion,Dati,Peclet,tau]=C_main2D(TestName,nRef,Stab,mu);
    u=full(solutions.uh);
    
end

