%% Script to solve and graph internal temperature values on a hotplate
%assumes constant temperature gradient along edges, and assumes perfectly
%insulative material on plate faces.

%based on Discretized Mean Value Property for grid array of internal points

%set up for a square hot plate, but could be expanded for a plate of
%arbitrary shape.

%Original code by: Nic Roberts II, March 2015

clc; clear all;
%% Introduction and prompt for user input

disp('****************************');
disp('WELCOME TO THE TEMPERATURE SOLVER PROGRAM V1.0!');
disp('****************************');
disp('ORIGINAL CODE BY NIC ROBERTS II, MARCH 2015');

disp('****************************');
disp('First, enter the dimension of the inner grid domain on your plate.');
disp('For example, an entry of 2 will produce an inner domain with 4 points.');
disp(' ');
prompt1 = 'Please enter the inner dimension of your plate (Integer):    ';
dim = input(prompt1);
disp('Please enter the four edgewise temperatures:');

%t1 is left, t2 is top, t3 is right, t4 is bottom
prompt2 = 'Temperature 1:    ';
t1 = input(prompt2);

prompt3 = 'Temperature 2:    ';
t2 = input(prompt3);

prompt4 = 'Temperature 3:    ';
t3 = input(prompt4);

prompt5 = 'Temperature 4:    ';
t4 = input(prompt5);

%% Start forming things up


%first make the internal grid matrix
temp = [1:dim^2];
intgrid = reshape(temp,dim,dim);
intgrid = intgrid.';

%C = zeros(dim+2);
C = zeros(dim^2);
counter = 0;

%*****************
%Form the adjacency matrix
%*****************

 for i = 1:size(C,1)
     
   
     %i 4 j 3
     for j = 1:size(C,1)
         
         [rr,kk] = find(intgrid==i); %[2,2]
         [r,k] = find(intgrid==j); %[2,1]
     
         
         if (((r - 1) == rr) && ((k+(dim-1))==kk)) || (((rr - 1) == r) && ((kk+(dim-1))==k))
         counter = 1;
         else
             counter = 0;
         end

        
         if  ((abs(i-j)==1 || abs(i-j) == dim))
             C(i,j) = 1;
            % C(i,j)
             
         end %if
         
         if abs(i-j) == 1 && counter == 1;
         C(i,j) = 0;
         end
         
         
         
     end %j
 end %i (dang that was a chore :/ )
        
    
 
%***************** 
%Form the b-matrix
%*****************

%b = zeros(size(C,1),1);
b = zeros(dim^2,1);



for n = 1:dim:(dim^2 - dim + 1)
    b(n,1) = t1;

end

for n = 1:dim
    b(n,1) = t2;
end

for n = dim:dim:dim^2
    b(n,1) = t3;
end

for n = (dim^2 - dim + 1):dim^2
    b(n,1) = t4;
    
end

% for n = 1:size(b,1)
% 
%     if n<dim 
%         b(n,1) = t2;
%     end
%     
%     if n<dim+dim-1 
%         b(n,1) = t3;
%     end
%     
%     if n<(2*dim -1)+dim-1
%         b(n,1) = t4;
%     end
%     
%     if n<(3*dim-2)+dim-1
%         b(n,1) = t1;
%     end
%    
%    
% end

%fix the corners
b(1,1) = t1 + t2;
b(dim,1) = t2 + t3;
b(dim^2-(dim-1),1) = t4+t1;
b(dim^2,1) = t4 + t3;





%% Evaluate

%inverse method
A = 4*eye(size(C,1)) - C;

sol = A\b;

%L-U decomp method (currently in use)
[L,U] = lu(A);
y = L\b;
sol2 = U\y;




%% Plot prep
%so basically we have to mash the boundary temps with the internal gradient
%temps that we just solved for

%make a solution matrix
for k = 1:size(sol2,1)
    
[i,j] = find(intgrid==k);
intgridsol(i,j) = sol2(k,1);

end


   
%top
intgridsol = vertcat(zeros(1,dim),intgridsol);

%right
intgridsol = horzcat(intgridsol,zeros(dim+1,1));

%bottom
intgridsol = vertcat(intgridsol,zeros(1,dim+1));

%left
intgridsol = horzcat(zeros(dim+2,1),intgridsol);


fgrid = intgridsol;

%add edge temps
fgrid(1,:) = t2;
fgrid(:,1) = t1;
fgrid(:,end) = t3;
fgrid(end,:) = t4;

%account for corner temps: currently computed as averages of the two
%adjacent edge temps.

fgrid(1,1) = (t1+t2)/2;
fgrid(1,end) = (t2+t3)/2;
fgrid(end,1) = (t1+t4)/2;
fgrid(end,end)=(t4+t3)/2;

%% Output
disp('Temperature Array:');
disp(fgrid);



%% Plot
[x,y] = meshgrid(1:size(fgrid,1), 1:size(fgrid,1));


figure(1); grid on;
surf(x,y,fgrid); view(2); shading interp;
c = colorbar;
c.Label.String = 'Temperature (^o C)';
caxis([min(min(fgrid)),max(max(fgrid))]);
set(gca,'ydir','reverse');
set(gca,'xlim',[1,size(fgrid,1)],'ylim',[1,size(fgrid,1)]);
set(gca,'Fontsize',20);
stringtitle = ['Internal Temperature Distribution: ',num2str(dim^2),' Points'];
title(stringtitle,'fontsize',20,'fontweight','bold');
% 







