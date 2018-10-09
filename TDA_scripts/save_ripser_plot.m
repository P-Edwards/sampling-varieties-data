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

function h = plot_persistence_diagram( filename, max_height )
    filename=regexprep(filename,'.txt',''); 
    h = figure;
   
    %% load data
    [dims, births, deaths] = ripser_plotting( filename );

    %% classify points in diagram     
    essentials = (dims < 0);
    ordinaries = ~essentials;
    
    %% draw parameters
    max_dims = max(floor(abs(dims+0.5)))
    cur_colormap = [255 255 191;171 221 164;215 25 28]/255;
    colormap( cur_colormap );
    marker_size = 75;
    
    %% set deaths at max height
    deaths(deaths >= max_height) = max_height;
    
    %% draw essential points
    scatter( births( essentials ), deaths( essentials ), marker_size, cur_colormap(-dims( essentials ) - 1 + 1,:), ...
             'filled', 'MarkerEdgeColor','k', 'Marker', 's' );
         
    %% draw non essential points
    hold on
    scatter( births( ordinaries ), deaths( ordinaries ), marker_size, cur_colormap(dims( ordinaries ) + 1,:), ...
             'filled', 'MarkerEdgeColor','k', 'Marker', 'o' );
    hold off
    
    %% draw diagonal
    min_value = min( births );
    max_value = max_height;
    line( [min_value, max_value], [min_value, max_value], 'Color','k' );

    %% draw axis
    safe_min = min_value - 10 * eps( min_value );
    safe_max = max_value + 10 * eps( max_value );
    axis square  
    axis( [safe_min, safe_max, safe_min, safe_max] );
    xticks = get(gca,'XTick');
    set(gca,'YTick',xticks);
    set(gca,'fontsize',15)

    
    %% draw axis labels
    xlabel('Birth','FontSize',20);
    ylabel('Death','FontSize',20);

    %% draw colobar
    caxis([0 max_dims])
    ylabel(colorbar('YTick',0:1:max_dims), 'Dimension');
    
    %% draw title
    set( title(['']), 'Interpreter', 'none' );
    
    %% draw grid
    grid on;
end
