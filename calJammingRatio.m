function ratio =calJammingRatio(inputPoint,inputQuad)
xLine = [inputPoint(1),0];
yLine = [inputPoint(2),0];
xBox = inputQuad([1,3,5,7,1]);
yBox = inputQuad([2,4,6,8,2]);
ratio = 1;
[x,y] = polyxpoly(xLine, yLine, xBox, yBox);
if(isempty(x)|| isempty(y))
    return;
end
if((0~=x) &&(0~=y))
    distInputPoint = sqrt(0.0 + inputPoint(1)^2 + inputPoint(2)^2);
    distIntersect = sqrt(0.0 + x^2+y^2);
    if(distInputPoint~=0)
        ratio = distIntersect / distInputPoint;
    end
end

