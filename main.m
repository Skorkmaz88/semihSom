%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This is the main file for SOM implementation 
%  @author: skorkmaz 
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  dimensions:  1D and 2D supported only for now 
mapRow = 1;
mapCol = 2; 

%  alpha: Learning rate 
alpha_original = 0.5;
% Will change over the time 
alpha = alpha_original;
% neighbourhood function: Gaussian only for now 
neighbourhood_func = 'gaussian';
sigma = 1;
sigma_original = sigma;

% Stopping criterias 
number_of_iterations = 1000;

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initilazation 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SOM - Map 
som = zeros(mapRow, mapCol);
map_size = mapRow * mapCol; 
% Index keepers
[I,J] = ind2sub([mapRow, mapCol], 1:(map_size));

% Maybe better initialization next time ? Nguyen ? 
som = rand(mapRow, mapCol)/100;
% Time decay tau s 
tau1 = 1000/log(sigma);
% the constant for calculating learning rate
tau2 = 1000;

% batch size k, example k = 1 stochastic, 1< k < 10 mini batch, etc.
k = 1; 

% Input : Assuming 2D max dimensional input for this project
%data = load('asf');

% Erase later



data_w = 1000;
data_h = 1000;
data = eye(data_w, data_h); 
[data_w data_h] = size(data);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualization 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 % Rectangular - grayscale
 imshow(som) 
 % Color map
 colormap jet
 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Loop
%  Stochastic/Batch version rand(x) from X at each step
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:number_of_iterations
 
x_batch = datasample(data(:)', k);

  % Iterate through the batch 
   for j = 1:k
       x = x_batch(j);
       % Yields closest index of som : I
       [r,c]=find((abs(som-x))==min(min((abs(som-x)))));
       winner_node = [r, c];
       % Create a 2D Gaussian for weight update ? 
       weight_matrix = gaussian(mapRow, mapCol, sigma, winner_node);
      
       % It seems like MATLAB doesn't have matrix centered summation,
       % so traverse the SOM
      
       % Take the difference of the neurons and input vector 
       som_temp = som - x; 
       som  = som + som_temp .* (alpha * weight_matrix);
       sum(sum(som))
%        for som_x = 1: mapRow
%            for som_y = 1: mapCol
%                % Calculate the distance here 
%                som(som_x, som_y) = som(som_x, som_y) + weight_matrix(mapRow, mapCol) ...
%                    * alpha * (som(som_x,som_y) - x);
%                
%            end
%        end
      % if mod(j,200) == 0
          
     %     waitforbuttonpress
       %end
       % Monotonically decreasing learning rate .
       alpha = alpha_original * exp(-i/tau2);
       % Monotonically decreasing sigma neighborhood size for gaussian
        sigma = sigma_original *exp(-i/tau1);
   end
end
imshow(som)




