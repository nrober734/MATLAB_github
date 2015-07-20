%% Script to interactively display trig graphs alongside unit circle
%Built to help Lex with precalc
%Original code:  Nic Roberts, Jun 2015

%header
close all; clc;

%Setup vectors

% x = [0,pi/6,pi/3,pi/2,2*pi/3,5*pi/6,pi];
% y = sin(x);

 x = [0,pi/6,pi/3,pi/2,2*pi/3,5*pi/6,pi,7*pi/6,4*pi/3,3*pi/2,5*pi/3,11*pi/6,2*pi];
 y = sin(x);




%Plot basic curve first

fontsize = 20;


% XTicksNumber = None, TicksLabelFont = ["Times New Roman"],
%      XTicksAt = [-PI = "-?", -PI/2 = "-?/2",
%                  0 = "0", PI/2 = "?/2", PI = "?"])

%% Plot loop for roving marker on sine curve

% %curve
%    plot(x,y,'Linewidth',6,'color','k'); hold on;
%    %ax = gca;
%    %ax.XTickLabel = {'0','\pi/6','\pi/3','\pi/2','2\pi/3','5\pi/6','\pi'};
% for n = 1:length(x)
%    figure(1); grid on; set(gcf,'Color',[1,1,1]); 
%    %roving marker
%    plot(x(n),y(n),'Marker','o','Linewidth',6,'Linestyle','none','MarkerEdgecolor','k','Markersize',20,'MarkerFaceColor','g');
%    ax = gca;
%    ax.XTick = [0 pi/6 pi/3 pi/2 2*pi/3 5*pi/6 pi];
%    ax.XTickLabel = {'0','\pi/6','\pi/3','\pi/2','2\pi/3','5\pi/6','\pi'};
%    set(gca,'Fontsize',fontsize,'Fontweight','bold','Color',[0.8,0.8,0.8],'xlim',[0,pi]);
% end
% 
% ylabel('y','Fontsize',fontsize,'FontWeight','bold');
% xlabel('x','Fontsize',fontsize,'FontWeight','bold');   
% set(gca,'Fontsize',fontsize,'Fontweight','bold','Color',[0.8,0.8,0.8],'xlim',[0,pi]);

%% Plot the unit circle with roving marker and radius
% figure(2);
% 
% %y-axis
% plot([0,0],[1,-1],'Linewidth',6,'color','k'); hold on;
% 
% %x-axis
% plot([1,-1],[0,0],'Linewidth',6,'color','k'); hold on;
% 
% %unit circle
% theta = [0:pi/100:2*pi];
% for i = 1:length(theta)
% xx(i) = cos(theta(i));
% yy(i) = sin(theta(i));
% end
% 
% plot(xx,yy,'Linewidth',6,'color','k');
% 
% %new x and y for roving selection
% for i = 1:length(x)
%     xn(i) = cos(x(i));
%     yn(i) = sin(x(i));
%     
% end
% 
% %selected theta
% 
% %roving loop
% for i = 1:length(x)
%     
%     
% %roving radius
% plot([0,xn(i)],[0,yn(i)],'Linewidth',6,'color','k');
%     
% %roving marker
% plot(xn(i),yn(i),'Linewidth',6,'Marker','o','Linestyle','none','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',20);
% 
%     
% end
% 
% set(gca, 'xlim',[-1,1]);


%% Now for the real thing...


   
for n = 1:length(x)
    
figure(1); grid on; set(gcf,'Color',[1,1,1]); hold all; clf; set(gcf,'Position',[197         326        1123         468]);
sub1 = subplot(1,2,1); hold on;
sub2 = subplot(1,2,2); hold on;



   
%curve
%apply new x and y for smooth curve
xnew = [0:pi/100:2*pi];
ynew = sin(xnew);
plot(sub1,xnew,ynew,'Linewidth',6,'color','k'); hold on;
 
   
   
%y-axis
plot(sub2,[0,0],[1,-1],'Linewidth',6,'color','k'); hold on;

%x-axis
plot(sub2,[1,-1],[0,0],'Linewidth',6,'color','k'); hold on;

%unit circle
theta = [0:pi/100:2*pi];
for i = 1:length(theta)
xx(i) = cos(theta(i));
yy(i) = sin(theta(i));
end

for i = 1:length(x)
    xn(i) = cos(x(i));
    yn(i) = sin(x(i));
    
