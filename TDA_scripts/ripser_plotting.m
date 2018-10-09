function [ dims,births,deaths ] = ripser_plotting( input_file_stem )
%This function converts the format of output files given by jHoles.
%
%INPUT: output text file given by Ripser
%OUTPUT: one text file for each homological dimension with each line
%storing left and right endpoint of a given interval.
%
% Parker Edwards, U. Florida December 2016.

zerodata = csvread([input_file_stem '_0.txt']);
zbirths = zerodata(:,1);
zdeaths = zerodata(:,2);
zdims = 0*(zdeaths>=0)-(isinf(zdeaths));


onedata=csvread([input_file_stem '_1.txt']);
onebirths = onedata(:,1);
onedeaths = onedata(:,2);
onedims = (onedeaths>=0);

twodata=csvread([input_file_stem '_2.txt']);
twobirths = twodata(:,1);
twodeaths = twodata(:,2);
twodims = 2*(twodeaths>=0);

births = vertcat(zbirths,onebirths,twobirths);
deaths = vertcat(zdeaths,onedeaths,twodeaths);
% deaths(isinf(deaths)) = max(deaths(~isinf(deaths)))+1;
dims = vertcat(zdims,onedims,twodims);

end
