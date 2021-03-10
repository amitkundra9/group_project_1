function shadedillusion(color_map)

img = repmat(0:255,256,1); %creates baseline matrix with squares at appropriate posistions
%this illusion took 2 hours to put together - amit
%creates little square on left sisde
for ii = 48:80
    for jj = 112:144
        img(jj,ii) = 128;
    end
end

%creates little square on right side
for kk = 176:208
    for ll = 112:144
        img(ll,kk) = 128;
    end
end

%sets colormap depending on user input
if color_map ==  1
    colormap gray
elseif color_map == 2
    colormap parula 
elseif color_map == 3
    colormap cool
elseif color_map == 4
    colormap winter
elseif color_map == 5
    colormap copper
elseif color_map == 6
    colormap pink
elseif color_map == 7
    colormap bone
end

%displays image
imagesc(img)
axis image; axis off;