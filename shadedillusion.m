function shadedillusion(color_map)

img = repmat(0:255,256,1); %creates baseline matrix with squares at appropriate posistions

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
end

%displays image
imagesc(img)
axis image; axis off;