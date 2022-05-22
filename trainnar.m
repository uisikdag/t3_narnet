
function rms = trainnar(datafile,feedbackdelay,layersize,runs)
%
% Majority of this code is automatically generated by MATLAB App.
% 
%
%

%Load Data
load(datafile);
%First Difference
dt3=diff(t3);

%Convert data to standard neural network cell array form
T = tonndata(dt3,false,false);

% Choose a Training Function
trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

%Performance var
prf=10000;

% Create a Nonlinear Autoregressive Network
feedbackDelays = 1:feedbackdelay;  %Change accordingly
hiddenLayerSize = layersize;  %Change accordingly
net = narnet(feedbackDelays,hiddenLayerSize,'open',trainFcn);

% Prepare the Data for Training and Simulation

[x,xi,ai,t] = preparets(net,{},{},T);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 60/100;
net.divideParam.valRatio = 10/100;
net.divideParam.testRatio = 30/100;

%do not show training window
%this also increases speed of training
net.trainParam.showWindow = 0; 

%
%number of runs of the loop
n=runs; %Change accordingly

tic;
for i=1:n

% Train the Network
[net,~] = train(net,x,t,xi,ai);

% Test the Network
y = net(x,xi,ai);
%e = gsubtract(t,y);
performance = perform(net,t,y);

%Get the best performance
    if (performance<prf)
        prf=performance;
    end

end
toc;
%Find the mean of MSE scores
bestmse=prf;

%Find the RMSE 
rms=sqrt(bestmse);

end
