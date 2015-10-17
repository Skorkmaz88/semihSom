function B = gaussian(x, y, sigma, center)
% Create an image with all zeros but one in winning neuron's place

A = zeros(x,y);
A(center(1), center(2)) = 1; 
% Warning requires Matlab 2015a or newer 
B = imgaussfilt(A,sigma);
