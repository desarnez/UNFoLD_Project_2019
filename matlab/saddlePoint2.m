function saddlePoint2(M)
% Evaluate gradient and hessian
[Cx, Cy] = gradient(M);
[Cxx, Cxy] = gradient(Cx);
[Cyx, Cyy] = gradient(Cy);
D = Cxx.*Cyy - Cxy.^2;

% Discard all the points on the boundary
[i,j]=find(D(2:end-1, 2:end-1) < 0);
i = i + 1; j = j + 1;

% Plot the surface and the saddle points
% figure;
hold on;
surf(M);
shading interp
plot3(i,j,repmat(4,[length(i),1]), 'k*');
hold off;