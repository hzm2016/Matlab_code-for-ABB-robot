function alignPegAndHole(t,holeInBase,pegInTcp,isAlignZ)
% get current tcpInBase and pegInBase
[~,~,tcpInBase] = GetCalibTool(t);
pegInBase=tcpInBase*pegInTcp;
%% align the pegs and holes£»
nextPegInBase=holeInBase;
if(~isAlignZ)    
    nextPegInBase(3,4)=pegInBase(3,4);
end
nextPegInPeg=pegInBase^-1*nextPegInBase;
nextTcpInTcp=pegInTcp*nextPegInPeg*pegInTcp^-1;
nextTcpInBase=tcpInBase*nextTcpInTcp;
[nextPos,nextRot] = MatrixToEuler(nextTcpInBase);
%%
MoveToolTo(nextPos,nextRot,30,t);%relative move
disp('Finish aligning!');
end

