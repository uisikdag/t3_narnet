%Load Data
load('t3.mat');
%First Difference
dt3=diff(t3);

%Convert data to standard neural network cell array form
T = tonndata(dt3,false,false);

% Choose a Training Function
trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

%Performance var
prf=0;

% Create a Nonlinear Autoregressive Network
feedbackDelays = 1:2;  %Change accordingly
hiddenLayerSize = 10;  %Change accordingly
net = narnet(feedbackDelays,hiddenLayerSize,'open',trainFcn);

% Prepare the Data for Training and Simulation

[x,xi,ai,t] = preparets(net,{},{},T);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 60/100;
net.divideParam.valRatio = 10/100;
net.divideParam.testRatio = 30/100;

%
%number of runs of the loop
n=50; %Change accordingly

for i=1:n

% Train the Network
[net,tr] = train(net,x,t,xi,ai);

% Test the Network
y = net(x,xi,ai);
e = gsubtract(t,y);
performance = perform(net,t,y);

%Get the performance
prf=prf+performance;

end

%Find the mean of MSE scores
meanmse=prf/n;

%Find the RMSE 
rmse=sqrt(meanmse);

