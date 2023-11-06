%%PRACTICA 1 EJERCICIO 4
%%
clc
clear all
close all
warning off all

a=imread("peppers.png");

[filas, columnas, colores]=size(a);

%Rojo
%Linea Completa izquierda
a(:,1:(columnas/5),1);
a(:,1:(columnas/5),2)=0;
a(:,1:(columnas/5),3)=0;
%Cubito rojo de la esquina
a(1:(filas/4),(columnas/5):((columnas/5)*2),1);
a(1:(filas/4),(columnas/5):((columnas/5)*2),2)=0;
a(1:(filas/4),(columnas/5):((columnas/5)*2),3)=0;

%Azul
%Linea semicompleta izquierda
a((filas/4):filas,(columnas/5):((columnas/5)*2),1)=0;
a((filas/4):filas,(columnas/5):((columnas/5)*2),2)=0;
a((filas/4):filas,(columnas/5):((columnas/5)*2),3);
%Cubito superior de enmedio
a(1:(filas/4),((columnas/5)*2):((columnas/5)*3),1)=0;
a(1:(filas/4),((columnas/5)*2):((columnas/5)*3),2)=0;
a(1:(filas/4),((columnas/5)*2):((columnas/5)*3),3);
%Cubito inferior de enmedio
a(((filas/4)*2):((filas/4)*3),((columnas/5)*2):((columnas/5)*3),1)=0;
a(((filas/4)*2):((filas/4)*3),((columnas/5)*2):((columnas/5)*3),2)=0;
a(((filas/4)*2):((filas/4)*3),((columnas/5)*2):((columnas/5)*3),3);
%Linea semicompleta derecha
a((filas/4):filas,((columnas/5)*3):((columnas/5)*4),1)=0;
a((filas/4):filas,((columnas/5)*3):((columnas/5)*4),2)=0;
a((filas/4):filas,((columnas/5)*3):((columnas/5)*4),3);

%Negro
%Cubito superior
a((filas/4):((filas/4)*2),((columnas/5)*2):((columnas/5)*3),1)=0;
a((filas/4):((filas/4)*2),((columnas/5)*2):((columnas/5)*3),2)=0;
a((filas/4):((filas/4)*2),((columnas/5)*2):((columnas/5)*3),3)=0;
%Cubito inferior
a(((filas/4)*3):filas,((columnas/5)*2):((columnas/5)*3),1)=0;
a(((filas/4)*3):filas,((columnas/5)*2):((columnas/5)*3),2)=0;
a(((filas/4)*3):filas,((columnas/5)*2):((columnas/5)*3),3)=0;

%Verde
%Cubito verde de la esquina
a(1:(filas/4),((columnas/5)*3):((columnas/5)*4),1)=0;
a(1:(filas/4),((columnas/5)*3):((columnas/5)*4),2);
a(1:(filas/4),((columnas/5)*3):((columnas/5)*4),3)=0;
%Linea completa derecha
a(:,((columnas/5)*4):columnas,1)=0;
a(:,((columnas/5)*4):columnas,2);
a(:,((columnas/5)*4):columnas,3)=0;

imshow(a)