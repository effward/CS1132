% Demo of selected graphics commands

close all       % Close all currently opened figure windows
figure          % Start a figure window
axis equal off  % Use equal scaling on x- and y-axes; hide axes
                %   If axes are not equal, a circle shows as an ellipse
                %   Axes off looks nice; axes on makes testing easier

hold on         % Subsequent graphics commands draw on top of current
                %   graphics in the figure window

a=[0 2 2 0 0];
b=[0 0 1 1 0];
plot(a,b,'-r')  % Plot as red line

c=[1  4  5 1];
d=[.5 .5 2 2];
fill(c,d,'y')   % Draw a filled polygon in yellow

k=1;
strs= { sprintf('Title Line %d',k), 'Title Line 2', 'Click below'};
title(strs, 'Fontsize',14)

[x,y]= ginput(1);  % Get one mouse click's coordinates
plot(x,y, 'k*')    % Mark clicked point with black asterisk
text(x,y, ' You clicked here')      % Label clicked point
text(x,y+.5, sprintf('pi=%.2f',pi)) % Display pi above clicked point

hold off  % Subsequent graphics commands replace current graphics in 
          %   the figure window (old graphic is erased)

%%%%% READ Module 1 Part 3 Examples for more info! %%%%%