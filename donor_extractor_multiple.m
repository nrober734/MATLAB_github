%% Campaign finance extractor
%pulls donor info from the web using getTableFromWeb script

%setup to run through all donors on the page

clear all; close all; clc;
%% Identify current working URL and navigate

%Manual settings
url = 'http://miboecfr.nictusa.com/cgi-bin/cfr/contrib_anls_res.cgi?doc_seq_no%3D359653%26doc_stmnt_year%3D2012%26com_id%3D515614%26doc_date_proc%3D++++++++++%26sched%3D%2A%26doc_type_code%3DP1%26caller%3Dcf_online';

%number of total entries
numentry = 101;



web(url), pause(10); %nav
getTableFromWeb, pause(10); 
%% Read in data
counter = 0;
for k = 2:numentry
entry = getTableFromWeb(k);

%entry(2) = type of contribution
%entry(3) = name and address glued together
%entry(4) = city and zip

%% Clean up data

%test for numeric values and break

block = entry(3);
block = block{1};
for i = 1:length(block)
   if isstrprop(block(i),'digit')
       c = i;
       break;
   end
end

name = block(1:c-1);

%process name
for i = 1:length(name)
    
    if(name(i)==' ')
        sp = i;
    end
end

first = name(1:sp);
last = name(sp+1:end);



block = block(c:end);

    



%trim for street name
for i = 1:length(block)-2
    clear n;
    test1 = (block(i:i+2)==' RD');
    test2 = (block(i:i+2)==' DR');
    test3 = (block(i:i+2)==' ST');
   % test4 = (block(i:i+3)==' AVE');
    test = 0;
    for nn = 1:length(test1)
        if test1(nn)==1 || test2(nn)==1 || test3(nn)==1
            test = test +1;
        end
    end
    
    
    
    
    if test==3
        n = i;
        break;
    else
        n = 0;
    
    end
end

if n>0

counter = counter + 1;
k;
street = block(1:n+2);

%get city info

block2 = entry(4);
block2 = block2{1};

for i = 1:length(block2)-1
    
    if block2(i:i+1)=='  '
        d = i;
        break;
    end
end

city = block2(1:d-1);

%get zip


for i = 1:length(block2)
   if isstrprop(block2(i),'digit')
       c = i;
       break;
   end
end

zip = block2(c:c+4);
state = block2(c-3:c-2);

%% Additional cleaning conditionals
kirk = 1;
schuette = 0;
snyder = 0;
leonard = 0;

clinton = [
 48808
48820
48822
48831
48833
 48835
48853
48866
 48879
48894
48906];

gratiot = [
    
 48615
 48662
 48801
 48806
48807
 48830
 48832
48847
 48856
 48862
 48871
 48874
 48877
 48880
 48889
];

valid = 0;
if kirk~=1 && leonard~=1
    for y = 1:length(clinton)
        if str2num(zip)==clinton(y)
            
            valid = valid + 1;
            
        end
    end
    
    for y = 1:length(gratiot)
        if str2num(zip)==gratiot(y)
            valid = valid +1;
        end
    end
    
end
    
if kirk==1 || leonard==1
    
    valid = 1;
    
end
    

%% clean dupes just before writing

if valid==1
  
wlast{counter,1} = last; 
wfirst{counter,1} = first; 
wstreet{counter,1} = street; 
wcity{counter,1} = city; 
wstate{counter,1} = state; 
wzip{counter,1} = zip; 


donor = [wlast]; donor = [donor wfirst]; donor = [donor wstreet];  donor = [donor wcity]; donor = [donor wstate]; donor = [donor wzip];
donor = cellstr(donor);
t = cell2table(donor,...
    'VariableNames',{'Last','First','Address','City','State','Zip'});


end


end %if
end %k


writetable(t,'Kirk_1.csv');

%% Verify information - get zip code metrics

wzip2 = wzip;
empty = 0;

for k = 1:length(wzip2)
    empty = 0;
    if isempty(wzip2{k})
        empty = empty + 1;
    end
end

k = 0;
count2 = 0;
while empty~=length(wzip2) && k ~=length(wzip2)
    
     empty = 0;
    for kk = 1:length(wzip2)
   
    if isempty(wzip2{kk})
        empty = empty + 1;
    end
    
    end


    k = k + 1;
    %conditional for empty iteration entry
    
    
    count = 0; clear index;
    
    if ~isempty(wzip2{k})
    count2 = count2 + 1;
        
    for n = 1:length(wzip2)
        
    if ~isempty(wzip2{n})    
    test = wzip2{k}==wzip2{n};
    c = 0;
    %loop to iterate over test
    for j = 1:length(test)
        if test(j)==1
            c = c +1;
        end
        
    end
    
    
   
    %conditional for correctness
    if c==5
        count = count + 1;
       index(count) = n;
       
    end
    
   
    
    
    
    end
    end
     for jj = 1:length(index)
       
       
       wzipfinal{count2} = wzip2{index(jj)};
       wzipfreq(count2) = count;
       wzip2{index(jj)}= [];
       
      
    end
   
    
    
    
    end
    
    
    
end
     
   

%generate report

for x = 1:length(wzipfinal)
    temp = str2num(wzipfinal{x});
    zipf(x,1) = temp;
end


%zipf = reshape(wzipfinal, length(wzipfinal),1);
zipfreq = reshape(wzipfreq,length(wzipfreq),1);

clc;
disp('Zip Code Metrics');
report = horzcat(zipf, zipfreq)
total = sum(wzipfreq)
%FINALLY!!!!!!!!!!!!!! DONE! DONE! DONE! DONE!
  
   
%end



% %% Save to Excel sheet
% 
% filename = 'donortest.xls';
% 
% % last = {last};
% % first = {first};
% % street = {street};
% % city = {city};
% % state = {state};
% % zip = {zip};
% donor = {last,first,street,city,state,zip};
% donor = cellstr(donor);
% t = cell2table(donor);
% writetable(t,'donortest.csv');
% 
% end %k


    

