img = repmat(0:255,256,1);
for ii = 42:86
    for jj = 96:150
        img(jj,ii) = 128;
    end
end
for kk = 170:214
    for ll = 96:150
        img(ll,kk) = 128;
    end
end
colormap gray
axis image;
axis off;
imagesc(img)