A = imread('C:\Users\Steven\Pictures\Camera Roll\WIN_20161123_21_19_31_Pro.jpg');
B = im2bw(A,.7);
w_mid = round(size(B,1)/2);
h_mid = round(size(B,2)/2);
cropped = B(w_mid-200:w_mid+200,h_mid-300:h_mid+300) ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stats = regionprops('table',cropped,'Centroid','MajorAxisLength','MinorAxisLength')
centers = stats.Centroid;
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
radii = diameters/2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MAX=max(stats.MajorAxisLength);
[ROW,COL] = find(stats.MajorAxisLength == MAX);
hsize=round(stats.Centroid(ROW,COL));
wsize=round(stats.Centroid(ROW,COL+1));
masize=round((stats.MajorAxisLength(ROW,COL))/2);
misize=round((stats.MinorAxisLength(ROW,COL))/2);
w1=wsize-masize;
if w1 < 0
    w1=1;
else
end
w2=wsize+masize;
h1=hsize-masize;
if h1 < 0
    h1=1;
else
end
h2=hsize+masize;
Z = cropped([w1:w2],[h1:h2]);


BW2 = bwmorph(Z,'remove');
[c,r,m]=imfindcircles(BW2,[(round(misize/12)),(round(misize/2))]);
s=size(c);
dienumber=s(1,1)
disp('The die number is');
dienumber

figure;
subplot(2,2,1)
imshow(A);hold on
title('Original')

subplot(2,2,2)
imshow(B);hold on
title('Black and White 0.8 Intensity Filter')

subplot(2,2,3)
imshow(cropped);hold on
viscircles(centers,radii);
title('Identifying Possible Circular Regions')

subplot(2,2,4)
imshow(Z);hold on
viscircles(centers,radii);
title('Fonzi Filter')


figure
imshow(BW2);hold on 
viscircles(c,r);
