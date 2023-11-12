%******
%Compute Jacobian of a robot based on geometric model obtained by Denavit-Hartenberg parameters
%******
%---
% By Randolf Nkimo -- Last updated 11 Nov 2023
%---
Ai_1__n = Mi_1__i;
J = sym('J', [6 num]);
for i=1:num
    axe = F(i,end); % O for prismatique and 1 for rotoide
    if axe == 0
        RO_i_1 = eye(3);
        for j=1:i
            RO_i_1 = RO_i_1*Ai_1__n{j}(1:end-1,1:end-1);
        end
        z0_i_1 = RO_i_1(:,end);
        %
        J(1:3,i) = z0_i_1;
        J(4:end,i) = zeros(3,1);
        %
    elseif axe == 1
        RO_i_1 = eye(3);
        for j=1:i
            RO_i_1 = RO_i_1*Ai_1__n{j}(1:end-1,1:end-1);
        end
        z0_i_1 = RO_i_1(:,end);
        Mi_1__n = eye(4);
        for h=i:num
            Mi_1__n = Mi_1__n*Ai_1__n{h+1};
        end

        Oi_1__n = Mi_1__n(1:end-1,end);
        %
        J(1:3,i) = AS(z0_i_1)*RO_i_1*Oi_1__n;
        J(4:end,i) = z0_i_1;
        %
    end
end
'J is Jacobian Matrix' , pretty(simplify(J))
