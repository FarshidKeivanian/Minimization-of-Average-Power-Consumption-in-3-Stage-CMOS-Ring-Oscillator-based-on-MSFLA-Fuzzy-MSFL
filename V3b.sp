.Options list Node Post

.Option Scale=1U

VDD VDD 0  Vs
MN1 2 1 VDD VDD PCH L=0.18        W=1.4712342                                                                                           
MN2 2 1 0 0  NCH L=0.18           W=0.2027242                                                                                       
MN3 3 2 VDD VDD PCH L=0.18        W=1.4712342                                                                                      
MN4 3 2 0 0 NCH L=0.18            W=0.2027242                                                                                             
MN5 1 3 VDD VDD PCH L=0.18        W=1.4712342                                                                                                      
MN6 1 3 0 0 NCH L=0.18            W=0.2027242                                                                                                                
     
.MODEL PCH PMOS LEVEL=1
.MODEL NCH NMOS LEVEL=1  

.PRINT TRAN POWER

.TEMP  25
.param Vs=5

.MEAS tran avgpower Avg Power from = 200p to = 200n
.MEAS tran maxpower max Power

.Tran 200p 200n
.PRINT TRAN V(1)
.END