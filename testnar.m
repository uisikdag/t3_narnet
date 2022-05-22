
%%
clc;
clear;
%%
rmse1=trainnar('t3.mat',1,1,500);
rmse2=trainnar('t3.mat',1,2,500);
rmse3=trainnar('t3.mat',1,3,500);
rmse4=trainnar('t3.mat',1,4,500);
rmse5=trainnar('t3.mat',1,5,500);

%%
rmse1b=trainnar('t3.mat',1:12,1,500);
rmse2b=trainnar('t3.mat',1:12,2,500);
rmse3b=trainnar('t3.mat',1:12,3,500);
rmse4b=trainnar('t3.mat',1:12,4,500);
rmse5b=trainnar('t3.mat',1:12,5,500);
