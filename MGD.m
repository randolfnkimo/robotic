%******
%Compute the direct geometric model of a robot based on
%Denavit-Hartenberg parameters
%******
%---
% Base version by Mahmoud KhoshGoftar 4 Dec 2013 
% https://www.mathworks.com/matlabcentral/fileexchange/44585-denavit-hartenberg-parameters
% Edited 11 Nov 2023 by Randolf Nkimo
%---
clear 
close all
clc
prompt = {'Enter how many robot arms?'};
dlg_title = 'Input';
num_lines = 1;
def = {'1'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
num = str2double(answer{:});
F = sym('A', [num 5]);
M=eye(4);
C = sym('C', [4 4]);
Pi = sym(pi);
clc
Mi_1__i = {};
MO_O = [eye(3), zeros(3,1); zeros(1,3), 1];
Mi_1__i{1} = MO_O;
for i=1:num
    prompt = {'Enter a:','Enter alpha:','Enter d:','Enter theta:','Enter type axe, 0 for T and 1 for R:'};
    dlg_title = sprintf('arm%d',i);
    num_lines = 1;
    def1 = {sprintf('a%d',i),sprintf('alpha%d',i),sprintf('d%d',i),sprintf('t%d',i),sprintf('0')};
    answer1 = inputdlg(prompt,dlg_title,num_lines,def1);
    F(i,1)=str2sym(answer1(1,1));
    F(i,2)=str2sym(answer1(2,1));
    F(i,3)=str2sym(answer1(3,1));
    F(i,4)=str2sym(answer1(4,1));
    F(i,5) = str2double(answer1(5,1));
    C=simplify([cos(F(i,4)) -sin(F(i,4))*cos(F(i,2)) sin(F(i,4))*sin(F(i,2)) F(i,1)*cos(F(i,4));
             sin(F(i,4)) cos(F(i,4))*cos(F(i,2)) -cos(F(i,4))*sin(F(i,2)) F(i,1)*sin(F(i,4));
             0 sin(F(i,2)) cos(F(i,2)) F(i,3);
             0 0 0 1]);
    eval(sprintf('A%d = C;',i));
    M=M*C;
    eval(sprintf('A%d',i))
    Mi_1__i{i+1} = C;
end
sprintf('M from Arm 0 to Arm %d is:',i)
pretty(simplify(M))
R=simplify(M(1:3,1:3));
'R is Rotation Matrix'    , pretty(R)

T=simplify(M(1:3,4));
'T is translation Matrix' , pretty(T)