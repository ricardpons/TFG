
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author ricardadriaponsramos
 */
public class ShellCommands {
    public static  void shellComm1(){
    ProcessBuilder p1 = new ProcessBuilder();
    p1.command("bash","-c","cd /Users/ricardadriaponsramos/Documents/TFG/src;  erl -noshell -pa . -eval \"eunit:test(greet, [debug_info])\" -s init stop ");
                    try {
        
                            Process pro1 = p1.start();
                            StringBuilder output = new StringBuilder();
                            BufferedReader reader = new BufferedReader(
                            new InputStreamReader(pro1.getInputStream()));
            
            
                            String line;
                            while ((line = reader.readLine()) != null) {
                                output.append(line + "\n");
                            }
                
                            int exitVal = pro1.waitFor();
                            if (exitVal == 0) {
                                    System.out.println("Success!");
                                    System.out.println(output);
                                    System.exit(0);
                            } else {
			//abnormal...
                            }
                        } catch (IOException e) {
                                e.printStackTrace();
                        } catch (InterruptedException e) {
                                e.printStackTrace();
                        }
}}
    

