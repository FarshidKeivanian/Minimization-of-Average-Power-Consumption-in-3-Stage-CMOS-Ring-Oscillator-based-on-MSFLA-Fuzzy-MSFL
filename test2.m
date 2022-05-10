function ObjVal = test2(BestPosition)      
%% BestPositionrite into input .sp file
           
          
           fidIn=fopen('D:\Users\farshid\Documents\MATLAB\V3.sp','r+');
           ach=fread(fidIn);
           pchar=char(ach');
           
    
      pos=strfind(pchar,'Vs');
      fseek(fidIn,pos(2)+2,'bof');
      fprintf(fidIn,'%5f',BestPosition(1)); 
       
       
 
           
      %% Its ok              
        %pos=strfind(pchar,'.TE');
        %fseek(fidIn,pos+6,'bof');    Yeki Zudtar at Addad, pos mizarim
       %fprintf(fidIn,'%5f',BestPosition(1));  
                         
           fclose('all');
           
%% run hspice 
            !C:\synopsys\Hspice_D-2010.03-SP1\BIN\hspice.exe  -i D:\Users\farshid\Documents\MATLAB\V3.sp   -o D:\Users\farshid\Documents\MATLAB\V3
            
%% read data from .lis file 
           
           fidout=fopen('D:\Users\farshid\Documents\MATLAB\V3.lis','r+');
           B=fread(fidout);
           so = char(B');       
           
           pos=strfind(so,'avgpower');
           fseek(fidout,pos(1)+11,'bof');
           ObjVal=fscanf(fidout,'%f');
              
                   
           fclose('all'); 
           
end   
% End of function