end

plot(sub2,xx,yy,'Linewidth',6,'color','k');
   
%    sub1 = subplot(1,2,1); hold on;
%    sub2 = subplot(1,2,2); hold on;
   set(gcf, 'Renderer','Painters');
   %roving marker
plot(sub1,x(n),y(n),'Marker','o','Linewidth',6,'Linestyle','none','MarkerEdgeColor','k','Markersize',20,'MarkerFaceColor','g'); hold on;
    arax = get(gcf,'Children');
    ax = arax(2);
    ax.XTick = [0  pi/2 pi ,3*pi/2 2*pi];
    %pi,7*pi/6,4*pi/3,3*pi/2,5*pi/3,11*pi/6,2*pi];
    ax.XTickLabel = {'0','\pi/2','\pi','3\pi/2','2\pi'};
   set(sub1,'Fontsize',fontsize,'Fontweight','bold','Color',[0.8,0.8,0.8],'xlim',[0,2*pi]);
   ylabel(ax,'y','Fontsize',fontsize,'FontWeight','bold');
    xlabel(ax,'\theta','Fontsize',fontsize,'FontWeight','bold');
   
   
   
   %roving radius
   plot(sub2,[0,xn(n)],[0,yn(n)],'Linewidth',6,'color','k'); hold on;
   
   %roving marker
   plot(sub2,xn(n),yn(n),'Linewidth',6,'Marker','o','Linestyle','none','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',20); hold on;
   
   ylabel('y','Fontsize',fontsize,'FontWeight','bold');
   xlabel('x','Fontsize',fontsize,'FontWeight','bold');
   set(gca,'Fontsize',fontsize,'Fontweight','bold','Color',[0.8,0.8,0.8],'xlim',[-1,1]);
   
   
   %cyclin' text values
   strval = {' = 0',' = \pi/6',' = \pi/3',' = \pi/2',' = 2\pi/3',' = 5\pi/6',' = \pi',' = 7\pi/6',' = 4\pi/3',' = 3\pi/2',' = 5\pi/3',' = 11\pi/6',' = 2\pi'};
   str45 = strcat('\theta',strval(n));
   text(-2.279,.84,str45,'Fontsize',30,'Fontweight','bold','Color','r');
   text(-2.279,.725,['y = ', num2str(round(y(n),5))],'Fontsize',30,'Fontweight','bold','Color','r');
   
   
   %img saving
   figsave = 1;
   %gate
   if(figsave==1)
    str = '/Users/NicII/Documents/Trig_plots';
    mkdir(str);
    filename = [str,'/','Trig_Plot',num2str(n),'.png'];
    set(gcf,'Position',[ 1          80        1440         726]);
    
    figgy = gcf;
    figgy.PaperPosition = [0.2500    2.5000    8.0000    6.0000];
%   figgy.PaperPositionMode = 'manual';
    %export_fig(filename,gcf);
    %saveas(gcf,filename);
    img1 = getframe(gcf);
    imwrite(img1.cdata, [filename]);
   end
end

ylabel('y','Fontsize',fontsize,'FontWeight','bold');
xlabel('x','Fontsize',fontsize,'FontWeight','bold');   
%set(gca,'Fontsize',fontsize,'Fontweight','bold','Color',[0.8,0.8,0.8],'xlim',[0,pi]);



%% Time to make that video!!!!
%video making

%gate
vidsave = 1;

if vidsave==1
workingDir = str;
imageNames = dir(fullfile(workingDir,'Trig_Plot','*.png'));
imageNames = {imageNames.name}';

outputVideo = VideoWriter(fullfile(workingDir,'trig_mov.mp4'),'MPEG-4');
outputVideo.FrameRate = 2;
%outputVideo.FrameRate = trigvideo.FrameRate;
open(outputVideo);
%Loop through the image sequence, load each image, and then write it to the video.

set(gcf,'Renderer','Painters');
%set(gcf,'Position',[197         326        1123         468]);
for ii = 1:length(x)
   img = imread(['/Users/NicII/Documents/Trig_Plots/Trig_Plot',num2str(ii),'.png']);
   size(img)
   set(gcf,'Renderer','Painters');
    s%et(gcf,'Position',[197         326        1123         468]);
    f(ii) = im2frame(img);
   
end

writeVideo(outputVideo,f)
close(outputVideo);
end














