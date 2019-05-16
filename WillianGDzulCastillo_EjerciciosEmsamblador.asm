;ALUMNO: WILLIAN GUSTAVO DZUL CASTILLO M.16070002
;ING EN SISTEMAS COMPUTACIONALES
;LENGUAJES Y AUTOMATAS II
;MAESTRO: JOSE LEONEL PECH MAY
;INSTITUTO TECNOLOGICO SUPERIOR DE VALLADOLID


.MODEL SMALL

    org 100h
    include 'emu8086.inc' 
    DEFINE_SCAN_NUM
    DEFINE_PRINT_STRING
    DEFINE_PRINT_NUM
    DEFINE_PRINT_NUM_UNS
 
 
jmp inicio1
 
menu1 db 13,10, 'OPERACIONES BASICAS',13,10,
      db 13,10,'1-.Suma ',13,10,
      db 13,10,'2-.Resta ' ,13,10,
      db 13,10,'3-.Multiplicacion ',13,10,
      db 13,10,'4-.Division ',13,10,                         

 
    texto1 db 13,10,13,10,'Ingrese el Primer Numero: $' 
    texto2 db 13,10,13,10,'Ingrese el Segundo Numero: $'
    texto3 db 13,10,13,10, 'La Suma = $' 
    texto4 db 13,10,'La Resta = $' 
    texto5 db 13,10,'La Multiplicacion = $' 
    texto6 db 13,10,'La Division = $'  

    num1 dw ? 
    num2 dw ?

;______________________________________

    msj1 db 0ah,0dh, 'Ingrese 3 numeros', '$'
    msj2 db 0ah,0dh, 'Primer Numero: ', '$'
    msj3 db 0ah,0dh, 'Segundo Numero: ', '$'
    msj4 db 0ah,0dh, 'Tercer Numero: ', '$'
    Mayor db 0ah,0dh,'El Numero Mayor Es: ', '$'
    
    Digito1 db 100 dup('$')
    Digito2 db 100 dup('$')
    Digito3 db 100 dup('$')
    
    salto db 13,10,'',13,10,'$'

;______________________________________

.DATA 

    mj1 db "MENU DE OPERACIONES","$"
    mj2 db "1 OPERACIONES BASICAS","$"
    mj3 db "2 NUMERO MAYOR","$"    
    mj6 db "SELECCIONE UNA OPCION:","$"  


.CODE salta
     
     MOV AX,@DATA
     MOV DS,AX  
      
     inicio1:
     
     
     MOV AX,0600H   
     MOV BH,00FH   
     MOV CX,0000H                                   
     MOV DX,184FH
     INT 10H
   

;---------------------------
     
     MOV AX,0600H   
     MOV BH,0FH   
     MOV CX,0316H                                   
     MOV DX,0438H
     INT 10H  
;---------------------------
     MOV AX,0600H   
     MOV BH,0FH   
     MOV CX,0616H                                   
     MOV DX,1038H
     INT 10H
;---------------------------
     
     MOV AH,02H
     MOV BH,0    
     MOV DH,04H
     MOV DL,1EH
     INT 10H 
  
     
     MOV AH,09H
     LEA DX,mj1
     INT 21H 
     
;----------------------------   
     MOV AH,02H
     MOV BH,0      
     MOV DH,07H
     MOV DL,0BH 
     INT 10H 
  
     MOV AH,09H
     LEA DX,mj2
     INT 21H  
;---------------------------- 

     MOV AH,02H
     MOV BH,0      
     MOV DH,07H
     MOV DL,2CH 
     INT 10H 
     
     MOV AH,09H
     LEA DX,mj3
     INT 21H
;----------------------------
     MOV AH,02H
     MOV BH,0  
     MOV DH,0AH
     MOV DL,0BH
     INT 10H 
     
     MOV AH,09H
     LEA DX,mj6
     INT 21H   
     
;---------------------------- 

     MOV AH,0H
     INT 16H   
     
     CMP AL,49
     JE ARITMETICOS
     
     CMP AL,50
     JE NUMEROMAYOR 
          
     fin:
     mov ax,4c00h
     int 21h
     
     ARITMETICOS:
     
     MOV AH,05H
     MOV AL,0
     INT 10H  
     
     MOV AX,0600H   
     MOV BH,0FH   
     MOV CX,0000H                                   
     MOV DX,184FH
     INT 10H 
       
     MOV AH,02H
     MOV BH,0      
     MOV DH,01H
     MOV DL,23H
     INT 10H
