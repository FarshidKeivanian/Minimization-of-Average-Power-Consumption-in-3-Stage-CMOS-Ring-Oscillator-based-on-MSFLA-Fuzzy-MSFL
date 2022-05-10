function Z = evolve_towards_pxpb(Pw, Pb, Smax)

C1 = 1.0;
C2 = 2.0;

S = max(min(C1 * rand * (Pw.Pbest.X - Pw.X) + ...
    C2 * rand *(Pb.X-Pw.X),Smax),-Smax);
Z = Pw.X + S;