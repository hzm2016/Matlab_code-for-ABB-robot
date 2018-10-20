%弧度制表示
function Matrix = EulerToMatrix(position,euler)
    Wx=euler(1);Wy=euler(2);Wz=euler(3);
    Mz = [cos(Wz) -sin(Wz) 0 0;
          sin(Wz) cos(Wz)  0 0;
          0 0 1 0;
          0 0 0 1];
    My = [cos(Wy) 0 sin(Wy) 0;
          0 1 0 0;
          -sin(Wy) 0 cos(Wy) 0;
          0 0 0 1];
    Mx = [1 0 0 0;
          0 cos(Wx) -sin(Wx) 0;
          0 sin(Wx) cos(Wx) 0;
          0 0 0 1];  
    Matrix = Mz*My*Mx;
    Matrix =[eye(3) position';0 0 0 1]*Matrix;