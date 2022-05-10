.Options list Node Post

VDD VDD 0  Vs
MN1 2 1 VDD VDD PCH L=0.18U        W=1.4157042U                                                                                           
MN2 2 1 0 0  NCH L=0.18U           W=1.0432432U                                                                                       
MN3 3 2 VDD VDD PCH L=0.18U        W=1.4157042U                                                                                      
MN4 3 2 0 0 NCH L=0.18U            W=1.0432432U                                                                                            
MN5 1 3 VDD VDD PCH L=0.18U        W=1.4157042U                                                                                                      
MN6 1 3 0 0 NCH L=0.18U            W=1.0432432U                                                                                                                
     
.MODEL PCH PMOS LEVEL=1
.MODEL NCH NMOS LEVEL=1  

.PRINT TRAN POWER


.TEMP  18.506873

.param Vs=5.542248AS tran avgpower Avg Power from = 200p to = 200n
.MEAS tran maxpower max Power

.Tran 200p 200n
.PRINT TRAN V(1)
.END