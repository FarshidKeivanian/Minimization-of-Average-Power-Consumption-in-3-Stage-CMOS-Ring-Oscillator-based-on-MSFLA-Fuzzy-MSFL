%  test6b stands for SFLA_VCO_3stage  for Channel Widths and Temparature, 'T3b.sp' ,with
%  SFLA
function ObjVal = test6b(BestPosition)


%% BestPositionrite into input .sp file
           
          
           fidIn=fopen('D:\Users\farshid\Documents\MATLAB\T3b.sp','r+');
           ach=fread(fidIn);
           pchar=char(ach');
           
           
            pos=strfind(pchar,'MN1');
           fseek(fidIn,pos+35,'bof');
           fprintf(fidIn,'%5f',BestPosition(1));   
           
           
           pos=strfind(pchar,'MN2');
          fseek(fidIn,pos+35,'bof');
          fprintf(fidIn,'%5f',BestPosition(2));   
           
           
      pos=strfind(pchar,'MN3');
        fseek(fidIn,pos+35,'bof');
         fprintf(fidIn,'%5f',BestPosition(1));   
           
         pos=strfind(pchar,'MN4');
       fseek(fidIn,pos+35,'bof');
        fprintf(fidIn,'%5f',BestPosition(2));   
           
       pos=strfind(pchar,'MN5');
      fseek(fidIn,pos+35,'bof');
       fprintf(fidIn,'%5f',BestPosition(1));   
           
           
       pos=strfind(pchar,'MN6');
         fseek(fidIn,pos+35,'bof');
       fprintf(fidIn,'%5f',BestPosition(2));   
           
    %% Temparature Variable (3rd variable)
   %   fidIn=fopen('D:\Users\farshid\Documents\MATLAB\T3b.sp','r+');
      %     ach=fread(fidIn);
         %  pchar=char(ach');
    
           
      %% Its ok              
        pos=strfind(pchar,'.TE');
        fseek(fidIn,pos+6,'bof');    %Yeki Zudtar at Addad, pos mizarim
       fprintf(fidIn,'%5f',BestPosition(3));  
                         
           fclose('all');
              
         
           %%
           
%% run hspice 
            !C:\synopsys\Hspice_D-2010.03-SP1\BIN\hspice.exe  -i D:\Users\farshid\Documents\MATLAB\T3b.sp   -o D:\Users\farshid\Documents\MATLAB\T3b
            
%% read data from .lis file 
           
           fidout=fopen('D:\Users\farshid\Documents\MATLAB\T3b.lis','r+');
           B=fread(fidout);
           so = char(B');       
           
           pos=strfind(so,'avgpower');
           fseek(fidout,pos(1)+11,'bof');
           ObjVal=fscanf(fidout,'%f');
                                 
           fclose('all'); 
           
%fv = atan(f) - pi/2;

%h = zeros(1,4);

%h(1) = BestPosition(1) - 2;
%h(2) = BestPosition(2) - 2;
%h(3) = BestPosition(3) - 50;
%h(4) = 0.2 - BestPosition(2);

%hmax = max(h);

%if hmax > 0
  %  ObjVal = hmax;
%else
   % ObjVal = fv;
end