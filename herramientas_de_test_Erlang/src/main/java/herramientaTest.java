/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;
/**
 *
 * @author ricardadriaponsramos
 */
public class herramientaTest {
    
    public static void main (String [] args ){
        
        
        Scanner sn = new Scanner(System.in);
        boolean out = false;
        int option;
        String module;
        while(!out){
                System.out.println("1. EUnit");
                System.out.println("2. Salir");
            
                System.out.println("Escribe una de las opciones");
                option = sn.nextInt();
            
           switch(option){
               case 1:
                   ShellCommands.shellComm1();
                   
                    
                   break;
              
                case 2:
                   out=true;
                   break;
        
        
        
        }
        
        
        }
        
        
        
        
        
        
        
       
        
        
        }
    
    
    
    
    
    
    
    }
    

