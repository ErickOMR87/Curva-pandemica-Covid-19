// constatntes
tiemposimu=40

R0=2.5
B=0.27
N=12920

Transmision=10e-11//infecciones/contacto
Contactos=   20//contactos/dia
Duracion=10//dias
// modelo SIR
    
function z=gSanos(t,Sanos,Infectados,Recuperados,totali)
    z=-Sanos*Infectados*(B/N);
endfunction

function z=gInfectados(t,Sanos,Infectados,Recuperados,totali)
    z=Sanos*Infectados*(B/N)-Infectados*(B/R0);
endfunction

function z=gRecuperados(t,Sanos,Infectados,Recuperados,totali)
    z=Infectados*(B/R0);
endfunction

function z=gtotali(t,Sanos,Infectados,Recuperados,totali)
    z=exp(((B/N)*Sanos-(B/R0))*t);
endfunction
//totali=exp(((B/N)*Sanos-(B/R0)))

//solucion euler

function [t,Sanos,Infectados,Recuperados,totali]=sistemaeuler(a,b,h,Sanos0,Infectados0,Recuperados0,totali0)
    t=a:h:b
    n=length(t);
    Sanos(1)=Sanos0
    Infectados(1)=Infectados0
    Recuperados(1)=Recuperados0
    totali(1)=totali0
    
    for i=1:n-1
        
        kSanos= gSanos(t(i),Sanos(i),Infectados(i),Recuperados(i),totali(i))
        kInfectados= gInfectados(t(i),Sanos(i),Infectados(i),Recuperados(i),totali(i))
        kRecuperados= gRecuperados(t(i),Sanos(i),Infectados(i),Recuperados(i),totali(i))
        ktotali= gtotali(t(i),Sanos(i),Infectados(i),Recuperados(i),totali(i))
        
        Sanos(i+1)=Sanos(i)+kSanos*h;
        Infectados(i+1)=Infectados(i)+kInfectados*h;
        Recuperados(i+1)=Recuperados(i)+kRecuperados*h;
        totali(i+1)=totali(i)+ktotali*h;;
    end
endfunction
[t,Sanos,Infectados,Recuperados,totali]=sistemaeuler(0,tiemposimu,0.005,N,1,0,1)

//plot(t,Sanos)
plot(t,Infectados)
Hospitalizados=Infectados*.16
Muertos=Infectados*0.031
//plot(t,Hospitalizados)
// plot(t,Recuperados)


   //https://saludconlupa.com/noticias/mapa-interactivo-la-epidemia-de-coronavirus-en-tiempo-real/
 dias=[1,3,5,6,7,8,9,10,11,12,13,14,15,16,17,20 ,23,24,25,26,27,28,29,30,31,32,33,34]
 casos=[1,1,3,1,3,10,9,22,16,18,10,13,14,7,9,43,102,51,38,70,110,132,131,145,102,121,163,178]
 totales=[3,4,4,5,5,6,6,6,7,11,11,25,40,81,92,315,366,404,474,584,716,847,992,1094,1215,1378,1510,1688]
 plot(dias,casos,"o")
//plot(t,Muertos)

plot(t,totali)

plot(dias,totales,"X")
