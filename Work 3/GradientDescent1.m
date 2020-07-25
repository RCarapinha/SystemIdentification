function [ Param,Err ] = GradientDescent1(Initial, Ranges, ErrFunc, Steps, threshold, NrIter)
%GRADIENTDESCENT1 Summary of this function goes here
%   Detailed explanation goes here
    [N,~] = size(Ranges);
    Iter = 1;
    CriterioParagem = 0;
    Param(1,1:N) = Initial;
    Err(1,1,1) = ErrFunc(Param);
    while Iter<NrIter && ~CriterioParagem
        disp(Iter);
        Delta = -ones(1,N);
        MinErr = 10e15;
        for n = 1:3^N
            disp(n);
            ErrViz = ErrFunc(Param(Iter,:)+Delta.*Steps');
            if ErrViz < MinErr
                MinErr = ErrViz;
                MinParam = Param(Iter,:)+Delta.*Steps';
            end
            Delta = NextDelta(Delta);
        end
        Iter = Iter+1;
        Param(Iter,:) = MinParam;
        Err(Iter) = MinErr;
        if(abs(Err(Iter)-Err(Iter-1))< threshold)
            CriterioParagem = 1;
        end
    end
end

function new_delta = NextDelta(Delta)
    N = length(Delta);
    new_delta = Delta;
    for i = 1 : N 
        if(Delta(i) < 1)
            new_delta(i) = new_delta(i) +1;
            break;
        else
            new_delta (i) = -1;
        end
    end
end
