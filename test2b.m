% test2b stands for GA_VCO_3stage  for Channel Widths , 'V3b.sp' ,with GA
function ObjVal = test2b(BestPosition)      
%% BestPositionrite into input .sp file
           
          
           fidIn=fopen('D:\Users\farshid\Documents\MATLAB\V3b.sp','r+');
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
           
    
                            
           fclose('all');
           
%% run hspice 
            !C:\synopsys\Hspice_D-2010.03-SP1\BIN\hspice.exe  -i D:\Users\farshid\Documents\MATLAB\V3b.sp   -o D:\Users\farshid\Documents\MATLAB\V3b
            
%% read data from .lis file 
           
           fidout=fopen('D:\Users\farshid\Documents\MATLAB\V3b.lis','r+');
           B=fread(fidout);
           so = char(B');       
           
           pos=strfind(so,'avgpower');
           fseek(fidout,pos(1)+11,'bof');
           ObjVal=fscanf(fidout,'%f');
              
                   
           fclose('all'); 
           
end   
% End of function