;------------------------------------    
    inicio:
    
    mov ah,09H 
    lea dx,menu1 
    int 21h 
     
    call SCAN_NUM 
    mov num1,cx ;mueve numero a variable num1 
     
    mov ah,09H 
    lea dx,texto2 ;carga cadena de texto 2 en dx 
    int 21h 
     
    call SCAN_NUM ;Llama Funcion SCAN_NUM 
    mov num2,cx ;mueve numero a variable num2 
    
     
    mov ah,09H 
    lea dx,texto3
    int 21h 
     
    mov ax,num1 
    add ax,num2 
    call PRINT_NUM 
     
    mov ah,09H 
    lea dx,texto4
    int 21h 
    mov ax,num1 
    sub ax,num2 
    call PRINT_NUM 
      
    mov ah,09H 
    lea dx,texto5
    int 21h 
    mov ax,num1 
    mov bx,num2 
    mul bx ;ax = ax*bx
    call PRINT_NUM 
     
    mov ah,09 
    lea dx,texto6
    int 21h 
    xor dx,dx ;deja en cero dx; si no lo hago se desborda la division
    mov ax,num1 
    mov bx,num2 
    div bx ;ax = ax*bx
    call PRINT_NUM
;------------------------------------   
 
    cmp bl,0  
     MOV AH,0H
     INT 16H
     
     CMP AL,08
     JE inicio1      
     JMP fin
     
     NUMEROMAYOR:
     
     MOV AH,05H
     MOV AL,0
     INT 10H
     
     MOV AX,0600H   
     MOV BH,0FH   
     MOV CX,0000H                                   
     MOV DX,184FH
     INT 10H       
     
     MOV AH,02H
     MOV BH,0      
     MOV DH,01H
     MOV DL,23H
     INT 10H
;__________________________________________        

    mov si,0
    mov ax,@data
    mov ds,ax
    mov ah,09h
    mov dx,offset msj1  
    int 21h   
    
;-------------------------------------------
    call saltodelinea
    mov ah,09h
    mov dx,offset msj2
    int 21h
    call pedircaracter 
;-------------------------------------------  
    
    mov Digito1,al 
;-------------------------------------------
    call saltodelinea 
    mov ah,09h
    mov dx,offset msj3
    int 21h
    call pedircaracter 
;-------------------------------------------
                       
    mov Digito2,al
;-------------------------------------------
    call saltodelinea 
    mov ah,09h
    mov dx,offset msj4
    int 21h 
    call pedircaracter
;-------------------------------------------
    
    mov Digito3,al
    call saltodelinea
    
    ;COMPARAMOS
    
    mov ah,digito1
    mov al,digito2
    cmp ah,al
    ja compara-1-3 
    jmp compara-2-3 
    compara-1-3:
    mov al,digito3 
    cmp ah,al 
    ja mayor1 
    
    compara-2-3:
    mov ah,digito2
    mov al,digito3
    cmp ah,al 
    ja mayor2 
    jmp mayor3
    
     
    mayor1:
    
    call MensajeMayor 
    mov dx, offset Digito1 
    mov ah, 9
    int 21h
    jmp exit
    
    mayor2:
    call MensajeMayor
    mov dx, offset Digito2 
    mov ah, 9
    int 21h
    jmp exit
    
    mayor3:
    call MensajeMayor
    mov dx, offset Digito3 
    mov ah, 9
    int 21h
    jmp exit 
    
;------------------------------------   
    
    ;METODOS
    
    MensajeMayor:
    mov dx, offset Mayor
    mov ah, 9
    int 21h
    
    ret
    pedircaracter:
    mov ah,01h
    int 21h
    ret
    
    saltodelinea:
    mov dx, offset salto
    mov ah, 9
    int 21h
    ret     
    
    exit:
    mov ax, 4c00h
    int 21h 
    ends                                                    
    
;______________________________________                                               
     
     MOV AH,0H
     INT 16H
     
     CMP AL,08
     JE inicio1 
     JMP fin    
     
END