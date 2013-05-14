/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package prograprolog_lenguajes;
import java.util.ArrayList;
import jpl.Query;
import jpl.fli.Prolog;
//import alice.tuprolog.*;
/**
 *
 * @author jeny
 */
public class ClaseJuguetes {
    private Prolog engine;
	private int lastid = 0;
    


public ClaseJuguetes(){
		this.engine = new Prolog();
		this.lastid = 0;
	}
public void agregarJuguete(String nombre,String marca, int precio, int edad) {
		int newid = this.lastid+1;
		try{
			
			String q = "juguete("+nombre+","+marca+","+precio+","+edad+").";
			System.out.println("QUERY_INSERT > " + q);
			Query t = new Query(q);
			//this.engine.addQuery(t);
		}/* catch( e) {
			System.out.println("ERROR > No se pudo agregar el nuevo juguete");
			e.printStackTrace();
		}*/ catch(Exception er) {
		}
		System.out.println("Se agrego el juguete " + nombre + " a la base de conocimiento");
		this.lastid++;
 }
}