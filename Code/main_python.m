function [u] = main_python(TestName,nRef,Stab,mu)

    [errors,solutions,femregion,Dati,Peclet]=C_main2D(TestName,nRef,Stab,mu);
    u=full(solutions.uh);
    
end

