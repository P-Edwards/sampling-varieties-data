%  Copyright 2014 IST Austria
%
%  Contributed by: Jan Reininghaus
%
%  This file is part of DIPHA.
%
%  DIPHA is free software: you can redistribute it and/or modify
%  it under the terms of the GNU Lesser General Public License as published by
%  the Free Software Foundation, either version 3 of the License, or
%  (at your option) any later version.
%
%  DIPHA is distributed in the hope that it will be useful,
%  but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  GNU Lesser General Public License for more details.
%
%  You should have received a copy of the GNU Lesser General Public License
%  along with DIPHA.  If not, see <http://www.gnu.org/licenses/>.

function make_inference_plot( filename,delta,epsilon,n,max_height)
   ripser_reformat_output(filename); 
   h = save_ripser_plot(filename,max_height); 
   hold on; 
   low_value = 2*epsilon*sqrt((n+1)/(2*n)); 
   high_value = 4*epsilon + 2*delta;
   
   r=fill([low_value,0,0,low_value],[high_value,high_value,max_height,max_height],'red');
   r.FaceAlpha = 0.3;
   set(r,'EdgeColor','none');
   uistack(r,'bottom');
   plot_name = [sprintf(filename) '.eps']
   saveas(h,plot_name,'epsc')
end
