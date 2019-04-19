gap> # These commands can be pasted into a GAP session and run to show output.

gap> # ┌───────┐   GAP v4.8.6-864-ged278b8 of 2016-11-16 10:58:08 (GMT)
gap> # │  GAP  │   https://www.gap-system.org
gap> # └───────┘   Architecture: x86_64-pc-linux-gnu-gcc-default64
gap> # Libs used:  gmp 6.1.2
gap> # Loading the library and packages ...
gap> # Components: trans 1.0, prim 3.0, small* 1.0, id* 1.0
gap> # Packages:   Digraphs 0.6.0, GAPDoc 1.5.1, genss 1.6.4, GRAPE 4.7, IO 4.4.6, orb 4.7.6, Semigroups 3.0.0
gap> # Try '??help' for help. See also '?copyright', '?cite' and '?authors'



gap> # Basic operations
gap> 3 + 2;
gap> 2 ^ 100;
gap> 2 ^ (2 ^ (2 ^ (2 ^ 2)));
gap> x := 12345 ^ 67890;
gap> x mod 3;
gap> x mod 100;
gap> x mod 10^10;
gap> 5 / 3;
gap> (3 / 10) * (20 / 3);
gap> Binomial(14, 4);



gap> # Rubik's cube
gap> t := [1..9];;
gap> bo:= [1..9] + 9*1;;
gap> l := [1..9] + 9*2;;
gap> r := [1..9] + 9*3;;
gap> f := [1..9] + 9*4;;
gap> ba:= [1..9] + 9*5;;
gap> PrintArray([t, bo, l, r, f, ba]);
gap> Concatenation([t, bo, l, r, f, ba]);
gap> Concatenation([t, bo, l, r, f, ba]) = [1..54];
gap> top_twist :=    ( t[1],  t[3],  t[9],  t[7])
>                    ( t[2],  t[6],  t[8],  t[4])
>                    (ba[1],  r[1],  f[1],  l[1])
>                    (ba[2],  r[2],  f[2],  l[2])
>                    (ba[3],  r[3],  f[3],  l[3]);;

gap> bottom_twist := (bo[1], bo[3], bo[9], bo[7])
>                    (bo[2], bo[6], bo[8], bo[4])
>                    ( f[7],  l[7], ba[7],  r[7])
>                    ( f[8],  l[8], ba[8],  r[8])
>                    ( f[9],  l[9], ba[9],  r[9]);;

gap> left_twist :=   ( l[1],  l[3],  l[9],  l[7])
>                    ( l[2],  l[6],  l[8],  l[4])
>                    ( t[1],  f[1], bo[7], ba[9])
>                    ( t[4],  f[4], bo[4], ba[6])
>                    ( t[7],  f[7], bo[1], ba[3]);;

gap> right_twist :=  ( r[1],  r[3],  r[9],  r[7])
>                    ( r[2],  r[6],  r[8],  r[4])
>                    ( t[9], ba[1], bo[3],  f[9])
>                    ( t[6], ba[4], bo[6],  f[6])
>                    ( t[3], ba[7], bo[9],  f[3]);;

gap> front_twist :=  ( f[1],  f[3],  f[9],  f[7])
>                    ( f[2],  f[6],  f[8],  f[4])
>                    ( t[7],  r[1], bo[9],  l[9])
>                    ( t[8],  r[4], bo[8],  l[6])
>                    ( t[9],  r[7], bo[7],  l[3]);;

gap> back_twist :=   (ba[1], ba[3], ba[9], ba[7])
>                    (ba[2], ba[6], ba[8], ba[4])
>                    ( t[1],  l[7], bo[3],  r[3])
>                    ( t[2],  l[4], bo[2],  r[6])
>                    ( t[3],  l[1], bo[1],  r[9]);;

gap> gens := [top_twist, bottom_twist, left_twist,
>             right_twist, front_twist, back_twist];;
gap> for gen in gens do Print(gen,"\n"); od;
gap> rubiks_group := Group(gens);
gap> Size(rubiks_group);
gap> Orbits(rubiks_group);
gap> List(Orbits(rubiks_group), Set);
gap> perm := Random(rubiks_group);



gap> # Digraphs
gap> gr := Digraph([[2, 3], [1], [], [4]]);
gap> Splash(DotDigraph(gr));
gap> sym := DigraphSymmetricClosure(gr);
gap> Splash(DotDigraph(sym));
gap> Splash(DotSymmetricDigraph(sym));
gap> IsEulerianDigraph(gr);
gap> DiSparse6String(gr);
gap> aut := AutomorphismGroup(gr);
gap> gr := RandomDigraph(6);
gap> Splash(DotDigraph(gr));
gap> gr := EmptyDigraph(10);
gap> gr := CompleteDigraph(10);
gap> gr := Digraph([[2], [1, 1]]);
gap> Splash(DotDigraph(gr));
gap> gr := CycleDigraph(15);
gap> Splash(DotDigraph(gr));
gap> gr := JohnsonDigraph(4, 2);
gap> Splash(DotDigraph(gr));
gap> Splash(DotSymmetricDigraph(gr));
gap> gr := ChainDigraph(5);
gap> Splash(DotDigraph(gr));
gap> Splash(DotSymmetricDigraph(gr));
gap> quit;
gap> is_edge := function(x, y) return x mod y = 2; end;
gap> gr := Digraph([1..15], is_edge);
gap> Splash(DotDigraph(gr));



gap> # Semigroups
gap> t1 := Transformation( [ 5, 3, 3, 3, 1 ] );
gap> t2 := Transformation( [ 5, 2, 5, 5, 1 ] );
gap> 2^t1;
gap> 2^t2;
gap> t1 * t2;
gap> S := Semigroup([t1, t2]);
gap> NrIdempotents(S);
gap> Size(S);
gap> Splash(DotDClasses(S));
gap> Splash(DotDClasses(S, rec(maximal := true)));
gap> d := DClasses(S);
gap> List(d, AsList);
gap> congs := CongruencesOfSemigroup(S);
gap> lattice := LatticeOfCongruences(S);
gap> Splash(DotString(lattice));
gap> Splash(DotString(lattice, rec(info := true)));
gap> Filtered(congs, IsReesCongruence);
gap> List(last, SemigroupIdealOfReesCongruence);
gap> List(congs, NrCongruenceClasses);



gap> # Gossip monoid
gap> gossip := GossipMonoid(3);
gap> Size(gossip);
gap> lattice := LatticeOfCongruences(gossip);;
gap> Splash(DotString(lattice, rec(info := true)));
gap> gossip := GossipMonoid(6);
gap> Size(gossip);
gap> time;
gap> NrIdempotents(gossip);
gap> big_gossip := GossipMonoid(20);
gap> NrIdempotents(big_gossip);



gap> # Bipartitions
gap> x := Bipartition([[1, 4, -5], [2, 3, -1, -2, -4], [5], [-3]]);
gap> y := Bipartition([[1, -3], [2, -4], [3, 5, -1], [4, -5], [-2]]);
gap> x * y;
gap> Splash(TikzString([x, y, x*y]));
gap> S := Semigroup([x, y]);
gap> Size(S);
