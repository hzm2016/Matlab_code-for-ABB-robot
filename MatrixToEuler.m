%角度制表示
function [position,euler] = MatrixToEuler(T)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%calculate the traslation homogeneous Matrix T with the pisition and
%enler having been calculated;
position(1)=T(1,4);
position(2)=T(2,4);
position(3)=T(3,4);

euler(3)=atan2(T(2,1),T(1,1));
euler(2)=atan2(-T(3,1),cos(euler(3))*T(1,1)+sin(euler(3))*T(2,1));
euler(1)=atan2(sin(euler(3))*T(1,3)-cos(euler(3))*T(2,3),-sin(euler(3))*T(1,2)+cos(euler(3))*T(2,2));

euler=euler*180/pi;
end
