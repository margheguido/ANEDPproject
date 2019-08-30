clear all 
close all 
clc
fileID = fopen('SUPG/output_250_6_2.txt', 'r');
 
 
 error_size = 9; 
 test_size = 50; 
  %50 se dataset è 250, 30 se dataset è 150
  linea = fgetl(fileID);
  

 
 train_error = fscanf(fileID,'%9f ',error_size);
  linea = fgetl(fileID);
 validation_error =  fscanf(fileID,'%9f ',error_size);
  linea = fgetl(fileID);
 
 test_mu =   fscanf(fileID,'%e  ',test_size);
 linea = fgetl(fileID);
 test_tau = fscanf(fileID,'%15f ',test_size);
 linea = fgetl(fileID);
 test_tau_edp = fscanf(fileID,'%e ',test_size);
 fclose(fileID);
 
 
 
 plot([1:error_size], train_error, '-ob')
 hold on 
 plot([1:error_size], validation_error, '-or')
 xlabel('epoch')
 legend('train error','validation error')
 
 
 figure
 plot(test_mu, test_tau_edp,'-om')
 ylabel('tau')
 xlabel('mu')
 
 